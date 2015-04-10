//
//  ScanDevicesVC.m
//  Imist
//
//  Created by chao.ou on 14/12/29.
//  Copyright (c) 2014年 oc. All rights reserved.
//

#import "ScanDevicesVC.h"
#import "MFSideMenu.h"
#import "BTServer.h"
#import "SettingVC.h"
#import "activityView.h"
#import "ScanDeviceCell.h"
#import "SettingModeVC.h"
#import "SettingUser.h"
#import "SettingAlerm.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "ProgressHUD.h"
#import "Manager.h"

@interface ScanDevicesVC ()<UITableViewDataSource,UITableViewDelegate,BTServerDelegate,scanDeviceCellDelegate> {
    BOOL reloading;
    BOOL isTag;
    activityView *activety;
    NSInteger selectRow;
    BOOL initWork;
}
@property (strong,nonatomic)BTServer *defaultBTServer;
@property (strong, nonatomic) UITableView *deviceTable;
@property (strong, nonatomic) UITextField *txtInfo;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) PeriperalInfo *deleteItem;

@end


@implementation ScanDevicesVC
@synthesize deviceTable, txtInfo, refreshControl;
- (void)viewDidLoad {
    [super viewDidLoad];
    // setup navigationBar
    UIFont* naviFont = [UIFont boldSystemFontOfSize:20];
    
    //这里我们设置的是颜色，还可以设置shadow等，具体可以参见api
    NSDictionary * dict = [NSDictionary dictionaryWithObject:naviFont forKey:UITextAttributeFont];
    
    //大功告成
    self.navigationController.navigationBar.titleTextAttributes = dict;
    if(!self.title) self.title = @"Connect";
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake( 0, 0, 44, 44)];
    [leftBtn setImage:[UIImage imageNamed:@"menu-icon.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftSideMenuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //init device tableview
    UITableView *_table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,  self.view.frame.size.height) style:UITableViewStylePlain];
    _table.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                               UIViewAutoresizingFlexibleHeight);
    _table.delegate = self;
    _table.dataSource = self;
    _table.contentInset=UIEdgeInsetsMake(80, 0 ,0, 0);
    _table.showsVerticalScrollIndicator = NO;
    _table.separatorStyle=UITableViewCellSeparatorStyleNone;
    _table.backgroundColor=[UIColor clearColor];
    
    self.deviceTable=_table;
    [self.view addSubview:self.deviceTable];
    
    refreshControl = [[UIRefreshControl alloc]init];
    [refreshControl setTintColor:[UIColor greenColor]];
    [self.deviceTable addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    self.appDelegate.defaultBTServer.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(peripheralDidDisconnect:)
                                                 name:@"PERIPHERAL_DISCONNECT"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(peripheralDidReconnect:)
                                                 name:@"PERIPHERAL_RECONNECT"
                                               object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self.deviceTable reloadData];
    [self.navigationController setToolbarHidden:YES animated:NO];
    
}

#pragma mark -
#pragma mark - UIBarButtonItem Callbacks

- (void)leftSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
        //        [self setupMenuBarButtonItems];
    }];
}

