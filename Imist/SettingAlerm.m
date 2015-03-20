//
//  SettingAlerm.m
//  Imist
//
//  Created by chao.ou on 15/1/19.
//  Copyright (c) 2015年 oc. All rights reserved.
//

#import "SettingAlerm.h"
#import "AddAlarmVC.h"
#import "AlertSettingCell.h"
#import "ProgressHUD.h"

@interface SettingAlerm ()<UITableViewDataSource,UITableViewDelegate,alertSettingCellDelegate>
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSMutableDictionary *deletealertItem;
@property (strong,nonatomic)UITableView *alertTable;
@end

@implementation SettingAlerm
@synthesize title,alertTable;
- (void)viewDidLoad {
    [super viewDidLoad];
    if(!self.title) self.title = title;
    self.navigationController.navigationBar.topItem.title = title;
    self.view.backgroundColor=[UIColor whiteColor];    
    
    //init device tableview
    UITableView *_table=[[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width,  self.view.frame.size.height) style:UITableViewStylePlain];
    _table.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                               UIViewAutoresizingFlexibleHeight);
    _table.delegate = self;
    _table.dataSource = self;
    _table.contentInset=UIEdgeInsetsMake(0, 0 ,0, 0);
    _table.showsVerticalScrollIndicator = NO;
    _table.separatorStyle=UITableViewCellSeparatorStyleNone;
    _table.backgroundColor=[UIColor clearColor];
    
    self.alertTable=_table;
    [self.view addSubview:self.alertTable];
    
    
//    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [addBtn setTitle:@"Add Alarm" forState:UIControlStateNormal];
//    [addBtn setBackgroundColor:[UIColor clearColor]];
//    [addBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn_green.png"] forState:UIControlStateNormal];
//    addBtn.frame = CGRectMake((self.view.frame.size.width - 140)/2, 300, 140, 44);
//    [addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:addBtn];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.alertTable reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addAction:(id)sender
{
    if ([self.appDelegate.defaultBTServer.selectPeripheralInfo.alert count] == 3) {
        [ProgressHUD showError:@"Only set three wakeup"];
    }else {
        AddAlarmVC* addv = [[AddAlarmVC alloc] init];
        [self.navigationController pushViewController:addv animated:YES];
    }
}

- (void) switchAction:(id)sender{
    
}

#pragma mark -- table delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger n = [self.appDelegate.defaultBTServer.selectPeripheralInfo.alert count];
    return n;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *alertItem = [self.appDelegate.defaultBTServer.selectPeripheralInfo.alert objectAtIndex:indexPath.row];
    AddAlarmVC* addv = [[AddAlarmVC alloc] init];
    addv.editAlert = alertItem;
    [self.navigationController pushViewController:addv animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"AlertSettingCell";
    NSMutableDictionary *alertItem = [self.appDelegate.defaultBTServer.selectPeripheralInfo.alert objectAtIndex:indexPath.row];
    AlertSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[AlertSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.index = indexPath;
    cell.delegate = self;
    cell.name = [alertItem objectForKey:@"alarmName"];
    cell.time = [alertItem objectForKey:@"time"];
    cell.days = [alertItem objectForKey:@"repeat"];
    cell.isOpen = [[alertItem objectForKey:@"isOpen"] boolValue];
    [cell setStyle];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.deletealertItem = [self.appDelegate.defaultBTServer.selectPeripheralInfo.alert objectAtIndex:indexPath.row];
    [self AlertView];
}

-(void)AlertView{
    UIAlertView *aview = [[UIAlertView alloc]initWithTitle:@"Delete Wakeup?" message:@"Do you want to delete this wakeup?" delegate:self cancelButtonTitle:@"Confirm" otherButtonTitles:@"Cancel", nil];
    aview.delegate = self;
    [aview show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self.appDelegate.defaultBTServer.selectPeripheralInfo.alert removeObject:self.deletealertItem];
            [self.alertTable reloadData];
            break;
        case 1:
            [self.alertTable reloadData];
        default:
            break;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self.appDelegate.defaultBTServer.selectPeripheralInfo];
    [defaults setObject:encodedObject forKey:self.appDelegate.defaultBTServer.selectPeripheralInfo.uuid];
    [defaults synchronize];

}

- (void)switchChange:(NSInteger)index enable:(BOOL)yesNo{
    NSNumber* ifenable;

    ifenable = [NSNumber numberWithBool:yesNo];
    
    [self.appDelegate.defaultBTServer.selectPeripheralInfo.alert[index] setObject:ifenable forKey:@"isOpen"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self.appDelegate.defaultBTServer.selectPeripheralInfo];
    [defaults setObject:encodedObject forKey:self.appDelegate.defaultBTServer.selectPeripheralInfo.uuid];
    [defaults synchronize];
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    for(NSDictionary *alertItem in self.appDelegate.defaultBTServer.selectPeripheralInfo.alert)
    {
        if([[alertItem objectForKey:@"isOpen"] boolValue] == YES){
            [self.appDelegate scheduleNotification:alertItem];
        }
    }
}

@end
