//
//  SettingUser.m
//  Imist
//
//  Created by chao.ou on 15/1/18.
//  Copyright (c) 2015年 oc. All rights reserved.
//

#import "SettingUser.h"
#import "Manager.h"

@interface SettingUser ()
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger imistValue;
@property (nonatomic, assign) NSInteger brightnessValue;
@property (nonatomic, assign) NSInteger colorValue;
@property (nonatomic, assign) NSInteger color1Value;
@property (nonatomic, assign) NSInteger color2Value;
@property (nonatomic, assign) NSInteger color3Value;
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
    //if(!self.title) self.title = title;
    self.title = self.appDelegate.defaultBTServer.selectPeripheralInfo.name;
    self.navigationController.navigationBar.topItem.title = self.title;

    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake( 0, 0, 44, 44)];
    [leftBtn setImage:[UIImage imageNamed:@"back-arrow.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    //self.view.backgroundColor=[UIColor whiteColor];
    self.view.backgroundColor = [UIColor colorWith256Red:222 green:222 blue:221];
    
    UIButton *modeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [modeBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn_green.png"] forState:UIControlStateNormal];
    [modeBtn setTitle:self.appDelegate.defaultBTServer.selectPeripheralInfo.mode forState:UIControlStateNormal];
    [modeBtn setBackgroundColor:[UIColor clearColor]];
    modeBtn.frame = CGRectMake((self.view.frame.size.width - 130)/2, 10, 130, 40);
    modeBtn.tag = 202;
    [self.view addSubview:modeBtn];
    
    self.imistValue = [self.appDelegate.defaultBTServer.selectPeripheralInfo.imist integerValue];
    self.lastImistValue = self.imistValue;
    self.brightnessValue = [self.appDelegate.defaultBTServer.selectPeripheralInfo.ledlight integerValue];
    self.lastBrightnessValue = self.brightnessValue;
    self.colorValue = [self.appDelegate.defaultBTServer.selectPeripheralInfo.ledcolor integerValue];
    self.lastColorValue = self.colorValue;
    self.ledAutoEnable = [self.appDelegate.defaultBTServer.selectPeripheralInfo.ledauto integerValue];
    
    [self setUpBar:CGRectMake(20, 60, self.view.frame.size.width - 40 ,80) withTitle:@"mist" withMin:0 withMax:50 withTag:1 withValue:self.imistValue];
    [self setUpBar:CGRectMake(20, 130, self.view.frame.size.width - 40 ,80) withTitle:@"led brightness" withMin:0 withMax:46 withTag:2 withValue:self.brightnessValue];
    [self setUpBar:CGRectMake(20, 210, self.view.frame.size.width - 40 ,80) withTitle:@"led color" withMin:1 withMax:100 withTag:3 withValue:self.colorValue];
//    [self setUpBar:CGRectMake(20, 230, self.view.frame.size.width - 40 ,40) withTitle:@"led auto" withMin:0 withMax:50 withTag:4];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 290, self.view.frame.size.width ,18)];
    [lable setFont:[UIFont boldSystemFontOfSize:18]];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = @"led auto";
    lable.textColor = [UIColor colorWith256Red:129 green:189 blue:82];
    [self.view addSubview:lable];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(self.view.frame.size.width - 35 - 115, 310, 100, 44);
    if(1 == self.ledAutoEnable)
        [sureBtn setBackgroundImage:[UIImage imageNamed:@"user_set05.png"] forState:UIControlStateNormal];
    else
        [sureBtn setBackgroundImage:[UIImage imageNamed:@"user_set06.png"] forState:UIControlStateNormal];
    [sureBtn setImage:[UIImage imageNamed:@"yes.png"]  forState:UIControlStateNormal];
    [sureBtn setTitle:@"" forState:UIControlStateNormal];
    sureBtn.tag = 100;
    [sureBtn setBackgroundColor:[UIColor clearColor]];
    
    [sureBtn addTarget:self action:@selector(btnSure:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    
    UIButton *noBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if(1 == self.ledAutoEnable)
        [noBtn setBackgroundImage:[UIImage imageNamed:@"user_set06.png"] forState:UIControlStateNormal];
    else
        [noBtn setBackgroundImage:[UIImage imageNamed:@"user_set05.png"] forState:UIControlStateNormal];
    [noBtn setImage:[UIImage imageNamed:@"no.png"]  forState:UIControlStateNormal];
    [noBtn setTitle:@"" forState:UIControlStateNormal];
    noBtn.tag = 200;
    [noBtn setBackgroundColor:[UIColor clearColor]];
    noBtn.frame = CGRectMake(50, 310, 100, 44);
    [noBtn addTarget:self action:@selector(btnNo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noBtn];
    
    Manager *sharedManager = [Manager sharedManager];
    NSUInteger color1 = [sharedManager getColorR:self.colorValue];
    NSUInteger color2 = [sharedManager getColorG:self.colorValue];
    NSUInteger color3 = [sharedManager getColorB:self.colorValue];
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
    
    UIImageView *minus = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 20 ,20)];
    minus.image = [UIImage imageNamed:@"minus.png"];
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
    
    UIImageView *plus = [[UIImageView alloc] initWithFrame:CGRectMake(bg.frame.size.width - 30, 30, 20 ,20)];
    plus.image = [UIImage imageNamed:@"plus.png"];
    plus.backgroundColor = [UIColor clearColor];
    [bg addSubview:plus];
    
    [self.view addSubview:bg];
    

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
    self.ledAutoEnable = 1;
    if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"2 Hours"]){
        [self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour setValue:[NSNumber numberWithInt:1] forKey:@"auto"];
    } else if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"4 Hours"]) {
        [self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour setValue:[NSNumber numberWithInt:1] forKey:@"auto"];
    }else if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"8 Hours"]) {
        [self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour setValue:[NSNumber numberWithInt:1] forKey:@"auto"];
    }else if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"16 Hours"]) {
        [self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour setValue:[NSNumber numberWithInt:1] forKey:@"auto"];
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self.appDelegate.defaultBTServer.selectPeripheralInfo];
    [defaults setObject:encodedObject forKey:self.appDelegate.defaultBTServer.selectPeripheralInfo.uuid];
    [defaults synchronize];
    [self updateLedAutoValue:1];
    UISlider *slider2 = (UISlider*)[self.view viewWithTag:2];
    slider2.enabled = NO;
    UISlider *slider3 = (UISlider*)[self.view viewWithTag:3];
    slider3.enabled = NO;}

