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
@property (nonatomic, assign) NSInteger imistValue;
@property (nonatomic, assign) NSInteger brightnessValue;
@property (nonatomic, assign) NSInteger colorValue;
@property (nonatomic, assign) NSInteger color1Value;
@property (nonatomic, assign) NSInteger color2Value;
@property (nonatomic, assign) NSInteger color3Value;
@property (nonatomic, strong) NSDictionary *colorR;
@property (nonatomic, strong) NSDictionary *colorG;
@property (nonatomic, strong) NSDictionary *colorB;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger lastImistValue;
@property (nonatomic, assign) NSInteger lastBrightnessValue;
@property (nonatomic, assign) NSInteger lastColorValue;
@property (nonatomic, assign) NSInteger ledAutoEnable;
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
    
    self.colorR = @{
                    @"1" : [NSNumber numberWithInt:100],
                    @"2" : [NSNumber numberWithInt:100],
                    @"3" : [NSNumber numberWithInt:100],
                    @"4" : [NSNumber numberWithInt:100],
                    @"5" : [NSNumber numberWithInt:100],
                    @"6" : [NSNumber numberWithInt:100],
                    @"7" : [NSNumber numberWithInt:100],
                    @"8" : [NSNumber numberWithInt:100],
                    @"9" : [NSNumber numberWithInt:100],
                    @"10" : [NSNumber numberWithInt:100],
                    @"11" : [NSNumber numberWithInt:100],
                    @"12" : [NSNumber numberWithInt:100],
                    @"13" : [NSNumber numberWithInt:100],
                    @"14" : [NSNumber numberWithInt:100],
                    @"15" : [NSNumber numberWithInt:100],
                    @"16" : [NSNumber numberWithInt:100],
                    @"17" : [NSNumber numberWithInt:100],
                    @"18" : [NSNumber numberWithInt:100],
                    @"19" : [NSNumber numberWithInt:94],
                    @"20" : [NSNumber numberWithInt:88],
                    @"21" : [NSNumber numberWithInt:82],
                    @"22" : [NSNumber numberWithInt:76],
                    @"23" : [NSNumber numberWithInt:70],
                    @"24" : [NSNumber numberWithInt:64],
                    @"25" : [NSNumber numberWithInt:58],
                    @"26" : [NSNumber numberWithInt:52],
                    @"27" : [NSNumber numberWithInt:46],
                    @"28" : [NSNumber numberWithInt:40],
                    @"29" : [NSNumber numberWithInt:34],
                    @"30" : [NSNumber numberWithInt:28],
                    @"31" : [NSNumber numberWithInt:22],
                    @"32" : [NSNumber numberWithInt:16],
                    @"33" : [NSNumber numberWithInt:10],
                    @"34" : [NSNumber numberWithInt:4],
                    @"35" : [NSNumber numberWithInt:0],
                    @"36" : [NSNumber numberWithInt:0],
                    @"37" : [NSNumber numberWithInt:0],
                    @"38" : [NSNumber numberWithInt:0],
                    @"39" : [NSNumber numberWithInt:0],
                    @"40" : [NSNumber numberWithInt:0],
                    @"41" : [NSNumber numberWithInt:0],
                    @"42" : [NSNumber numberWithInt:0],
                    @"43" : [NSNumber numberWithInt:0],
                    @"44" : [NSNumber numberWithInt:0],
                    @"45" : [NSNumber numberWithInt:0],
                    @"46" : [NSNumber numberWithInt:0],
                    @"47" : [NSNumber numberWithInt:0],
                    @"48" : [NSNumber numberWithInt:0],
                    @"49" : [NSNumber numberWithInt:0],
                    @"50" : [NSNumber numberWithInt:0],
                    @"51" : [NSNumber numberWithInt:0],
                    @"52" : [NSNumber numberWithInt:0],
                    @"53" : [NSNumber numberWithInt:0],
                    @"54" : [NSNumber numberWithInt:0],
                    @"55" : [NSNumber numberWithInt:0],
                    @"56" : [NSNumber numberWithInt:0],
                    @"57" : [NSNumber numberWithInt:0],
                    @"58" : [NSNumber numberWithInt:0],
                    @"59" : [NSNumber numberWithInt:0],
                    @"60" : [NSNumber numberWithInt:0],
                    @"61" : [NSNumber numberWithInt:0],
                    @"62" : [NSNumber numberWithInt:0],
                    @"63" : [NSNumber numberWithInt:0],
                    @"64" : [NSNumber numberWithInt:0],
                    @"65" : [NSNumber numberWithInt:0],
                    @"66" : [NSNumber numberWithInt:0],
                    @"67" : [NSNumber numberWithInt:0],
                    @"68" : [NSNumber numberWithInt:6],
                    @"69" : [NSNumber numberWithInt:12],
                    @"70" : [NSNumber numberWithInt:18],
                    @"71" : [NSNumber numberWithInt:24],
                    @"72" : [NSNumber numberWithInt:30],
                    @"73" : [NSNumber numberWithInt:36],
                    @"74" : [NSNumber numberWithInt:42],
                    @"75" : [NSNumber numberWithInt:48],
                    @"76" : [NSNumber numberWithInt:54],
                    @"77" : [NSNumber numberWithInt:60],
                    @"78" : [NSNumber numberWithInt:66],
                    @"79" : [NSNumber numberWithInt:72],
                    @"80" : [NSNumber numberWithInt:78],
                    @"81" : [NSNumber numberWithInt:84],
                    @"82" : [NSNumber numberWithInt:90],
                    @"83" : [NSNumber numberWithInt:96],
                    @"84" : [NSNumber numberWithInt:100],
                    @"85" : [NSNumber numberWithInt:100],
                    @"86" : [NSNumber numberWithInt:100],
                    @"87" : [NSNumber numberWithInt:100],
                    @"88" : [NSNumber numberWithInt:100],
                    @"89" : [NSNumber numberWithInt:100],
                    @"90" : [NSNumber numberWithInt:100],
                    @"91" : [NSNumber numberWithInt:100],
                    @"92" : [NSNumber numberWithInt:100],
                    @"93" : [NSNumber numberWithInt:100],
                    @"94" : [NSNumber numberWithInt:100],
                    @"95" : [NSNumber numberWithInt:100],
                    @"96" : [NSNumber numberWithInt:100],
                    @"97" : [NSNumber numberWithInt:100],
                    @"98" : [NSNumber numberWithInt:100],
                    @"99" : [NSNumber numberWithInt:100],
                    @"100" : [NSNumber numberWithInt:100],
                    };
    self.colorG = @{
                    @"1" : [NSNumber numberWithInt:0],
                    @"2" : [NSNumber numberWithInt:6],
                    @"3" : [NSNumber numberWithInt:12],
                    @"4" : [NSNumber numberWithInt:18],
                    @"5" : [NSNumber numberWithInt:24],
                    @"6" : [NSNumber numberWithInt:30],
                    @"7" : [NSNumber numberWithInt:36],
                    @"8" : [NSNumber numberWithInt:42],
                    @"9" : [NSNumber numberWithInt:48],
                    @"10" : [NSNumber numberWithInt:54],
                    @"11" : [NSNumber numberWithInt:60],
                    @"12" : [NSNumber numberWithInt:66],
                    @"13" : [NSNumber numberWithInt:72],
                    @"14" : [NSNumber numberWithInt:78],
                    @"15" : [NSNumber numberWithInt:84],
                    @"16" : [NSNumber numberWithInt:90],
                    @"17" : [NSNumber numberWithInt:96],
                    @"18" : [NSNumber numberWithInt:100],
                    @"19" : [NSNumber numberWithInt:100],
                    @"20" : [NSNumber numberWithInt:100],
                    @"21" : [NSNumber numberWithInt:100],
                    @"22" : [NSNumber numberWithInt:100],
                    @"23" : [NSNumber numberWithInt:100],
                    @"24" : [NSNumber numberWithInt:100],
                    @"25" : [NSNumber numberWithInt:100],
                    @"26" : [NSNumber numberWithInt:100],
                    @"27" : [NSNumber numberWithInt:100],
                    @"28" : [NSNumber numberWithInt:100],
                    @"29" : [NSNumber numberWithInt:100],
                    @"30" : [NSNumber numberWithInt:100],
                    @"31" : [NSNumber numberWithInt:100],
                    @"32" : [NSNumber numberWithInt:100],
                    @"33" : [NSNumber numberWithInt:100],
                    @"34" : [NSNumber numberWithInt:100],
                    @"35" : [NSNumber numberWithInt:100],
                    @"36" : [NSNumber numberWithInt:100],
                    @"37" : [NSNumber numberWithInt:100],
                    @"38" : [NSNumber numberWithInt:100],
                    @"39" : [NSNumber numberWithInt:100],
                    @"40" : [NSNumber numberWithInt:100],
                    @"41" : [NSNumber numberWithInt:100],
                    @"42" : [NSNumber numberWithInt:100],
                    @"43" : [NSNumber numberWithInt:100],
                    @"44" : [NSNumber numberWithInt:100],
                    @"45" : [NSNumber numberWithInt:100],
                    @"46" : [NSNumber numberWithInt:100],
                    @"47" : [NSNumber numberWithInt:100],
                    @"48" : [NSNumber numberWithInt:100],
                    @"49" : [NSNumber numberWithInt:100],
                    @"50" : [NSNumber numberWithInt:100],
                    @"51" : [NSNumber numberWithInt:100],
                    @"52" : [NSNumber numberWithInt:94],
                    @"53" : [NSNumber numberWithInt:88],
                    @"54" : [NSNumber numberWithInt:82],
                    @"55" : [NSNumber numberWithInt:76],
                    @"56" : [NSNumber numberWithInt:70],
                    @"57" : [NSNumber numberWithInt:64],
                    @"58" : [NSNumber numberWithInt:58],
                    @"59" : [NSNumber numberWithInt:52],
                    @"60" : [NSNumber numberWithInt:46],
                    @"61" : [NSNumber numberWithInt:40],
                    @"62" : [NSNumber numberWithInt:34],
                    @"63" : [NSNumber numberWithInt:28],
                    @"64" : [NSNumber numberWithInt:22],
                    @"65" : [NSNumber numberWithInt:16],
                    @"66" : [NSNumber numberWithInt:10],
                    @"67" : [NSNumber numberWithInt:4],
                    @"68" : [NSNumber numberWithInt:0],
                    @"69" : [NSNumber numberWithInt:0],
                    @"70" : [NSNumber numberWithInt:0],
                    @"71" : [NSNumber numberWithInt:0],
                    @"72" : [NSNumber numberWithInt:0],
                    @"73" : [NSNumber numberWithInt:0],
                    @"74" : [NSNumber numberWithInt:0],
                    @"75" : [NSNumber numberWithInt:0],
                    @"76" : [NSNumber numberWithInt:0],
                    @"77" : [NSNumber numberWithInt:0],
                    @"78" : [NSNumber numberWithInt:0],
                    @"79" : [NSNumber numberWithInt:0],
                    @"80" : [NSNumber numberWithInt:0],
                    @"81" : [NSNumber numberWithInt:0],
                    @"82" : [NSNumber numberWithInt:0],
                    @"83" : [NSNumber numberWithInt:0],
                    @"84" : [NSNumber numberWithInt:0],
                    @"85" : [NSNumber numberWithInt:0],
                    @"86" : [NSNumber numberWithInt:0],
                    @"87" : [NSNumber numberWithInt:0],
                    @"88" : [NSNumber numberWithInt:0],
                    @"89" : [NSNumber numberWithInt:0],
                    @"90" : [NSNumber numberWithInt:0],
                    @"91" : [NSNumber numberWithInt:0],
                    @"92" : [NSNumber numberWithInt:0],
                    @"93" : [NSNumber numberWithInt:0],
                    @"94" : [NSNumber numberWithInt:0],
                    @"95" : [NSNumber numberWithInt:0],
                    @"96" : [NSNumber numberWithInt:0],
                    @"97" : [NSNumber numberWithInt:0],
                    @"98" : [NSNumber numberWithInt:0],
                    @"99" : [NSNumber numberWithInt:0],
                    @"100" : [NSNumber numberWithInt:0],
                    };
    self.colorB = @{
                    @"1" : [NSNumber numberWithInt:0],
                    @"2" : [NSNumber numberWithInt:0],
                    @"3" : [NSNumber numberWithInt:0],
                    @"4" : [NSNumber numberWithInt:0],
                    @"5" : [NSNumber numberWithInt:0],
                    @"6" : [NSNumber numberWithInt:0],
                    @"7" : [NSNumber numberWithInt:0],
                    @"8" : [NSNumber numberWithInt:0],
                    @"9" : [NSNumber numberWithInt:0],
                    @"10" : [NSNumber numberWithInt:0],
                    @"11" : [NSNumber numberWithInt:0],
                    @"12" : [NSNumber numberWithInt:0],
                    @"13" : [NSNumber numberWithInt:0],
                    @"14" : [NSNumber numberWithInt:0],
                    @"15" : [NSNumber numberWithInt:0],
                    @"16" : [NSNumber numberWithInt:0],
                    @"17" : [NSNumber numberWithInt:0],
                    @"18" : [NSNumber numberWithInt:0],
                    @"19" : [NSNumber numberWithInt:0],
                    @"20" : [NSNumber numberWithInt:0],
                    @"21" : [NSNumber numberWithInt:0],
                    @"22" : [NSNumber numberWithInt:0],
                    @"23" : [NSNumber numberWithInt:0],
                    @"24" : [NSNumber numberWithInt:0],
                    @"25" : [NSNumber numberWithInt:0],
                    @"26" : [NSNumber numberWithInt:0],
                    @"27" : [NSNumber numberWithInt:0],
                    @"28" : [NSNumber numberWithInt:0],
                    @"29" : [NSNumber numberWithInt:0],
                    @"30" : [NSNumber numberWithInt:0],
                    @"31" : [NSNumber numberWithInt:0],
                    @"32" : [NSNumber numberWithInt:0],
                    @"33" : [NSNumber numberWithInt:0],
                    @"34" : [NSNumber numberWithInt:0],
                    @"35" : [NSNumber numberWithInt:6],
                    @"36" : [NSNumber numberWithInt:12],
                    @"37" : [NSNumber numberWithInt:18],
                    @"38" : [NSNumber numberWithInt:24],
                    @"39" : [NSNumber numberWithInt:30],
                    @"40" : [NSNumber numberWithInt:36],
                    @"41" : [NSNumber numberWithInt:42],
                    @"42" : [NSNumber numberWithInt:48],
                    @"43" : [NSNumber numberWithInt:54],
                    @"44" : [NSNumber numberWithInt:60],
                    @"45" : [NSNumber numberWithInt:66],
                    @"46" : [NSNumber numberWithInt:72],
                    @"47" : [NSNumber numberWithInt:78],
                    @"48" : [NSNumber numberWithInt:84],
                    @"49" : [NSNumber numberWithInt:90],
                    @"50" : [NSNumber numberWithInt:96],
                    @"51" : [NSNumber numberWithInt:100],
                    @"52" : [NSNumber numberWithInt:100],
                    @"53" : [NSNumber numberWithInt:100],
                    @"54" : [NSNumber numberWithInt:100],
                    @"55" : [NSNumber numberWithInt:100],
                    @"56" : [NSNumber numberWithInt:100],
                    @"57" : [NSNumber numberWithInt:100],
                    @"58" : [NSNumber numberWithInt:100],
                    @"59" : [NSNumber numberWithInt:100],
                    @"60" : [NSNumber numberWithInt:100],
                    @"61" : [NSNumber numberWithInt:100],
                    @"62" : [NSNumber numberWithInt:100],
                    @"63" : [NSNumber numberWithInt:100],
                    @"64" : [NSNumber numberWithInt:100],
                    @"65" : [NSNumber numberWithInt:100],
                    @"66" : [NSNumber numberWithInt:100],
                    @"67" : [NSNumber numberWithInt:100],
                    @"68" : [NSNumber numberWithInt:100],
                    @"69" : [NSNumber numberWithInt:100],
                    @"70" : [NSNumber numberWithInt:100],
                    @"71" : [NSNumber numberWithInt:100],
                    @"72" : [NSNumber numberWithInt:100],
                    @"73" : [NSNumber numberWithInt:100],
                    @"74" : [NSNumber numberWithInt:100],
                    @"75" : [NSNumber numberWithInt:100],
                    @"76" : [NSNumber numberWithInt:100],
                    @"77" : [NSNumber numberWithInt:100],
                    @"78" : [NSNumber numberWithInt:100],
                    @"79" : [NSNumber numberWithInt:100],
                    @"80" : [NSNumber numberWithInt:100],
                    @"81" : [NSNumber numberWithInt:100],
                    @"82" : [NSNumber numberWithInt:100],
                    @"83" : [NSNumber numberWithInt:100],
                    @"84" : [NSNumber numberWithInt:100],
                    @"85" : [NSNumber numberWithInt:94],
                    @"86" : [NSNumber numberWithInt:88],
                    @"87" : [NSNumber numberWithInt:82],
                    @"88" : [NSNumber numberWithInt:76],
                    @"89" : [NSNumber numberWithInt:70],
                    @"90" : [NSNumber numberWithInt:64],
                    @"91" : [NSNumber numberWithInt:58],
                    @"92" : [NSNumber numberWithInt:46],
                    @"93" : [NSNumber numberWithInt:40],
                    @"94" : [NSNumber numberWithInt:34],
                    @"95" : [NSNumber numberWithInt:28],
                    @"96" : [NSNumber numberWithInt:22],
                    @"97" : [NSNumber numberWithInt:16],
                    @"98" : [NSNumber numberWithInt:10],
                    @"99" : [NSNumber numberWithInt:4],
                    @"100" : [NSNumber numberWithInt:0],
                    };
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIButton *modeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [modeBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn_green.png"] forState:UIControlStateNormal];
    [modeBtn setTitle:self.appDelegate.defaultBTServer.selectPeripheralInfo.mode forState:UIControlStateNormal];
    [modeBtn setBackgroundColor:[UIColor clearColor]];
    modeBtn.frame = CGRectMake((self.view.frame.size.width - 130)/2, 10, 130, 40);
    modeBtn.tag = 202;
    [self.view addSubview:modeBtn];
    
    NSInteger mistValue,brightnessValue,colorValue;
    
    if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"2 Hours"]){
        self.imistValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour valueForKey:@"mist"] integerValue];
        self.brightnessValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour valueForKey:@"brightness"] integerValue];
        self.colorValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour valueForKey:@"color"] integerValue];
        self.ledAutoEnable = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour valueForKey:@"auto"] integerValue];
        
    }
    else if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"4 Hours"]){
        self.imistValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour valueForKey:@"mist"] integerValue];
        self.brightnessValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour valueForKey:@"brightness"] integerValue];
        self.colorValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour valueForKey:@"color"] integerValue];
        self.ledAutoEnable = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour valueForKey:@"auto"] integerValue];
    }
    else if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"8 Hours"]){
        self.imistValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour valueForKey:@"mist"] integerValue];
        self.brightnessValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour valueForKey:@"brightness"] integerValue];
        self.colorValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour valueForKey:@"color"] integerValue];
        self.ledAutoEnable = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour valueForKey:@"auto"] integerValue];
    }
    else if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"16 Hours"]){
        self.imistValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour valueForKey:@"mist"] integerValue];
        self.brightnessValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour valueForKey:@"brightness"] integerValue];
        self.colorValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour valueForKey:@"color"] integerValue];
        self.ledAutoEnable = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour valueForKey:@"auto"] integerValue];
    }

    
    [self setUpBar:CGRectMake(20, 60, self.view.frame.size.width - 40 ,80) withTitle:@"mist" withMin:0 withMax:50 withTag:1 withValue:self.imistValue];
    [self setUpBar:CGRectMake(20, 130, self.view.frame.size.width - 40 ,80) withTitle:@"led brightness" withMin:0 withMax:100 withTag:2 withValue:self.brightnessValue];
    [self setUpBar:CGRectMake(20, 210, self.view.frame.size.width - 40 ,80) withTitle:@"led color" withMin:0 withMax:50 withTag:3 withValue:self.colorValue];
