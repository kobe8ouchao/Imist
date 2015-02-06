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
    
    UILabel *imistHeader = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 30, 60, 120 ,22)];
    [imistHeader setFont:[UIFont boldSystemFontOfSize:22]];
    imistHeader.textAlignment = NSTextAlignmentLeft;
    imistHeader.text = @"mist";
    imistHeader.textColor = [UIColor colorWith256Red:129 green:189 blue:82];
    [self.view addSubview:imistHeader];
    
    UILabel *brightHeader = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 70, 60+77, 180 ,22)];
    [brightHeader setFont:[UIFont boldSystemFontOfSize:22]];
    brightHeader.textAlignment = NSTextAlignmentLeft;
    brightHeader.text = @"led brightness";
    brightHeader.textColor = [UIColor colorWith256Red:129 green:189 blue:82];
    [self.view addSubview:brightHeader];
    
    UILabel *colorHeader = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 50, 60+160, 120 ,22)];
    [colorHeader setFont:[UIFont boldSystemFontOfSize:22]];
    colorHeader.textAlignment = NSTextAlignmentLeft;
    colorHeader.text = @"led colour";
    colorHeader.textColor = [UIColor colorWith256Red:129 green:189 blue:82];
    [self.view addSubview:colorHeader];
    
    UILabel *autoHeader = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 40, 60+240, 120 ,22)];
    [autoHeader setFont:[UIFont boldSystemFontOfSize:22]];
    autoHeader.textAlignment = NSTextAlignmentLeft;
    autoHeader.text = @"led auto";
    autoHeader.textColor = [UIColor colorWith256Red:129 green:189 blue:82];
    [self.view addSubview:autoHeader];

    
    [self setUpBar:CGRectMake(20, 80, self.view.frame.size.width - 40 ,40) withTitle:@"Imist" withMin:0 withMax:50 withTag:1];
    [self setUpBar:CGRectMake(20, 130+30, self.view.frame.size.width - 40 ,40) withTitle:@"Led brightness" withMin:0 withMax:50 withTag:2];
    [self setUpBar:CGRectMake(20, 180+60, self.view.frame.size.width - 40 ,40) withTitle:@"led color" withMin:0 withMax:50 withTag:3];
//    [self setUpBar:CGRectMake(20, 230, self.view.frame.size.width - 40 ,40) withTitle:@"led auto" withMin:0 withMax:50 withTag:4];
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 100, 230+90, 90 ,40) ];
    bg.backgroundColor = [UIColor clearColor];
    UIImageView *imgbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bg.frame.size.width ,bg.frame.size.height)];
    imgbg.image = [UIImage imageNamed:@"bg_btn_green.png"];
    imgbg.backgroundColor = [UIColor clearColor];
    [bg addSubview:imgbg];

    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"app43.png"] forState:UIControlStateNormal];
    //[sureBtn setBackgroundImage:[UIImage imageNamed:@"app40.png"] forState:UIControlStateSelected];
    [sureBtn setTitle:@"" forState:UIControlStateNormal];
    sureBtn.tag = 1;
    [sureBtn setBackgroundColor:[UIColor clearColor]];
    sureBtn.frame = CGRectMake(bg.frame.size.width/2 - 15, 5, 30, 30);
    [sureBtn addTarget:self action:@selector(btnSure:) forControlEvents:UIControlEventTouchUpInside];
    [bg addSubview:sureBtn];
    [self.view addSubview:bg];
    
    UIView *bg1 = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 +10, 230+90, 90 ,40) ];
    bg1.backgroundColor = [UIColor clearColor];
    UIImageView *imgbg1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bg1.frame.size.width ,bg1.frame.size.height)];
    imgbg1.image = [UIImage imageNamed:@"bg_btn_green.png"];
    imgbg1.backgroundColor = [UIColor clearColor];
    [bg1 addSubview:imgbg1];
    
    UIButton *noBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [noBtn setBackgroundImage:[UIImage imageNamed:@"app41.png"] forState:UIControlStateNormal];
    //[noBtn setBackgroundImage:[UIImage imageNamed:@"app42.png"] forState:UIControlStateSelected];
    [noBtn setTitle:@"" forState:UIControlStateNormal];
    noBtn.tag = 2;
    [noBtn setBackgroundColor:[UIColor clearColor]];
    noBtn.frame = CGRectMake(bg1.frame.size.width/2 - 15, 5, 30, 30);
    [noBtn addTarget:self action:@selector(btnNo:) forControlEvents:UIControlEventTouchUpInside];
    [bg1 addSubview:noBtn];
    [self.view addSubview:bg1];

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
    UIImageView *imgbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width ,frame.size.height)];
    imgbg.image = [UIImage imageNamed:@"bg_scancell_green.png"];
    imgbg.backgroundColor = [UIColor clearColor];
    [bg addSubview:imgbg];
    
    UIImageView *imgMinus = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30 ,30)];
    imgMinus.image = [UIImage imageNamed:@"ico_minus2"];
    imgMinus.backgroundColor = [UIColor clearColor];
    [bg addSubview:imgMinus];
    
    UIImageView *imgPlus = [[UIImageView alloc] initWithFrame:CGRectMake(bg.frame.size.width -5 -30, 5, 30 ,30)];
    imgPlus.image = [UIImage imageNamed:@"ico_plus2"];
    imgPlus.backgroundColor = [UIColor clearColor];
    [bg addSubview:imgPlus];
    
    UISlider* slider = [ [ UISlider alloc ] initWithFrame:CGRectMake(bg.frame.size.width - 230 - 10,0,200.0,40.0)];
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