#pragma mark -- btserver delegate
-(void)didStopScan
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [refreshControl endRefreshing];
        [self.deviceTable reloadData];
        if ([self.appDelegate.defaultBTServer.discoveredPeripherals count] <= 0) {
            self.title = @"No Device Found";
        }
    });
}
-(void)didFoundPeripheral
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [refreshControl endRefreshing];
        [self.deviceTable reloadData];
        if (reloading) {
            reloading = NO;
        }
        self.title = @"Connect";
    });
}
-(void)didReadvalue:(NSData*)data
{
    NSLog(@"data====%@",data);
    Byte *dataByte = (Byte *) [data bytes];
    if ([data length] > 0) {
        NSUInteger state = dataByte[2];
        if(self.appDelegate.defaultBTServer.selectPeripheralInfo.curCmd == GET_WATER_STATUS)
        {
            if (state == 0x00) {
                self.appDelegate.defaultBTServer.selectPeripheralInfo.water = [NSNumber numberWithInt:1];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WATER_STATUS_UPDATED" object:nil];
            }
            else if (state == 0xAA){
                self.appDelegate.defaultBTServer.selectPeripheralInfo.water = [NSNumber numberWithInt:0];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WATER_STATUS_UPDATED" object:nil];
            }
            if(self.appDelegate.defaultBTServer.selectPeripheralInfo.intentAction == INIT_SET_WORK_MODE ||
               self.appDelegate.defaultBTServer.selectPeripheralInfo.intentAction == SHOW_WORK_MODE){
                SettingUser *thirdViewController = [[SettingUser alloc] init];
                thirdViewController.title = self.appDelegate.defaultBTServer.selectPeripheralInfo.name;
                SettingModeVC *firstViewController = [[SettingModeVC alloc] init];
                firstViewController.title = self.appDelegate.defaultBTServer.selectPeripheralInfo.name;
                SettingAlerm *secondViewController = [[SettingAlerm alloc] init];
                secondViewController.title = self.appDelegate.defaultBTServer.selectPeripheralInfo.name;
                
                RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
                [tabBarController setViewControllers:@[firstViewController, secondViewController,thirdViewController]];
                [self customizeTabBarForController:tabBarController];
                tabBarController.title = self.appDelegate.defaultBTServer.selectPeripheralInfo.name;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController pushViewController:tabBarController animated:YES];
                });
            }

        }
        else if(self.appDelegate.defaultBTServer.selectPeripheralInfo.curCmd == SET_WORK_MODE){
            self.appDelegate.defaultBTServer.selectPeripheralInfo.workingMode = dataByte[2];
            //save mode
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self.appDelegate.defaultBTServer.selectPeripheralInfo];
            [defaults setObject:encodedObject forKey:self.appDelegate.defaultBTServer.selectPeripheralInfo.uuid];
            [defaults synchronize];

        }
        else if(self.appDelegate.defaultBTServer.selectPeripheralInfo.curCmd == GET_WORK_MODE){
            self.appDelegate.defaultBTServer.selectPeripheralInfo.workingMode = dataByte[2];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.deviceTable reloadData];
        });
    }
}
-(void)didDisconnect
{
    NSLog(@"disconncted%@", self.appDelegate.window.rootViewController.description);
    PeriperalInfo *pi = (PeriperalInfo*)[self.appDelegate.defaultBTServer.discoveredPeripherals objectAtIndex:selectRow];
    pi.state = @"disConnected";
    NSIndexPath * selectIndexPath = [NSIndexPath indexPathForRow:selectRow inSection:0];
    ScanDeviceCell *cell = (ScanDeviceCell*)[self.deviceTable cellForRowAtIndexPath:selectIndexPath];
    [cell setState:0];
    initWork = 0;
    self.appDelegate.defaultBTServer.selectPeripheralInfo.intentAction = IDLE;
    self.appDelegate.defaultBTServer.selectPeripheralInfo.workingMode = 0;
    //    [ProgressHUD show:@"disconnect from peripheral"];
}