//    [self setUpBar:CGRectMake(20, 230, self.view.frame.size.width - 40 ,40) withTitle:@"led auto" withMin:0 withMax:50 withTag:4];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 280, self.view.frame.size.width ,18)];
    [lable setFont:[UIFont boldSystemFontOfSize:18]];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = @"led auto";
    lable.textColor = [UIColor colorWith256Red:129 green:189 blue:82];
    [self.view addSubview:lable];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(20, 310, 115, 44);
    if(YES == self.ledAutoEnable)
        [sureBtn setBackgroundImage:[UIImage imageNamed:@"user_set05.png"] forState:UIControlStateNormal];
    else
        [sureBtn setBackgroundImage:[UIImage imageNamed:@"user_set06.png"] forState:UIControlStateNormal];
    [sureBtn setImage:[UIImage imageNamed:@"user_set01.png"]  forState:UIControlStateNormal];
    [sureBtn setTitle:@"" forState:UIControlStateNormal];
    sureBtn.tag = 100;
    [sureBtn setBackgroundColor:[UIColor clearColor]];
    
    [sureBtn addTarget:self action:@selector(btnSure:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    
    UIButton *noBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if(YES == self.ledAutoEnable)
        [noBtn setBackgroundImage:[UIImage imageNamed:@"user_set06.png"] forState:UIControlStateNormal];
    else
        [noBtn setBackgroundImage:[UIImage imageNamed:@"user_set05.png"] forState:UIControlStateNormal];
    [noBtn setImage:[UIImage imageNamed:@"user_set02.png"]  forState:UIControlStateNormal];
    [noBtn setTitle:@"" forState:UIControlStateNormal];
    noBtn.tag = 200;
    [noBtn setBackgroundColor:[UIColor clearColor]];
    noBtn.frame = CGRectMake(self.view.frame.size.width - 20 - 115, 310, 115, 44);
    [noBtn addTarget:self action:@selector(btnNo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noBtn];
    
    NSUInteger color1 = [[self.colorR objectForKey:[NSString stringWithFormat:@"%ld",(long)self.colorValue]] integerValue] *2.55;
    NSUInteger color2 = [[self.colorG objectForKey:[NSString stringWithFormat:@"%ld",(long)self.colorValue]] integerValue] *2.55;
    NSUInteger color3 = [[self.colorB objectForKey:[NSString stringWithFormat:@"%ld",(long)self.colorValue]] integerValue] *2.55;
    self.color1Value = color1;
    self.color2Value = color2;
    self.color3Value = color3;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setUpBar:(CGRect)frame withTitle:(NSString*)label withMin:(CGFloat)mini withMax:(CGFloat)maxi withTag:(NSInteger)tag withValue:(NSInteger)value
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
    minus.image = [UIImage imageNamed:@"user_set04.png"];
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
    slider.value = value;
    //continuous属性，是指滑块值在拖地触发滑块值变动
    slider.continuous = YES;
    slider.tag = tag;
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [bg addSubview:slider];
    
    UIImageView *plus = [[UIImageView alloc] initWithFrame:CGRectMake(bg.frame.size.width - 35, 24, 30 ,30)];
    plus.image = [UIImage imageNamed:@"user_set03.png"];
    plus.backgroundColor = [UIColor clearColor];
    [bg addSubview:plus];
    
    [self.view addSubview:bg];
    
    if (!self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour ) {
        self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour = [[NSMutableDictionary alloc] init];
    }
    if (!self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour ) {
        self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour = [[NSMutableDictionary alloc] init];
    }
    if (!self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour ) {
        self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour = [[NSMutableDictionary alloc] init];
    }
    if (!self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour ) {
        self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour = [[NSMutableDictionary alloc] init];
    }
    

}

- (void) sliderValueChanged:(id)sender{
    UISlider* control = (UISlider*)sender;
    NSInteger value = control.value;
    //control.value =value;
    NSLog(@"%ld",(long)value);
    if (control.tag == 1) {
        self.imistValue = value;
    }else if(control.tag == 2) {
        self.brightnessValue = value;
    }else if(control.tag == 3) {
        self.colorValue = value;
    }
    
}

- (void) btnSure:(id)sender
{
    UIButton* sureBtn = (UIButton*)sender;
    UIButton* noBtn = (UIButton*)[self.view viewWithTag:200];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"user_set05.png"] forState:UIControlStateNormal];
    [noBtn setBackgroundImage:[UIImage imageNamed:@"user_set06.png"] forState:UIControlStateNormal];
    self.ledAutoEnable = YES;
    [self updateLedAutoValue:1];
}

