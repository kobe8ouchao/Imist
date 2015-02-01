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
@property (nonatomic,strong) NSArray *daysvalue;
@property (nonatomic,strong) NSMutableArray *selecteddays;
@end

@implementation PickDayVC
@synthesize deviceTable, days;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Select Days";
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveItem;

    
    self.days = [NSArray arrayWithObjects:@"Mon",@"Thr",@"Wed",@"Thu",@"Fri",@"Sat",@"Sun",nil];
    self.daysvalue = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",nil];
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
    _selecteddays = [[NSMutableArray alloc] init];
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
    NSString *dayvalue = [self.daysvalue objectAtIndex:indexPath.row];
    if ([self.selecteddays containsObject:dayvalue]) {
        [self.selecteddays removeObject:dayvalue];
    }else {
        [self.selecteddays addObject:dayvalue];
    }
    [self.deviceTable reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DayCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString *dayvalue = [self.daysvalue objectAtIndex:indexPath.row];
    if ( [self.selecteddays containsObject:dayvalue])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [self.days objectAtIndex:indexPath.row];
    return cell;
}

-(void)save
{
    if ([delegate respondsToSelector:@selector(saveDay:)]) {
        [delegate saveDay:self.days];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
