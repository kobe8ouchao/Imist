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
    if(!self.title) self.title = @"Devices List";
    
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
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    SettingUser *thirdViewController = [[SettingUser alloc] init];
    thirdViewController.title = [NSString stringWithFormat:@"Imist-%ld",(long)indexPath.row];
    SettingModeVC *firstViewController = [[SettingModeVC alloc] init];
    firstViewController.title = [NSString stringWithFormat:@"Imist-%ld",(long)indexPath.row];
    SettingAlerm *secondViewController = [[SettingAlerm alloc] init];
    secondViewController.title = [NSString stringWithFormat:@"Imist-%ld",(long)indexPath.row];

    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[firstViewController, secondViewController,thirdViewController]];
    [self customizeTabBarForController:tabBarController];
    tabBarController.title = [NSString stringWithFormat:@"Imist-%ld",(long)indexPath.row];
    [self.navigationController pushViewController:tabBarController animated:YES];
//    [self.defaultBTServer stopScan:YES];
//    
////    [ProgressHUD show:@"connecting ..."];
//    
//    [self.defaultBTServer connect:self.defaultBTServer.discoveredPeripherals[indexPath.row] withFinishCB:^(CBPeripheral *peripheral, BOOL status, NSError *error) {
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //            [ProgressHUD dismiss];
//            
//            if (status) {
//                [ProgressHUD showSuccess:@"connected success!"];
//                [self performSegueWithIdentifier:@"getService" sender:self];
//            }else{
//                [ProgressHUD showError:@"connected failed!"];
//            }
//        });
//        
//        
//    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"ScanDeviceCell";
    ScanDeviceCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[ScanDeviceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    PeriperalInfo *pi = (PeriperalInfo*)[self.appDelegate.defaultBTServer.discoveredPeripherals objectAtIndex:indexPath.row];
    cell.name = [NSString stringWithFormat:@"%@-%ld",pi.name,(long)indexPath.row];
//    cell.name = [NSString stringWithFormat:@"Imist-%ld",(long)indexPath.row];
    cell.icon = @"";
    cell.index = indexPath;
    cell.delegate = self;
    [cell setStyle];
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
}

- (void)refreshTable {
    //TODO: refresh your data
    [self.appDelegate.defaultBTServer startScan];
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"first", @"second", @"third"];
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBadgeBackgroundColor:[UIColor clearColor]];
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        index++;
    }
}

@end