- (void) btnNo:(id)sender
{
    UIButton* noBtn = (UIButton*)sender;
    UIButton* sureBtn = (UIButton*)[self.view viewWithTag:100];
    [noBtn setBackgroundImage:[UIImage imageNamed:@"user_set05.png"] forState:UIControlStateNormal];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"user_set06.png"] forState:UIControlStateNormal];
    self.ledAutoEnable = NO;
    [self updateLedAutoValue:0];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startTimer];
    UIButton *modeBtn = (UIButton*)[self.view viewWithTag:202];
    [modeBtn setTitle:self.appDelegate.defaultBTServer.selectPeripheralInfo.mode forState:UIControlStateNormal];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stopTimer];
}

- (void)startTimer {
    
    if(!self.timer){
        self.timer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(checkSendValue) userInfo:nil repeats:YES];
    }
}

- (void)stopTimer {
    
    if (self.timer) {
        if ([self.timer isValid]) {
            
            [self.timer invalidate];
            self.timer = nil;
        }
    }
}

- (void)checkSendValue{
    if(self.lastImistValue != self.imistValue){
        self.lastImistValue = self.imistValue;
        [self updateImistValue];
    }
    else if(self.lastBrightnessValue != self.brightnessValue){
        self.lastBrightnessValue = self.brightnessValue;
        [self updateBrightnessValue];
    }
    else if(self.lastColorValue != self.colorValue){
        self.lastColorValue = self.colorValue;
        [self updateColorValue];
    }
}