#pragma mark -- table delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger n = [self.appDelegate.defaultBTServer.discoveredPeripherals count];
    return n;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ScanDeviceCell *cell = (ScanDeviceCell*)[tableView cellForRowAtIndexPath:indexPath];
    if([self.appDelegate.defaultBTServer.discoveredPeripherals count]>0){
    PeriperalInfo *pi = (PeriperalInfo*)[self.appDelegate.defaultBTServer.discoveredPeripherals objectAtIndex:indexPath.row];
    selectRow = indexPath.row;
    NSLog(@"%li",(long)indexPath.row);
    if ([pi.state isEqualToString:@"connected"]) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        NSMutableData* data = [NSMutableData data];
        if(self.appDelegate.defaultBTServer.selectPeripheralInfo.mode){
            if(self.appDelegate.defaultBTServer.selectPeripheralInfo.workingMode <= 1){
                NSUInteger query = 0xa1;
                [data appendBytes:&query length:1];
                NSUInteger imist = 0x00;
                [data appendBytes:&imist length:1];
                NSUInteger led = 0x00;
                [data appendBytes:&led length:1];
                NSUInteger color1 = 0x00;
                [data appendBytes:&color1 length:1];
                NSUInteger color2 = 0x00;
                [data appendBytes:&color2 length:1];
                NSUInteger color3 = 0x00;
                [data appendBytes:&color3 length:1];

                self.appDelegate.defaultBTServer.selectPeripheralInfo.intentAction = INIT_SET_WORK_MODE;
            }
            else{
                SettingUser *thirdViewController = [[SettingUser alloc] init];
                thirdViewController.title = pi.name;
                SettingModeVC *firstViewController = [[SettingModeVC alloc] init];
                firstViewController.title = pi.name;
                SettingAlerm *secondViewController = [[SettingAlerm alloc] init];
                secondViewController.title = pi.name;
                
                RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
                [tabBarController setViewControllers:@[firstViewController, secondViewController,thirdViewController]];
                [self customizeTabBarForController:tabBarController];
                tabBarController.title = pi.name;
                [self.navigationController pushViewController:tabBarController animated:YES];
                self.appDelegate.defaultBTServer.selectPeripheralInfo.intentAction =  SHOW_WORK_MODE;
            }
        }
        else{
            SettingUser *thirdViewController = [[SettingUser alloc] init];
            thirdViewController.title = pi.name;
            SettingModeVC *firstViewController = [[SettingModeVC alloc] init];
            firstViewController.title = pi.name;
            SettingAlerm *secondViewController = [[SettingAlerm alloc] init];
            secondViewController.title = pi.name;
            
            RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
            [tabBarController setViewControllers:@[firstViewController, secondViewController,thirdViewController]];
            [self customizeTabBarForController:tabBarController];
            tabBarController.title = pi.name;
            [self.navigationController pushViewController:tabBarController animated:YES];
            self.appDelegate.defaultBTServer.selectPeripheralInfo.intentAction =  SHOW_WORK_MODE;
        }
        
        self.appDelegate.defaultBTServer.selectPeripheralInfo.curCmd = GET_WATER_STATUS;
        [self.appDelegate.defaultBTServer writeValue:[self.appDelegate.defaultBTServer converCMD:data] withCharacter:[self.appDelegate.defaultBTServer findCharacteristicFromUUID:[CBUUID UUIDWithString:WRITE_CHARACTERISTIC]]];
    }else if([pi.state isEqualToString:@"disConnected"]) {
        for(PeriperalInfo * pi in self.appDelegate.defaultBTServer.discoveredPeripherals)
        {
            if([pi.state isEqualToString:@"connected"])
                return;
        }
        [self.appDelegate.defaultBTServer stopScan];
        [ProgressHUD show:@"connecting ..."];
        [self.appDelegate.defaultBTServer connect:self.appDelegate.defaultBTServer.discoveredPeripherals[indexPath.row] withFinishCB:^(CBPeripheral *peripheral, BOOL status, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [ProgressHUD dismiss];
                if (status) {
                    pi.state = @"connected";
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    NSData *encodedDataObject = [defaults objectForKey:pi.uuid];
                    PeriperalInfo *selectPi = (PeriperalInfo *)[NSKeyedUnarchiver unarchiveObjectWithData: encodedDataObject];
                    if (selectPi) {
//                        pi.water = selectPi.water;
                        pi.name = selectPi.name;
                        pi.userset2Hour = selectPi.userset2Hour;
                        pi.userset4Hour = selectPi.userset4Hour;
                        pi.userset8Hour = selectPi.userset8Hour;
                        pi.userset16Hour = selectPi.userset16Hour;
                        pi.mode = selectPi.mode;
                        pi.alert = selectPi.alert;
                        pi.doNotShowHint_UserMode = selectPi.doNotShowHint_UserMode;
                        pi.doNotShowHint_Relaxation = selectPi.doNotShowHint_Relaxation;
                        pi.doNotShowHint_Sleep = selectPi.doNotShowHint_Sleep;
                        pi.doNotShowHint_Energization = selectPi.doNotShowHint_Energization;
                        pi.doNotShowHint_Soothing = selectPi.doNotShowHint_Soothing;
                        pi.doNotShowHint_Concentration = selectPi.doNotShowHint_Concentration;
                        pi.doNotShowHint_Sensuality = selectPi.doNotShowHint_Sensuality;
                        self.appDelegate.defaultBTServer.selectPeripheralInfo = pi;
                        [self restoreSelPiUserset:pi.mode];
                    }else {
                        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:pi];
                        pi.userset2Hour = [[NSMutableDictionary alloc] init];
                        pi.userset4Hour = [[NSMutableDictionary alloc] init];
                        pi.userset8Hour = [[NSMutableDictionary alloc] init];
                        pi.userset16Hour = [[NSMutableDictionary alloc] init];
                        pi.doNotShowHint_UserMode = NO;
                        pi.doNotShowHint_Relaxation = NO;
                        pi.doNotShowHint_Sleep = NO;
                        pi.doNotShowHint_Energization = NO;
                        pi.doNotShowHint_Soothing = NO;
                        pi.doNotShowHint_Concentration = NO;
                        pi.doNotShowHint_Sensuality = NO;
                        pi.imist = [NSNumber numberWithInteger:50];
                        pi.ledlight = [NSNumber numberWithInteger:46];
                        pi.ledcolor = [NSNumber numberWithInteger:100];
                        pi.ledauto = [NSNumber numberWithInteger:0];
                        self.appDelegate.defaultBTServer.selectPeripheralInfo = pi;
                        [defaults setObject:encodedObject forKey:pi.uuid];
                        [defaults synchronize];
                        //[self restoreSelPiUserset:pi.mode];
                    }
                    
                    //[cell setState:1];
                    [ProgressHUD showSuccess:@"connected success!"];
                    NSMutableData* data = [NSMutableData data];
                    NSUInteger query = 0xa1;
                    [data appendBytes:&query length:1];
                    NSUInteger imist = 0x00;
                    [data appendBytes:&imist length:1];
                    NSUInteger led = 0x00;
                    [data appendBytes:&led length:1];
                    NSUInteger color1 = 0x00;
                    [data appendBytes:&color1 length:1];
                    NSUInteger color2 = 0x00;
                    [data appendBytes:&color2 length:1];
                    NSUInteger color3 = 0x00;
                    [data appendBytes:&color3 length:1];
                    
                    self.appDelegate.defaultBTServer.selectPeripheralInfo.intentAction = INIT_SET_WORK_MODE;
                    
                    self.appDelegate.defaultBTServer.selectPeripheralInfo.curCmd = GET_WATER_STATUS;
                    [self.appDelegate.defaultBTServer writeValue:[self.appDelegate.defaultBTServer converCMD:data] withCharacter:[self.appDelegate.defaultBTServer findCharacteristicFromUUID:[CBUUID UUIDWithString:WRITE_CHARACTERISTIC]]];
                }else{
                    [cell setState:0];
                    [ProgressHUD showError:@"connected failed!"];
                }
                [self.deviceTable reloadData];
            });
        }];
    }
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"ScanDeviceCell";
    ScanDeviceCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[ScanDeviceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if([self.appDelegate.defaultBTServer.discoveredPeripherals count] >0){
    PeriperalInfo *pi = (PeriperalInfo*)[self.appDelegate.defaultBTServer.discoveredPeripherals objectAtIndex:indexPath.row];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedDataObject = [defaults objectForKey:pi.uuid];
    PeriperalInfo *selectPi = (PeriperalInfo *)[NSKeyedUnarchiver unarchiveObjectWithData: encodedDataObject];
    if (selectPi) {
        if (selectPi.name && ![selectPi.name isEqualToString:@""]) {
             cell.name = selectPi.name;
        }else {
            cell.name = [NSString stringWithFormat:@"IMIST%ld",(long)indexPath.row+1];
        }
    }else {
        cell.name = [NSString stringWithFormat:@"IMIST%ld",(long)indexPath.row+1];
    }
    
    cell.index = indexPath;
    cell.delegate = self;
    cell.icon = @"ico_imist.png";
    [cell setStyle];
    if([pi.state isEqualToString: @"connected"]){
        if (pi == self.appDelegate.defaultBTServer.selectPeripheralInfo) {
            if(pi.workingMode>1){
                if (pi.water == [NSNumber numberWithInt:1]) {
                    [cell setState:1];
                }else {
                    [cell setState:2];
                }
            }
            else{
                if (pi.water == [NSNumber numberWithInt:1]) {
                    [cell setState:3];
                }else {
                    [cell setState:2];
                }
            }
        }
    }
    else{
        //[cell setState:0];
    }
    
    //    cell.topName.text = pi.name;
    //    cell.uuid.text = pi.uuid;
    //    cell.name.text = pi.localName;
    //    cell.service.text = pi.serviceUUIDS;
    //    cell.RSSI.text = [pi.RSSI stringValue];
    //    cell.RSSI.textColor = [UIColor blackColor];
    //    int rssi = [pi.RSSI intValue];
    //    if(rssi>-60){
    //        cell.RSSI.textColor = [UIColor redColor];
    //    }else if(rssi > -70){
    //        cell.RSSI.textColor = [UIColor orangeColor];
    //    }else if(rssi > -80){
    //        cell.RSSI.textColor = [UIColor blueColor];
    //    }else if(rssi > -90){
    //        cell.RSSI.textColor = [UIColor blackColor];
    //    }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.deleteItem = (PeriperalInfo*)[self.appDelegate.defaultBTServer.discoveredPeripherals objectAtIndex:indexPath.row];
    [self AlertView];
}

-(void)AlertView{
    UIAlertView *aview = [[UIAlertView alloc]initWithTitle:@"Delete diffuser?" message:@"Do you want to delete this diffuser?" delegate:self cancelButtonTitle:@"Confirm" otherButtonTitles:@"Cancel", nil];
    aview.delegate = self;
    [aview show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self.appDelegate.defaultBTServer.discoveredPeripherals removeObject:self.deleteItem];
            [self.deviceTable reloadData];
            break;
        case 1:
            [self.deviceTable reloadData];
        default:
            break;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedDataObject = [defaults objectForKey:self.deleteItem.uuid];
    PeriperalInfo *deletePi = (PeriperalInfo *)[NSKeyedUnarchiver unarchiveObjectWithData: encodedDataObject];
    if (deletePi) {
        [defaults removeObjectForKey:self.deleteItem.uuid];
        [defaults synchronize];
    }
}


#pragma cell delegate
-(void)btnClick:(NSInteger)index
{
    NSLog(@"cell====%ld",(long)index);
    [self.appDelegate.defaultBTServer disConnect];
    self.appDelegate.defaultBTServer.selectPeripheralInfo.manualDisconnect = YES;
}

- (void)refreshTable {
    //TODO: refresh your data
    dispatch_async(dispatch_get_main_queue(), ^{
    [self.deviceTable reloadData];
    });
    [self.appDelegate.defaultBTServer startScan];
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    //    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    //    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"first", @"second", @"third"];
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBadgeBackgroundColor:[UIColor clearColor]];
        //        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        index++;
    }
}

