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
#import "EGORefreshTableHeaderView.h"
#import "activityView.h"
#import "ScanDeviceCell.h"

@interface ScanDevicesVC ()<UITableViewDataSource,UITableViewDelegate,BTServerDelegate,EGORefreshTableHeaderDelegate,scanDeviceCellDelegate> {
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL reloading;
    BOOL isTag;
    activityView *activety;
}
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
    _table.contentInset=UIEdgeInsetsMake(80, 0 ,0, 0);
    _table.showsVerticalScrollIndicator = NO;
    _table.separatorStyle=UITableViewCellSeparatorStyleNone;
    _table.backgroundColor=[UIColor whiteColor];
    
    self.deviceTable=_table;
    [self.view addSubview:self.deviceTable];
    
//    _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
//    _refreshHeaderView.delegate = self;
//    [self.deviceTable addSubview:_refreshHeaderView];
//    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.deviceTable];
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
        self.title = @"No Device Found";
    });
}
-(void)didFoundPeripheral
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.deviceTable reloadData];
        if (reloading) {
            [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.deviceTable];
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
    return 4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    SettingVC *groupSet = [[SettingVC alloc] init];
    groupSet.title = [NSString stringWithFormat:@"Imist-%ld",(long)indexPath.row];
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
    static NSString *MyIdentifier = @"ScanDeviceCell";
    ScanDeviceCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[ScanDeviceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
//    PeriperalInfo *pi = self.defaultBTServer.discoveredPeripherals[indexPath.row];
//    cell.name = [NSString stringWithFormat:@"%@-%d",pi.name,indexPath.row];
    cell.name = [NSString stringWithFormat:@"Imist-%d",indexPath.row];
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

-(void)Refresh{
    __block typeof(self) currentBlockSel_f = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        [currentBlockSel_f.appDelegate.defaultBTServer stopScan];
        [currentBlockSel_f.appDelegate.defaultBTServer startScan:10];
        sleep(10);
        dispatch_async(dispatch_get_main_queue(), ^{
             reloading = NO;
             [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.deviceTable];
         });
    });
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods
- (void)reloadTableViewDataSource{
    reloading = YES;
    [self Refresh];
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    [self reloadTableViewDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    return reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return [NSDate date]; // should return date data source was last changed
    
}

#pragma cell delegate
-(void)btnClick:(NSInteger)index
{
    NSLog(@"cell====%d",index);
}

@end
