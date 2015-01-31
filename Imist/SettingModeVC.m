//
//  SettingModeVCViewController.m
//  Imist
//
//  Created by chao.ou on 15/1/18.
//  Copyright (c) 2015年 oc. All rights reserved.
//

#import "SettingModeVC.h"

@interface SettingModeVC ()
@property (nonatomic, strong) NSString *title;
@end

@implementation SettingModeVC
@synthesize title;
- (void)viewDidLoad {
    [super viewDidLoad];
    if(!self.title) self.title = title;
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake( 0, 0, 44, 44)];
    [leftBtn setImage:[UIImage imageNamed:@"back-arrow.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.view.backgroundColor=[UIColor whiteColor];
    
    UILabel *automode = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width,18)];
    [automode setFont:[UIFont boldSystemFontOfSize:18]];
    automode.textAlignment = NSTextAlignmentCenter;
    automode.text = @"Auto Mode";
    automode.textColor = [UIColor colorWith256Red:129 green:189 blue:82];
    [self.view addSubview:automode];
    
    [self setUpAutoModeView];
    
    UILabel *usermode = [[UILabel alloc] initWithFrame:CGRectMake(0, 220, self.view.frame.size.width,18)];
    [usermode setFont:[UIFont boldSystemFontOfSize:18]];
    usermode.textAlignment = NSTextAlignmentCenter;
    usermode.text = @"User Mode";
    usermode.textColor = [UIColor colorWith256Red:129 green:189 blue:82];
    [self.view addSubview:usermode];
    
    [self setUpUserModeView];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) setUpAutoModeView
{
    UIButton *relexBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [relexBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn_gray.png"] forState:UIControlStateNormal];
    [relexBtn setTitle:@"Relaxation" forState:UIControlStateNormal];
    [relexBtn setBackgroundColor:[UIColor clearColor]];
    relexBtn.frame = CGRectMake(20, 60, 130, 40);
    relexBtn.tag = 1;
    [relexBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:relexBtn];
    UIButton *sleepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sleepBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn_gray.png"] forState:UIControlStateNormal];
    [sleepBtn setTitle:@"Sleep" forState:UIControlStateNormal];
    [sleepBtn setBackgroundColor:[UIColor clearColor]];
    sleepBtn.tag = 2;
    sleepBtn.frame = CGRectMake(self.view.frame.size.width - 20 - 130, 60, 130, 40);
    [sleepBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sleepBtn];
    UIButton *energBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [energBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn_gray.png"] forState:UIControlStateNormal];
    [energBtn setTitle:@"Energization" forState:UIControlStateNormal];
    [energBtn setBackgroundColor:[UIColor clearColor]];
    energBtn.frame = CGRectMake(20, 110, 130, 40);
    energBtn.tag = 3;
    [energBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:energBtn];
    UIButton *soothBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [soothBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn_gray.png"] forState:UIControlStateNormal];
    [soothBtn setTitle:@"Soothing" forState:UIControlStateNormal];
    [soothBtn setBackgroundColor:[UIColor clearColor]];
    soothBtn.frame = CGRectMake(self.view.frame.size.width - 20 - 130, 110, 130, 40);
    [soothBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    soothBtn.tag = 4;
    [self.view addSubview:soothBtn];
    UIButton *sensuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sensuBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn_gray.png"] forState:UIControlStateNormal];
    [sensuBtn setTitle:@"Sensuality" forState:UIControlStateNormal];
    [sensuBtn setBackgroundColor:[UIColor clearColor]];
    sensuBtn.frame = CGRectMake(self.view.frame.size.width - 20 - 130, 160, 130, 40);
    [sensuBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    sensuBtn.tag = 6;
    [self.view addSubview:sensuBtn];
    UIButton *concenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [concenBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn_gray.png"] forState:UIControlStateNormal];
    [concenBtn setTitle:@"Concentration" forState:UIControlStateNormal];
    [concenBtn setBackgroundColor:[UIColor clearColor]];
    concenBtn.frame = CGRectMake(20, 160, 130, 40);
    [concenBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    concenBtn.tag = 5;
    [self.view addSubview:concenBtn];
}

-(void)setUpUserModeView
{
    UIButton *twoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [twoBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn_gray.png"] forState:UIControlStateNormal];
    [twoBtn setTitle:@"2 Hours" forState:UIControlStateNormal];
    [twoBtn setBackgroundColor:[UIColor clearColor]];
    twoBtn.frame = CGRectMake(20, 250, 130, 40);
    twoBtn.tag = 11;
    [twoBtn addTarget:self action:@selector(hoursClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:twoBtn];
    UIButton *fourBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [fourBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn_gray.png"] forState:UIControlStateNormal];
    [fourBtn setTitle:@"4 Hours" forState:UIControlStateNormal];
    [fourBtn setBackgroundColor:[UIColor clearColor]];
    fourBtn.frame = CGRectMake(self.view.frame.size.width - 20 - 130, 250, 130, 40);
    [fourBtn addTarget:self action:@selector(hoursClick:) forControlEvents:UIControlEventTouchUpInside];
    fourBtn.tag = 12;
    [self.view addSubview:fourBtn];
    UIButton *threeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [threeBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn_gray.png"] forState:UIControlStateNormal];
    [threeBtn setTitle:@"8 Hours" forState:UIControlStateNormal];
    [threeBtn setBackgroundColor:[UIColor clearColor]];
    threeBtn.frame = CGRectMake(20, 300, 130, 40);
    [threeBtn addTarget:self action:@selector(hoursClick:) forControlEvents:UIControlEventTouchUpInside];
    threeBtn.tag = 13;
    [self.view addSubview:threeBtn];
    UIButton *sixBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sixBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn_gray.png"] forState:UIControlStateNormal];
    [sixBtn setTitle:@"16 Hour" forState:UIControlStateNormal];
    [sixBtn setBackgroundColor:[UIColor clearColor]];
    sixBtn.frame = CGRectMake(self.view.frame.size.width - 20 - 130, 300, 130, 40);
    sixBtn.tag = 14;
    [sixBtn addTarget:self action:@selector(hoursClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sixBtn];
}

-(void)btnClick:(UIButton*)btn{
}

-(void)hoursClick:(UIButton*)btn{
}


@end