- (void)updateImistValue{
    NSMutableData* data = [NSMutableData data];
    NSUInteger query = 0x09;
    NSNumber *imistObj = [NSNumber numberWithInteger:self.imistValue];
    if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"2 Hours"]){
        query = 9;
        [self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour setValue:imistObj forKey:@"mist"];
    }
    else if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"4 Hours"]){
        query = 10;
        [self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour setValue:imistObj forKey:@"mist"];
    }
    else if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"8 Hours"]){
        query = 11;
        [self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour setValue:imistObj forKey:@"mist"];
    }
    else if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"16 Hours"]){
        query = 12;
        [self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour setValue:imistObj forKey:@"mist"];
    }
    
    [data appendBytes:&query length:1];
    NSUInteger imist = self.imistValue;
    [data appendBytes:&imist length:1];
    NSUInteger led = self.brightnessValue;
    [data appendBytes:&led length:1];
    NSUInteger color1 = self.color1Value;
    [data appendBytes:&color1 length:1];
    NSUInteger color2 = self.color2Value;
    [data appendBytes:&color2 length:1];
    NSUInteger color3 = self.color3Value;
    [data appendBytes:&color3 length:1];
    
    self.appDelegate.defaultBTServer.selectPeripheralInfo.curCmd = SET_WORK_MODE;
    [self.appDelegate.defaultBTServer writeValue:[self.appDelegate.defaultBTServer converCMD:data] withCharacter:[self.appDelegate.defaultBTServer findCharacteristicFromUUID:[CBUUID UUIDWithString:WRITE_CHARACTERISTIC]]];
}

