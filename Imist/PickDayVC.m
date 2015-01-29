//
//  PickDayVC.m
//  Imist
//
//  Created by chao.ou on 15/1/21.
//  Copyright (c) 2015年 oc. All rights reserved.
//

#import "PickDayVC.h"

@interface PickDayVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *deviceTable;
@property (nonatomic,strong) NSArray *days;
@end

@implementation PickDayVC
@synthesize deviceTable, days;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Select Days";
    self.days = [NSArray arrayWithObjects:@"Mon",@"Thr",@"Wed",@"Thu",@"Fri",@"Sat",@"Sun",nil];
    //init device tableview
    UITableView *_table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,  self.view.frame.size.height) style:UITableViewStylePlain];
    _table.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                               UIViewAutoresizingFlexibleHeight);
    _table.delegate = self;
    _table.dataSource = self;
    _table.showsVerticalScrollIndicator = NO;
    _table.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    _table.backgroundColor=[UIColor clearColor];
    
    self.deviceTable=_table;
    [self.view addSubview:self.deviceTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- table delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DayCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [self.days objectAtIndex:indexPath.row];
    return cell;
}


@end
