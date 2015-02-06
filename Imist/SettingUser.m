//
//  SettingUser.m
//  Imist
//
//  Created by chao.ou on 15/1/18.
//  Copyright (c) 2015年 oc. All rights reserved.
//

#import "SettingUser.h"

@interface SettingUser ()
@property (nonatomic, strong) NSString *title;
@end

@implementation SettingUser
@synthesize title;
- (void)viewDidLoad {
    [super viewDidLoad];
    if(!self.title) self.title = title;
    self.navigationController.navigationBar.topItem.title = self.title;
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake( 0, 0, 44, 44)];
    [leftBtn setImage:[UIImage imageNamed:@"back-arrow.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self setUpBar:CGRectMake(20, 30, self.view.frame.size.width - 40 ,80) withTitle:@"Imist" withMin:0 withMax:50 withTag:1];
    [self setUpBar:CGRectMake(20, 100, self.view.frame.size.width - 40 ,80) withTitle:@"Led brightness" withMin:0 withMax:50 withTag:2];
    [self setUpBar:CGRectMake(20, 180, self.view.frame.size.width - 40 ,80) withTitle:@"led color" withMin:0 withMax:50 withTag:3];
//    [self setUpBar:CGRectMake(20, 230, self.view.frame.size.width - 40 ,40) withTitle:@"led auto" withMin:0 withMax:50 withTag:4];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 260, self.view.frame.size.width ,18)];
    [lable setFont:[UIFont boldSystemFontOfSize:18]];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = @"led auto";
    lable.textColor = [UIColor colorWith256Red:129 green:189 blue:82];
    [self.view addSubview:lable];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(80, 290, 30, 30);
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"app40.png"] forState:UIControlStateNormal];
    [sureBtn setTitle:@"" forState:UIControlStateNormal];
    sureBtn.tag = 1;
    [sureBtn setBackgroundColor:[UIColor clearColor]];
    
    [sureBtn addTarget:self action:@selector(btnSure:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    
    UIButton *noBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [noBtn setBackgroundImage:[UIImage imageNamed:@"app41.png"] forState:UIControlStateNormal];
    [noBtn setTitle:@"" forState:UIControlStateNormal];
    noBtn.tag = 2;
    [noBtn setBackgroundColor:[UIColor clearColor]];
    noBtn.frame = CGRectMake(self.view.frame.size.width - 800, 290, 30, 30);
    [noBtn addTarget:self action:@selector(btnNo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noBtn];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setUpBar:(CGRect)frame withTitle:(NSString*)label withMin:(CGFloat)mini withMax:(CGFloat)maxi withTag:(NSInteger)tag
{
    UIView *bg = [[UIView alloc] initWithFrame:frame];
    bg.backgroundColor = [UIColor clearColor];    
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width ,18)];
    [lable setFont:[UIFont boldSystemFontOfSize:18]];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = label;
    lable.textColor = [UIColor colorWith256Red:129 green:189 blue:82];
    [bg addSubview:lable];
    
    UIImageView *imgbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, frame.size.width ,40)];
    imgbg.image = [UIImage imageNamed:@"bg_scancell_green.png"];
    imgbg.backgroundColor = [UIColor clearColor];
    [bg addSubview:imgbg];
    
    UIImageView *minus = [[UIImageView alloc] initWithFrame:CGRectMake(5, 24, 30 ,30)];
    minus.image = [UIImage imageNamed:@"ico_minus2.png"];
    minus.backgroundColor = [UIColor clearColor];
    [bg addSubview:minus];
    
    UISlider* slider = [ [ UISlider alloc ] initWithFrame:CGRectMake(40,20,frame.size.width - 80,40.0)];
    slider.minimumValue = mini;//下限
    slider.maximumValue = maxi;//上限
    //设置滑块左边值颜色为绿色。系统默认为蓝色
    slider.minimumTrackTintColor = [UIColor greenColor];
    //设置滑块右边值为红色，系统默认为白色
    slider.maximumTrackTintColor = [UIColor whiteColor];
    //给slider是指默认值30
    slider.value = 0;
    //continuous属性，是指滑块值在拖地触发滑块值变动
    slider.continuous = YES;
    slider.tag = tag;
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [bg addSubview:slider];
    
    UIImageView *plus = [[UIImageView alloc] initWithFrame:CGRectMake(bg.frame.size.width - 35, 24, 30 ,30)];
    plus.image = [UIImage imageNamed:@"ico_plus2.png"];
    plus.backgroundColor = [UIColor clearColor];
    [bg addSubview:plus];
    
    [self.view addSubview:bg];

}

- (void) sliderValueChanged:(id)sender{
    UISlider* control = (UISlider*)sender;
    float value = control.value;
    control.value =value;
    NSLog(@"%f",value);
}

- (void) btnSure:(id)sender
{
    
}

- (void) btnNo:(id)sender
{
    
}

@end