- (void) updateBrightnessValue{
    NSMutableData* data = [NSMutableData data];
    NSUInteger query = 0x09;
    NSNumber *brightnessObj = [NSNumber numberWithInteger:self.brightnessValue];
    if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"2 Hours"]){
        query = 9;
        [self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour setValue:brightnessObj forKey:@"brightness"];
    }
    else if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"4 Hours"]){
        query = 10;
        [self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour setValue:brightnessObj forKey:@"brightness"];
    }
    else if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"8 Hours"]){
        query = 11;
        [self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour setValue:brightnessObj forKey:@"brightness"];
    }
    else if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"16 Hours"]){
        query = 12;
        [self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour setValue:brightnessObj forKey:@"brightness"];
    }
    [data appendBytes:&query length:1];
    NSUInteger imist = self.imistValue;
    [data appendBytes:&imist length:1];
    NSUInteger led = self.brightnessValue;
    [data appendBytes:&led length:1];
    NSUInteger color1 = self.color1Value;
    [data appendBytes:&color1 length:1];
    NSUInteger color2 = self.color2Value;
    [data appendBytes:&color2 length:1];
    NSUInteger color3 = self.color3Value;
    [data appendBytes:&color3 length:1];
    
    self.appDelegate.defaultBTServer.selectPeripheralInfo.curCmd = SET_WORK_MODE;
    [self.appDelegate.defaultBTServer writeValue:[self.appDelegate.defaultBTServer converCMD:data] withCharacter:[self.appDelegate.defaultBTServer findCharacteristicFromUUID:[CBUUID UUIDWithString:WRITE_CHARACTERISTIC]]];
}

