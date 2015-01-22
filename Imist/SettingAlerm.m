//
//  SettingAlerm.m
//  Imist
//
//  Created by chao.ou on 15/1/19.
//  Copyright (c) 2015年 oc. All rights reserved.
//

#import "SettingAlerm.h"
#import "AddAlarmVC.h"

@interface SettingAlerm ()
@property (nonatomic, strong) NSString *title;
@end

@implementation SettingAlerm
@synthesize title;
- (void)viewDidLoad {
    [super viewDidLoad];
    if(!self.title) self.title = title;
    self.navigationController.navigationBar.topItem.title = title;
    self.view.backgroundColor=[UIColor whiteColor];    
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(20, 80, self.view.frame.size.width - 40 ,40)];
    bg.backgroundColor = [UIColor grayColor];
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 11, 200 ,18)];
    [lable setFont:[UIFont boldSystemFontOfSize:18]];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.text = @"9:00";
    lable.textColor = [UIColor whiteColor];
    [bg addSubview:lable];
    
    UISwitch *showBuzzerSwich = [[UISwitch alloc] initWithFrame:CGRectMake(bg.frame.size.width - 40 - 20,4,40.0,40.0)];

    showBuzzerSwich.onTintColor=[UIColor colorWith256Red:192 green:238 blue:32];
    [showBuzzerSwich addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [bg addSubview:showBuzzerSwich];
    [self.view addSubview:bg];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"Add Alarm" forState:UIControlStateNormal];
    [addBtn setBackgroundColor:[UIColor blueColor]];
    addBtn.frame = CGRectMake((self.view.frame.size.width - 100)/2, 300, 100, 40);
    [addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
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
    AddAlarmVC* addv = [[AddAlarmVC alloc] init];
    [self.navigationController pushViewController:addv animated:YES];
}

- (void) switchAction:(id)sender{
    
}

@end
