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

@interface ScanDevicesVC ()<UITableViewDataSource,UITableViewDelegate,BTServerDelegate>
@property (strong,nonatomic)BTServer *defaultBTServer;
@property (strong, nonatomic) UITableView *deviceTable;
@property (strong, nonatomic) UITextField *txtInfo;

@end


@implementation ScanDevicesVC
@synthesize deviceTable, txtInfo;
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
    _table.rowHeight=60;
    _table.showsVerticalScrollIndicator = NO;
    _table.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    _table.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_table];
    self.deviceTable=_table;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        self.txtInfo.text = @"scan stoped";
    });
}
-(void)didFoundPeripheral
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.deviceTable reloadData];
    });
}
-(void)didDisconnect
{
//    [ProgressHUD show:@"disconnect from peripheral"];
}

#pragma mark -- table delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    int n = [self.defaultBTServer.discoveredPeripherals count];
    return 4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    SettingVC *groupSet = [[SettingVC alloc] init];
    groupSet.title = [NSString stringWithFormat:@"Imist-%d",indexPath.row];
    [self.navigationController pushViewController:groupSet animated:YES];
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
    static NSString *MyIdentifier = @"PeripheralCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Imist-%d",indexPath.row];
    
//    PeriperalInfo *pi = self.defaultBTServer.discoveredPeripherals[indexPath.row];
//    
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




@end