- (void)updateColorValue{
    NSMutableData* data = [NSMutableData data];
    NSUInteger query = 0x01;
    NSNumber *colorObj = [NSNumber numberWithInteger:self.colorValue];
    if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"2 Hours"]){
        query = 9;
        [self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour setValue:colorObj forKey:@"color"];
    }
    else if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"4 Hours"]){
        query = 10;
        [self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour setValue:colorObj forKey:@"color"];
    }
    else if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"8 Hours"]){
        query = 11;
        [self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour setValue:colorObj forKey:@"color"];
    }
    else if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"16 Hours"]){
        query = 12;
        [self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour setValue:colorObj forKey:@"color"];
    }
    [data appendBytes:&query length:1];
    NSUInteger imist = self.imistValue;
    [data appendBytes:&imist length:1];
    NSUInteger led = self.brightnessValue;
    [data appendBytes:&led length:1];
    NSUInteger color1 = [[self.colorR objectForKey:[NSString stringWithFormat:@"%ld",(long)self.colorValue]] integerValue] *2.55;
    [data appendBytes:&color1 length:1];
    NSUInteger color2 = [[self.colorG objectForKey:[NSString stringWithFormat:@"%ld",(long)self.colorValue]] integerValue] *2.55;
    [data appendBytes:&color2 length:1];
    NSUInteger color3 = [[self.colorB objectForKey:[NSString stringWithFormat:@"%ld",(long)self.colorValue]] integerValue] *2.55;
    [data appendBytes:&color3 length:1];
    self.color1Value = color1;
    self.color2Value = color2;
    self.color3Value = color3;
    
    self.appDelegate.defaultBTServer.selectPeripheralInfo.curCmd = SET_WORK_MODE;
    [self.appDelegate.defaultBTServer writeValue:[self.appDelegate.defaultBTServer converCMD:data] withCharacter:[self.appDelegate.defaultBTServer findCharacteristicFromUUID:[CBUUID UUIDWithString:WRITE_CHARACTERISTIC]]];
}