- (void) btnNo:(id)sender
{
    UIButton* noBtn = (UIButton*)sender;
    UIButton* sureBtn = (UIButton*)[self.view viewWithTag:100];
    [noBtn setBackgroundImage:[UIImage imageNamed:@"user_set05.png"] forState:UIControlStateNormal];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"user_set06.png"] forState:UIControlStateNormal];
    self.ledAutoEnable = 0;
    
    if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"2 Hours"]){
        [self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour setValue:[NSNumber numberWithInt:0] forKey:@"auto"];
    } else if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"4 Hours"]) {
        [self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour setValue:[NSNumber numberWithInt:0] forKey:@"auto"];
    }else if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"8 Hours"]) {
        [self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour setValue:[NSNumber numberWithInt:0] forKey:@"auto"];
    }else if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"16 Hours"]) {
        [self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour setValue:[NSNumber numberWithInt:0] forKey:@"auto"];
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self.appDelegate.defaultBTServer.selectPeripheralInfo];
    [defaults setObject:encodedObject forKey:self.appDelegate.defaultBTServer.selectPeripheralInfo.uuid];
    [defaults synchronize];
    [self updateLedAutoValue:0];
    UISlider *slider2 = (UISlider*)[self.view viewWithTag:2];
    slider2.enabled = YES;
    UISlider *slider3 = (UISlider*)[self.view viewWithTag:3];
    slider3.enabled = YES;

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startTimer];
    UIButton *modeBtn = (UIButton*)[self.view viewWithTag:202];
    [modeBtn setTitle:self.appDelegate.defaultBTServer.selectPeripheralInfo.mode forState:UIControlStateNormal];
    UISlider *slider1 = (UISlider*)[self.view viewWithTag:1];
    UISlider *slider2 = (UISlider*)[self.view viewWithTag:2];
    UISlider *slider = (UISlider*)[self.view viewWithTag:3];
    UIButton* noBtn = (UIButton*)[self.view viewWithTag:200];;
    UIButton* sureBtn = (UIButton*)[self.view viewWithTag:100];
    if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"2 Hours"]){
        //        self.imistValue = [self.appDelegate.defaultBTServer.selectPeripheralInfo.imist integerValue];
        //        self.brightnessValue = [self.appDelegate.defaultBTServer.selectPeripheralInfo.ledlight integerValue];
        //        self.colorValue = [self.appDelegate.defaultBTServer.selectPeripheralInfo.ledcolor integerValue];
        //        self.ledAutoEnable = [self.appDelegate.defaultBTServer.selectPeripheralInfo.ledauto integerValue];
        if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour count]){
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour valueForKey:@"mist"] ==nil)
                self.imistValue = 50;
            else
                self.imistValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour valueForKey:@"mist"] integerValue];
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour valueForKey:@"brightness"] ==nil)
                self.brightnessValue = 46;
            else
                self.brightnessValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour valueForKey:@"brightness"] integerValue];
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour valueForKey:@"color"] ==nil)
                self.colorValue = 100;
            else
                self.colorValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour valueForKey:@"color"] integerValue];
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour valueForKey:@"auto"] ==nil)
                self.ledAutoEnable = 0;
            else
                self.ledAutoEnable = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour valueForKey:@"auto"] integerValue];
        }
        else{
            self.imistValue = 50;
            self.brightnessValue = 46;
            self.colorValue = 100;
            self.ledAutoEnable = 0;
        }
        
    }
    else if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"4 Hours"]){
        if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour count]){
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour valueForKey:@"mist"] ==nil)
                self.imistValue = 50;
            else
                self.imistValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour valueForKey:@"mist"] integerValue];
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour valueForKey:@"brightness"] ==nil)
                self.brightnessValue = 46;
            else
                self.brightnessValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour valueForKey:@"brightness"] integerValue];
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour valueForKey:@"color"] ==nil)
                self.colorValue = 100;
            else
                self.colorValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour valueForKey:@"color"] integerValue];
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour valueForKey:@"auto"] ==nil)
                self.ledAutoEnable = 0;
            else
                self.ledAutoEnable = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour valueForKey:@"auto"] integerValue];
        }
        else{
            self.imistValue = 50;
            self.brightnessValue = 46;
            self.colorValue = 100;
            self.ledAutoEnable = 0;
        }

    
    }
    else if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"8 Hours"]){
        if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour count]){
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour valueForKey:@"mist"] ==nil)
                self.imistValue = 50;
            else
                self.imistValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour valueForKey:@"mist"] integerValue];
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour valueForKey:@"brightness"] ==nil)
                self.brightnessValue = 46;
            else
                self.brightnessValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour valueForKey:@"brightness"] integerValue];
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour valueForKey:@"color"] ==nil)
                self.colorValue = 100;
            else
                self.colorValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour valueForKey:@"color"] integerValue];
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour valueForKey:@"auto"] ==nil)
                self.ledAutoEnable = 0;
            else
                self.ledAutoEnable = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour valueForKey:@"auto"] integerValue];
        }
        else{
            self.imistValue = 50;
            self.brightnessValue = 46;
            self.colorValue = 100;
            self.ledAutoEnable = 0;
        }


    }
    else if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"16 Hours"]){
        if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour count]){
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour valueForKey:@"mist"] ==nil)
                self.imistValue = 50;
            else
                self.imistValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour valueForKey:@"mist"] integerValue];
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour valueForKey:@"brightness"] ==nil)
                self.brightnessValue = 46;
            else
                self.brightnessValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour valueForKey:@"brightness"] integerValue];
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour valueForKey:@"color"] ==nil)
                self.colorValue = 100;
            else
                self.colorValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour valueForKey:@"color"] integerValue];
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour valueForKey:@"auto"] ==nil)
                self.ledAutoEnable = 0;
            else
                self.ledAutoEnable = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour valueForKey:@"auto"] integerValue];
        }
        else{
            self.imistValue = 50;
            self.brightnessValue = 46;
            self.colorValue = 100;
            self.ledAutoEnable = 0;
        }

    }
    self.lastImistValue = self.imistValue;
    self.lastBrightnessValue = self.brightnessValue;
    self.lastColorValue = self.colorValue;
    Manager *sharedManager = [Manager sharedManager];
    self.color1Value = [sharedManager getColorR:self.colorValue];
    self.color2Value = [sharedManager getColorG:self.colorValue];
    self.color3Value = [sharedManager getColorB:self.colorValue];
    
    slider1.value = self.imistValue;
    slider2.value = self.brightnessValue;
    slider.value = self.colorValue;
    
    if(self.ledAutoEnable){
        slider.enabled = NO;
        slider2.enabled = NO;
        [noBtn setBackgroundImage:[UIImage imageNamed:@"user_set06.png"] forState:UIControlStateNormal];
        [sureBtn setBackgroundImage:[UIImage imageNamed:@"user_set05.png"] forState:UIControlStateNormal];
    }
    else{
        slider.enabled = YES;
        slider2.enabled = YES;
        [noBtn setBackgroundImage:[UIImage imageNamed:@"user_set05.png"] forState:UIControlStateNormal];
        [sureBtn setBackgroundImage:[UIImage imageNamed:@"user_set06.png"] forState:UIControlStateNormal];
    }
    
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
    if(self.ledAutoEnable)
        led = 0x65;
    [data appendBytes:&led length:1];
    NSUInteger color1 = self.color1Value;
    [data appendBytes:&color1 length:1];
    NSUInteger color2 = self.color2Value;
    [data appendBytes:&color2 length:1];
    NSUInteger color3 = self.color3Value;
    [data appendBytes:&color3 length:1];
    
    self.appDelegate.defaultBTServer.selectPeripheralInfo.curCmd = SET_WORK_MODE;
    [self.appDelegate.defaultBTServer writeValue:[self.appDelegate.defaultBTServer converCMD:data] withCharacter:[self.appDelegate.defaultBTServer findCharacteristicFromUUID:[CBUUID UUIDWithString:WRITE_CHARACTERISTIC]]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self.appDelegate.defaultBTServer.selectPeripheralInfo];
    [defaults setObject:encodedObject forKey:self.appDelegate.defaultBTServer.selectPeripheralInfo.uuid];
    [defaults synchronize];
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
    if(self.ledAutoEnable)
        led = 0x65;
    [data appendBytes:&led length:1];
    NSUInteger color1 = self.color1Value;
    [data appendBytes:&color1 length:1];
    NSUInteger color2 = self.color2Value;
    [data appendBytes:&color2 length:1];
    NSUInteger color3 = self.color3Value;
    [data appendBytes:&color3 length:1];
    
    self.appDelegate.defaultBTServer.selectPeripheralInfo.curCmd = SET_WORK_MODE;
    [self.appDelegate.defaultBTServer writeValue:[self.appDelegate.defaultBTServer converCMD:data] withCharacter:[self.appDelegate.defaultBTServer findCharacteristicFromUUID:[CBUUID UUIDWithString:WRITE_CHARACTERISTIC]]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self.appDelegate.defaultBTServer.selectPeripheralInfo];
    [defaults setObject:encodedObject forKey:self.appDelegate.defaultBTServer.selectPeripheralInfo.uuid];
    [defaults synchronize];
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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self.appDelegate.defaultBTServer.selectPeripheralInfo];
    [defaults setObject:encodedObject forKey:self.appDelegate.defaultBTServer.selectPeripheralInfo.uuid];
    [defaults synchronize];
    
    [data appendBytes:&query length:1];
    NSUInteger imist = self.imistValue;
    [data appendBytes:&imist length:1];
    NSUInteger led = self.brightnessValue;
    [data appendBytes:&led length:1];
    Manager *sharedManager = [Manager sharedManager];
    NSUInteger color1 = [sharedManager getColorR:self.colorValue];
    [data appendBytes:&color1 length:1];
    NSUInteger color2 = [sharedManager getColorG:self.colorValue];
    [data appendBytes:&color2 length:1];
    NSUInteger color3 = [sharedManager getColorB:self.colorValue];
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
    }
    else if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"4 Hours"]){
        query = 10;
    }
    else if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"8 Hours"]){
        query = 11;
    }
    else if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"16 Hours"]){
        query = 12;
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
