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

@interface SettingAlerm ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSString *title;
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
    UITableView *_table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,  self.view.frame.size.height) style:UITableViewStylePlain];
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
    
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"Add Alarm" forState:UIControlStateNormal];
    [addBtn setBackgroundColor:[UIColor clearColor]];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn_green.png"] forState:UIControlStateNormal];
    addBtn.frame = CGRectMake((self.view.frame.size.width - 140)/2, 300, 140, 44);
    [addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
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
        [ProgressHUD showError:@"Only set three alerms"];
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
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"AlertSettingCell";
    NSDictionary *alertItem = [self.appDelegate.defaultBTServer.selectPeripheralInfo.alert objectAtIndex:indexPath.row];
    AlertSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[AlertSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    cell.time = [alertItem objectForKey:@"time"];
    cell.isOpen = [[alertItem objectForKey:@"open"] boolValue];
    return cell;
}

@end