- (void) updateLedAutoValue:(NSInteger)ledAutoEnable{
    NSMutableData* data = [NSMutableData data];
    NSUInteger query = 0x09;
    NSNumber *ledAutoObj = [NSNumber numberWithInteger:self.ledAutoEnable ];
    if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"2 Hours"]){
        query = 9;
        [self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour setValue:ledAutoObj forKey:@"brightness"];
    }
    else if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"4 Hours"]){
        query = 10;
        [self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour setValue:ledAutoObj forKey:@"brightness"];
    }
    else if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"8 Hours"]){
        query = 11;
        [self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour setValue:ledAutoObj forKey:@"brightness"];
    }
    else if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"16 Hours"]){
        query = 12;
        [self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour setValue:ledAutoObj forKey:@"brightness"];
    }
    [data appendBytes:&query length:1];
    NSUInteger imist = self.imistValue;
    [data appendBytes:&imist length:1];
    if(ledAutoEnable){
        NSUInteger led = 0x65;
        [data appendBytes:&led length:1];
        NSUInteger color1 = 0;
        [data appendBytes:&color1 length:1];
        NSUInteger color2 = 0;
        [data appendBytes:&color2 length:1];
        NSUInteger color3 = 0;
        [data appendBytes:&color3 length:1];
    }
    else{
        NSUInteger led = self.brightnessValue;
        [data appendBytes:&led length:1];
        NSUInteger color1 = self.color1Value;
        [data appendBytes:&color1 length:1];
        NSUInteger color2 = self.color2Value;
        [data appendBytes:&color2 length:1];
        NSUInteger color3 = self.color3Value;
        [data appendBytes:&color3 length:1];
    }
    
    self.appDelegate.defaultBTServer.selectPeripheralInfo.curCmd = SET_WORK_MODE;
    [self.appDelegate.defaultBTServer writeValue:[self.appDelegate.defaultBTServer converCMD:data] withCharacter:[self.appDelegate.defaultBTServer findCharacteristicFromUUID:[CBUUID UUIDWithString:WRITE_CHARACTERISTIC]]];
}


@end