- (NSInteger)getCurModeCmd:(NSString*)modeString{
    NSInteger cmd = 0;
    if([modeString isEqualToString:@"Relaxation"]){
        cmd = 3;
    }
    else if([modeString isEqualToString:@"Sleep"]){
        cmd = 4;
    }
    else if([modeString isEqualToString:@"Energization"]){
        cmd = 5;
    }
    else if([modeString isEqualToString:@"Soothing"]){
        cmd = 6;
    }
    else if([modeString isEqualToString:@"Concentration"]){
        cmd = 7;
    }
    else if([modeString isEqualToString:@"Sensuality"]){
        cmd = 8;
    }
    
    else if([modeString isEqualToString:@"2 Hours"]){
        cmd = 9;
    }
    else if([modeString isEqualToString:@"4 Hours"]){
        cmd = 10;
    }
    else if([modeString isEqualToString:@"8 Hours"]){
        cmd = 11;
    }
    else if([modeString isEqualToString:@"16 Hours"]){
        cmd = 12;
    }
    
    return cmd;
    
}

- (void)restoreSelPiUserset:(NSString*)modeString{
    PeriperalInfo *selectPi =  self.appDelegate.defaultBTServer.selectPeripheralInfo;

    if([selectPi.mode isEqualToString:@"2 Hours"]){
        if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour count]){
            selectPi.imist = [selectPi.userset2Hour valueForKey:@"mist"];
            selectPi.ledlight = [selectPi.userset2Hour valueForKey:@"brightness"];
            selectPi.ledauto = [selectPi.userset2Hour valueForKey:@"auto"];
            selectPi.ledcolor = [selectPi.userset2Hour valueForKey:@"color"];
        }
        else{
            selectPi.imist = [NSNumber numberWithInteger:50];
            selectPi.ledlight = [NSNumber numberWithInteger:46];
            selectPi.ledcolor = [NSNumber numberWithInteger:100];
            selectPi.ledauto = [NSNumber numberWithInteger:0];
        }
        
    }
    else if([selectPi.mode isEqualToString:@"4 Hours"]){
        if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour count]){
            selectPi.imist = [selectPi.userset4Hour valueForKey:@"mist"];
            selectPi.ledlight = [selectPi.userset4Hour valueForKey:@"brightness"];
            selectPi.ledauto = [selectPi.userset4Hour valueForKey:@"auto"];
            selectPi.ledcolor = [selectPi.userset4Hour valueForKey:@"color"];
        }
        else{
            selectPi.imist = [NSNumber numberWithInteger:50];
            selectPi.ledlight = [NSNumber numberWithInteger:46];
            selectPi.ledcolor = [NSNumber numberWithInteger:100];
            selectPi.ledauto = [NSNumber numberWithInteger:0];
        }
    }
    else if([selectPi.mode isEqualToString:@"8 Hours"]){
        if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour count]){
            selectPi.imist = [selectPi.userset8Hour valueForKey:@"mist"];
            selectPi.ledlight = [selectPi.userset8Hour valueForKey:@"brightness"];
            selectPi.ledauto = [selectPi.userset8Hour valueForKey:@"auto"];
            selectPi.ledcolor = [selectPi.userset8Hour valueForKey:@"color"];
            }
        else{
            selectPi.imist = [NSNumber numberWithInteger:50];
            selectPi.ledlight = [NSNumber numberWithInteger:46];
            selectPi.ledcolor = [NSNumber numberWithInteger:100];
            selectPi.ledauto = [NSNumber numberWithInteger:0];
        }
    }
    else if([selectPi.mode isEqualToString:@"16 Hours"]){
        if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour count]){
            selectPi.imist = [selectPi.userset16Hour valueForKey:@"mist"];
            selectPi.ledlight = [selectPi.userset16Hour valueForKey:@"brightness"];
            selectPi.ledauto = [selectPi.userset16Hour valueForKey:@"auto"];
            selectPi.ledcolor = [selectPi.userset16Hour valueForKey:@"color"];
        }
        else{
            selectPi.imist = [NSNumber numberWithInteger:50];
            selectPi.ledlight = [NSNumber numberWithInteger:46];
            selectPi.ledcolor = [NSNumber numberWithInteger:100];
            selectPi.ledauto = [NSNumber numberWithInteger:0];
        }
    }
    else{
        selectPi.imist = [NSNumber numberWithInteger:50];
        selectPi.ledlight = [NSNumber numberWithInteger:46];
        selectPi.ledcolor = [NSNumber numberWithInteger:100];
        selectPi.ledauto = [NSNumber numberWithInteger:0];
    }
}

