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

@interface ScanDevicesVC ()<UITableViewDataSource,UITableViewDelegate,BTServerDelegate,scanDeviceCellDelegate> {
    BOOL reloading;
    BOOL isTag;
    activityView *activety;
}
@property (strong,nonatomic)BTServer *defaultBTServer;
@property (strong, nonatomic) UITableView *deviceTable;
@property (strong, nonatomic) UITextField *txtInfo;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end


@implementation ScanDevicesVC
@synthesize deviceTable, txtInfo, refreshControl;
- (void)viewDidLoad {
    [super viewDidLoad];
    // setup navigationBar
    if(!self.title) self.title = @"CONNECT";
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake( 0, 0, 44, 44)];
    [leftBtn setImage:[UIImage imageNamed:@"ico_navibtn_sidemenu.png"] forState:UIControlStateNormal];
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
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
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
    });
}
-(void)didReadvalue:(NSData*)data
{
    NSLog(@"data====%@",data);
    Byte *dataByte = (Byte *) [data bytes];
    if ([data length] > 0) {
        NSUInteger state = dataByte[2];
        if (state == 0x00) {
            self.appDelegate.defaultBTServer.selectPeripheralInfo.water = 0;
        }else if (state == 0x01){
            self.appDelegate.defaultBTServer.selectPeripheralInfo.water = 0;
        }else {
            self.appDelegate.defaultBTServer.selectPeripheralInfo.water = [NSNumber numberWithInt:1];
        }
        [self.deviceTable reloadData];
    }
}
-(void)didDisconnect
{
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
    PeriperalInfo *pi = (PeriperalInfo*)[self.appDelegate.defaultBTServer.discoveredPeripherals objectAtIndex:indexPath.row];
    if ([pi.state isEqualToString:@"connected"]) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        SettingUser *thirdViewController = [[SettingUser alloc] init];
        thirdViewController.title = [NSString stringWithFormat:@"IMIST-%ld",(long)indexPath.row];
        SettingModeVC *firstViewController = [[SettingModeVC alloc] init];
        firstViewController.title = [NSString stringWithFormat:@"IMIST-%ld",(long)indexPath.row];
        SettingAlerm *secondViewController = [[SettingAlerm alloc] init];
        secondViewController.title = [NSString stringWithFormat:@"IMIST-%ld",(long)indexPath.row];
        
        RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
        [tabBarController setViewControllers:@[firstViewController, secondViewController,thirdViewController]];
        [self customizeTabBarForController:tabBarController];
        tabBarController.title = [NSString stringWithFormat:@"IMIST-%ld",(long)indexPath.row];
        [self.navigationController pushViewController:tabBarController animated:YES];
    }else if([pi.state isEqualToString:@"disConnected"]) {
        [ProgressHUD show:@"connecting ..."];
        [self.appDelegate.defaultBTServer connect:self.appDelegate.defaultBTServer.discoveredPeripherals[indexPath.row] withFinishCB:^(CBPeripheral *peripheral, BOOL status, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [ProgressHUD dismiss];
                if (status) {
                    pi.state = @"connected";
                    self.appDelegate.defaultBTServer.selectPeripheralInfo = pi;
                    [cell setState:1];
                    [ProgressHUD showSuccess:@"connected success!"];
                    NSMutableData* data = [NSMutableData data];
                    NSUInteger query = 0x01;
                    [data appendBytes:&query length:1];
                    NSUInteger imist = 0x00;
                    [data appendBytes:&imist length:1];
                    NSUInteger time = 0x00;
                    [data appendBytes:&time length:1];
                    NSUInteger led = 0x00;
                    [data appendBytes:&led length:1];
                    NSUInteger color1 = 0x00;
                    [data appendBytes:&color1 length:1];
                    NSUInteger color2 = 0x00;
                    [data appendBytes:&color2 length:1];
                    NSUInteger color3 = 0x00;
                    [data appendBytes:&color3 length:1];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"ScanDeviceCell";
    ScanDeviceCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[ScanDeviceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone; 
//    PeriperalInfo *pi = (PeriperalInfo*)[self.appDelegate.defaultBTServer.discoveredPeripherals objectAtIndex:indexPath.row];
//    cell.name = [NSString stringWithFormat:@"%@-%ld",pi.name,(long)indexPath.row];
    cell.name = [NSString stringWithFormat:@"Imist-%ld",(long)indexPath.row];
    cell.index = indexPath;
    cell.delegate = self;
    cell.icon = @"ico_imist.png";
    [cell setStyle];
//    if (pi == self.appDelegate.defaultBTServer.selectPeripheralInfo) {
//        if (pi.water == [NSNumber numberWithInt:1]) {
//            [cell setState:3];
//        }else {
//            [cell setState:2];
//        }
//    }
    
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
    
    return cell;
}

#pragma cell delegate
-(void)btnClick:(NSInteger)index
{
    NSLog(@"cell====%ld",(long)index);
    [self.appDelegate.defaultBTServer disConnect];
}

- (void)refreshTable {
    //TODO: refresh your data
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

@end