- (void) peripheralDidDisconnect:(NSNotification*)notification{
    __block typeof(self) currentBlockSel_f = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [currentBlockSel_f.deviceTable reloadData];
    });
    
}

-(void) peripheralDidReconnect:(NSNotification*)notification{
    
    self.appDelegate.defaultBTServer.selectPeripheralInfo.state = @"connected";
    dispatch_async(dispatch_get_main_queue(), ^{
            NSMutableData* data = [NSMutableData data];
            NSUInteger query = 0xa0;
            [data appendBytes:&query length:1];
            NSUInteger imist = 0x00;
            [data appendBytes:&imist length:1];
            NSUInteger led = 0x00;
            [data appendBytes:&led length:1];
            NSUInteger color1 = 0x00;
            [data appendBytes:&color1 length:1];
            NSUInteger color2 = 0x00;
            [data appendBytes:&color2 length:1];
            NSUInteger color3 = 0x00;
            [data appendBytes:&color3 length:1];
            
            //self.appDelegate.defaultBTServer.selectPeripheralInfo.intentAction = INIT_SET_WORK_MODE;
            
            self.appDelegate.defaultBTServer.selectPeripheralInfo.curCmd = GET_WORK_MODE;
            [self.appDelegate.defaultBTServer writeValue:[self.appDelegate.defaultBTServer converCMD:data] withCharacter:[self.appDelegate.defaultBTServer findCharacteristicFromUUID:[CBUUID UUIDWithString:WRITE_CHARACTERISTIC]]];
    });
    [self.deviceTable reloadData];

}

@end
