//
//  SettingModeVCViewController.m
//  Imist
//
//  Created by chao.ou on 15/1/18.
//  Copyright (c) 2015年 oc. All rights reserved.
//

#import "SettingModeVC.h"
#import "Manager.h"

@interface SettingModeVC ()
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSMutableDictionary * essenceName;

@property (nonatomic, strong) NSString* modeString;
@end
typedef enum{
    HAS_WATER_AND_WORK,
    HAS_WATER_NOT_WORK,
    NO_WATER,
    NO_MODE
}waterStatus;
@implementation SettingModeVC
@synthesize title,essenceName;
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
    
    if(self.appDelegate.defaultBTServer.selectPeripheralInfo.mode)
    {
        Manager *sharedManager = [Manager sharedManager];
        [sharedManager getWaterStatus];
        if(self.appDelegate.defaultBTServer.selectPeripheralInfo.intentAction == INIT_SET_WORK_MODE)
        {
            self.appDelegate.defaultBTServer.selectPeripheralInfo.intentAction = SET_WORK_MODE;
        }
        else{
            self.appDelegate.defaultBTServer.selectPeripheralInfo.intentAction = SHOW_WORK_MODE;
        }
        
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(waterStatusUpdated)
                                                 name:@"WATER_STATUS_UPDATED"
                                               object:nil];
    
    self.essenceName = [[NSMutableDictionary alloc] init];
    [self.essenceName setValue:@" Lemon " forKey:@"Relaxation"];
    [self.essenceName setValue:@" Lavender " forKey:@"Sleep"];
    [self.essenceName setValue:@" Rosemary " forKey:@"Energization"];
    [self.essenceName setValue:@" Orange " forKey:@"Soothing"];
    [self.essenceName setValue:@" Eucalytus " forKey:@"Concentration"];
    [self.essenceName setValue:@" Rose " forKey:@"Sensuality"];
    [self.essenceName setValue:@" your favourite " forKey:@"2 Hours"];
    [self.essenceName setValue:@" your favourite " forKey:@"4 Hours"];
    [self.essenceName setValue:@" your favourite " forKey:@"8 Hours"];
    [self.essenceName setValue:@" your favourite " forKey:@"16 Hours"];
    

}

- (NSString *) composeHint:(NSString*)essence
{
    if(essence){
    NSMutableString * hint = [[NSMutableString alloc] init];
    [hint appendString:@"Please add clean, cold water & 5-10 drops of"];
    [hint appendString:essence];
    [hint appendString:@"essential oil into water tank of IMIST(make sure not over max level), then replace the cover."];
    return hint;
    }else{
        return nil;
    }
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

    [sixBtn setTitle:@"16 Hours" forState:UIControlStateNormal];
    [sixBtn setBackgroundColor:[UIColor clearColor]];
    sixBtn.frame = CGRectMake(self.view.frame.size.width - 20 - 130, 300, 130, 40);
    sixBtn.tag = 14;
    [sixBtn addTarget:self action:@selector(hoursClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sixBtn];
}

- (void)showHint:(NSString*)hintString{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hint" message:hintString delegate:self cancelButtonTitle:@"Don't show again" otherButtonTitles:@"OK", nil];
    alertView.tag = 20;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    self.appDelegate.defaultBTServer.selectPeripheralInfo.intentAction = SET_WORK_MODE;
    Manager *sharedManager = [Manager sharedManager];
    [sharedManager getWaterStatus];
    if(alertView.tag==20){
        if(buttonIndex == 0){ //"don't show this again" touched
            [self setDoNotShowHint: YES];
        }
        else{ //"done" touched
        }
    }
}

-(void)btnClick:(UIButton*)sender{
    if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:sender.titleLabel.text]){
        [self stopCurMode];
        self.appDelegate.defaultBTServer.selectPeripheralInfo.mode = nil;
        return;
    }
    if([sender.titleLabel.text isEqualToString:@"Relaxation"]){
        self.appDelegate.defaultBTServer.selectPeripheralInfo.mode = @"Relaxation";
    }
    else if([sender.titleLabel.text isEqualToString:@"Sleep"]){
        self.appDelegate.defaultBTServer.selectPeripheralInfo.mode = @"Sleep";
    }
    else if([sender.titleLabel.text isEqualToString:@"Energization"]){
        self.appDelegate.defaultBTServer.selectPeripheralInfo.mode = @"Energization";
    }
    else if([sender.titleLabel.text isEqualToString:@"Soothing"]){
        self.appDelegate.defaultBTServer.selectPeripheralInfo.mode = @"Soothing";
    }
    else if([sender.titleLabel.text isEqualToString:@"Concentration"]){
        self.appDelegate.defaultBTServer.selectPeripheralInfo.mode = @"Concentration";
    }
    else if([sender.titleLabel.text isEqualToString:@"Sensuality"]){
        self.appDelegate.defaultBTServer.selectPeripheralInfo.mode = @"Sensuality";
    }
    self.modeString = sender.titleLabel.text;
    Manager *sharedManager = [Manager sharedManager];
    [sharedManager getWaterStatus];

    if(NO == [self getDoNotShowHint]){ //show the message box
        self.appDelegate.defaultBTServer.selectPeripheralInfo.intentAction = SHOW_HINT;
        //action will be forward to hint messagebox button
    }
    else{
        self.appDelegate.defaultBTServer.selectPeripheralInfo.intentAction = SET_WORK_MODE;
    }
}


-(void)hoursClick:(UIButton*)btn{
    if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:btn.titleLabel.text]){
        [self stopCurMode];
        self.appDelegate.defaultBTServer.selectPeripheralInfo.mode = nil;
        return;
    }
    if([btn.titleLabel.text isEqualToString:@"2 Hours"]){
        self.appDelegate.defaultBTServer.selectPeripheralInfo.mode = @"2 Hours";
    }
    else if([btn.titleLabel.text isEqualToString:@"4 Hours"]){
        self.appDelegate.defaultBTServer.selectPeripheralInfo.mode = @"4 Hours";
    }
    else if([btn.titleLabel.text isEqualToString:@"8 Hours"]){
        self.appDelegate.defaultBTServer.selectPeripheralInfo.mode = @"8 Hours";
    }
    else if([btn.titleLabel.text isEqualToString:@"16 Hours"]){
        self.appDelegate.defaultBTServer.selectPeripheralInfo.mode = @"16 Hours";
    }
    
    self.modeString = btn.titleLabel.text;
    
    Manager *sharedManager = [Manager sharedManager];
    [sharedManager getWaterStatus];
    if(NO == [self getDoNotShowHint]){ //show the message box
        self.appDelegate.defaultBTServer.selectPeripheralInfo.intentAction = SHOW_HINT;//will forward to alert show button action
    }
    else{
        self.appDelegate.defaultBTServer.selectPeripheralInfo.intentAction = SET_WORK_MODE;
    }

}

- (void)setMode:(NSString*)modeString waterStatus:(NSInteger)status{
    NSInteger btnTag;
    if(!modeString)
        return;
    if([modeString isEqualToString:@"Relaxation"]){
        btnTag = 1;
    }
    else if([modeString isEqualToString:@"Sleep"]){
        btnTag = 2;
    }
    else if([modeString isEqualToString:@"Energization"]){
        btnTag = 3;
    }
    else if([modeString isEqualToString:@"Soothing"]){
        btnTag = 4;
    }
    else if([modeString isEqualToString:@"Concentration"]){
        btnTag = 5;
    }
    else if([modeString isEqualToString:@"Sensuality"]){
        btnTag = 6;
    }else if([modeString isEqualToString:@"2 Hours"]){
        btnTag = 11;
    }
    else if([modeString isEqualToString:@"4 Hours"]){
        btnTag = 12;
    }
    else if([modeString isEqualToString:@"8 Hours"]){
        btnTag = 13;
    }
    else if([modeString isEqualToString:@"16 Hours"]){
        btnTag = 14;
    }
    
    if(status == HAS_WATER_AND_WORK && btnTag <=6)
        [self sendAutoModeCmd:self.modeString];
    else
        [self sendUserModeCmd:self.modeString];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        for(UInt8 i = 1; i<=6; i++){
            UIButton * btn = (UIButton*)[self.view viewWithTag:i];
            [btn setBackgroundImage:[UIImage imageNamed:@"bg_btn_gray.png"] forState:UIControlStateNormal];
        }
        for(UInt8 i = 11; i<=14; i++){
            UIButton * btn = (UIButton*)[self.view viewWithTag:i];
            [btn setBackgroundImage:[UIImage imageNamed:@"bg_btn_gray.png"] forState:UIControlStateNormal];
        }
        
        UIButton * btn = (UIButton*)[self.view viewWithTag:btnTag];
        if(status == 0){
            [btn setBackgroundImage:[UIImage imageNamed:@"bg_btn_green.png"] forState:UIControlStateNormal];
        }
        else if(status == 1){
            [btn setBackgroundImage:[UIImage imageNamed:@"bg_btn_blue.png"] forState:UIControlStateNormal];
        }
        else if(status == 2){
            [btn setBackgroundImage:[UIImage imageNamed:@"bg_btn_red.png"] forState:UIControlStateNormal];
        }
    });
    
}


- (void)showMode:(NSString*)modeString waterStatus:(NSInteger)status{
    NSInteger btnTag;
    if(!modeString)
        return;
    if([modeString isEqualToString:@"Relaxation"]){
        btnTag = 1;
    }
    else if([modeString isEqualToString:@"Sleep"]){
        btnTag = 2;
    }
    else if([modeString isEqualToString:@"Energization"]){
        btnTag = 3;
    }
    else if([modeString isEqualToString:@"Soothing"]){
        btnTag = 4;
    }
    else if([modeString isEqualToString:@"Concentration"]){
        btnTag = 5;
    }
    else if([modeString isEqualToString:@"Sensuality"]){
        btnTag = 6;
    }else if([modeString isEqualToString:@"2 Hours"]){
        btnTag = 11;
    }
    else if([modeString isEqualToString:@"4 Hours"]){
        btnTag = 12;
    }
    else if([modeString isEqualToString:@"8 Hours"]){
        btnTag = 13;
    }
    else if([modeString isEqualToString:@"16 Hours"]){
        btnTag = 14;
    }
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        for(UInt8 i = 1; i<=6; i++){
            UIButton * btn = (UIButton*)[self.view viewWithTag:i];
            [btn setBackgroundImage:[UIImage imageNamed:@"bg_btn_gray.png"] forState:UIControlStateNormal];
        }
        for(UInt8 i = 11; i<=14; i++){
            UIButton * btn = (UIButton*)[self.view viewWithTag:i];
            [btn setBackgroundImage:[UIImage imageNamed:@"bg_btn_gray.png"] forState:UIControlStateNormal];
        }
        
        UIButton * btn = (UIButton*)[self.view viewWithTag:btnTag];
        if(status == HAS_WATER_AND_WORK){
            [btn setBackgroundImage:[UIImage imageNamed:@"bg_btn_green.png"] forState:UIControlStateNormal];
        }
        else if(status == HAS_WATER_NOT_WORK){
            [btn setBackgroundImage:[UIImage imageNamed:@"bg_btn_blue.png"] forState:UIControlStateNormal];
        }
        else if(status == NO_WATER){
            [btn setBackgroundImage:[UIImage imageNamed:@"bg_btn_red.png"] forState:UIControlStateNormal];
        }
        //else if(status == NO_MODE){
        //    [btn setBackgroundImage:[UIImage imageNamed:@"bg_btn_gray.png"] forState:UIControlStateNormal];
        //}
    });
    
}

- (void)sendAutoModeCmd:(NSString*)modeString{
    
    NSInteger cmd = 0;
    
    if([modeString isEqualToString:@"Relaxation"]){
        cmd = 3;
    }
    else if([modeString isEqualToString:@"Sleep"]){
        cmd = 4;
    }
    else if([modeString isEqualToString:@"Energization"]){
        cmd = 5;
    }
    else if([modeString isEqualToString:@"Soothing"]){
        cmd = 6;
    }
    else if([modeString isEqualToString:@"Concentration"]){
        cmd = 7;
    }
    else if([modeString isEqualToString:@"Sensuality"]){
        cmd = 8;
    }
    NSMutableData* data = [NSMutableData data];
    
    NSUInteger query = cmd;
    [data appendBytes:&query length:1];
    NSUInteger imist = 0x0;
    [data appendBytes:&imist length:1];
    NSUInteger led = 0x0;
    [data appendBytes:&led length:1];
    NSUInteger color1 = 0x0;
    [data appendBytes:&color1 length:1];
    NSUInteger color2 = 0x0;
    [data appendBytes:&color2 length:1];
    NSUInteger color3 = 0x0;
    [data appendBytes:&color3 length:1];
    if(self.appDelegate.defaultBTServer.selectPeripheral.state == CBPeripheralStateConnected){
    self.appDelegate.defaultBTServer.selectPeripheralInfo.curCmd = SET_WORK_MODE;
    [self.appDelegate.defaultBTServer writeValue:[self.appDelegate.defaultBTServer converCMD:data] withCharacter:[self.appDelegate.defaultBTServer findCharacteristicFromUUID:[CBUUID UUIDWithString:WRITE_CHARACTERISTIC]]];
    }
    
}

- (void)sendUserModeCmd:(NSString*)modeString{
    
    NSInteger cmd = 0;

    NSUInteger mistValue = 0;
    NSUInteger brightnessValue = 0;
    NSUInteger colorValue = 0;
    NSUInteger ledauto = 0;
    
    if([modeString isEqualToString:@"2 Hours"]){
        cmd = 9;
        if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour count]){
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour valueForKey:@"mist"] ==nil)
                mistValue = 50;
            else
                mistValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour valueForKey:@"mist"] integerValue];
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour valueForKey:@"brightness"] ==nil)
                brightnessValue = 46;
            else
                brightnessValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour valueForKey:@"brightness"] integerValue];
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour valueForKey:@"color"] ==nil)
                colorValue = 100;
            else
                colorValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour valueForKey:@"color"] integerValue];
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour valueForKey:@"auto"] ==nil)
                ledauto = 0;
            else
                ledauto = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour valueForKey:@"auto"] integerValue];
        }
        else{
            mistValue = 50;
            brightnessValue = 46;
            colorValue = 100;
            ledauto = 0;
        }
    }
    else if([modeString isEqualToString:@"4 Hours"]){
        cmd = 10;
        if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour count]){
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour valueForKey:@"mist"] ==nil)
                mistValue = 50;
            else
                mistValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour valueForKey:@"mist"] integerValue];
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour valueForKey:@"brightness"] ==nil)
                brightnessValue = 46;
            else
                brightnessValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour valueForKey:@"brightness"] integerValue];
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour valueForKey:@"color"] ==nil)
                colorValue = 100;
            else
                colorValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour valueForKey:@"color"] integerValue];
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour valueForKey:@"auto"] ==nil)
                ledauto = 0;
            else
                ledauto = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour valueForKey:@"auto"] integerValue];
        }
        else{
            mistValue = 50;
            brightnessValue = 46;
            colorValue = 100;
            ledauto = 0;
        }
    }
    else if([modeString isEqualToString:@"8 Hours"]){
        cmd = 11;
        if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour count]){
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour valueForKey:@"mist"] ==nil)
                mistValue = 50;
            else
                mistValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour valueForKey:@"mist"] integerValue];
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour valueForKey:@"brightness"] ==nil)
                brightnessValue = 46;
            else
                brightnessValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour valueForKey:@"brightness"] integerValue];
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour valueForKey:@"color"] ==nil)
                colorValue = 100;
            else
                colorValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour valueForKey:@"color"] integerValue];
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour valueForKey:@"auto"] ==nil)
                ledauto = 0;
            else
                ledauto = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour valueForKey:@"auto"] integerValue];
        }
        else{
            mistValue = 50;
            brightnessValue = 46;
            colorValue = 100;
            ledauto = 0;
        }
    }
    else if([modeString isEqualToString:@"16 Hours"]){
        cmd = 12;
        if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour count]){
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour valueForKey:@"mist"] ==nil)
                mistValue = 50;
            else
                mistValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour valueForKey:@"mist"] integerValue];
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour valueForKey:@"brightness"] ==nil)
                brightnessValue = 46;
            else
                brightnessValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour valueForKey:@"brightness"] integerValue];
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour valueForKey:@"color"] ==nil)
                colorValue = 100;
            else
                colorValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour valueForKey:@"color"] integerValue];
            if([self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour valueForKey:@"auto"] ==nil)
                ledauto = 0;
            else
                ledauto = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour valueForKey:@"auto"] integerValue];
        }
        else{
            mistValue = 50;
            brightnessValue = 46;
            colorValue = 100;
            ledauto = 0;
        }
    }
    NSMutableData* data = [NSMutableData data];
    
    NSUInteger query = cmd;
    [data appendBytes:&query length:1];
    NSUInteger imist = mistValue;
    [data appendBytes:&imist length:1];
    NSUInteger led = brightnessValue;
    //[data appendBytes:&led length:1];
    if(ledauto)
        led = 0x65;
    [data appendBytes:&led length:1];
    Manager *sharedManager = [Manager sharedManager];
    NSInteger color1 = [sharedManager getColorR:colorValue];
    NSInteger color2 = [sharedManager getColorG:colorValue];
    NSInteger color3 = [sharedManager getColorB:colorValue];
    [data appendBytes:&color1 length:1];
    [data appendBytes:&color2 length:1];
    [data appendBytes:&color3 length:1];
    if(self.appDelegate.defaultBTServer.selectPeripheral.state == CBPeripheralStateConnected){
    self.appDelegate.defaultBTServer.selectPeripheralInfo.curCmd = SET_WORK_MODE;
    [self.appDelegate.defaultBTServer writeValue:[self.appDelegate.defaultBTServer converCMD:data] withCharacter:[self.appDelegate.defaultBTServer findCharacteristicFromUUID:[CBUUID UUIDWithString:WRITE_CHARACTERISTIC]]];
    }
    
}

-(void) stopCurMode{
    if(self.appDelegate.defaultBTServer.selectPeripheral.state == CBPeripheralStateConnected){
    NSMutableData* data = [NSMutableData data];
    
    NSUInteger query = 0x01;
    [data appendBytes:&query length:1];
    NSUInteger imist = 0x0;
    [data appendBytes:&imist length:1];
    NSUInteger led = 0x0;
    [data appendBytes:&led length:1];
    NSUInteger color1 = 0x0;
    [data appendBytes:&color1 length:1];
    NSUInteger color2 = 0x0;
    [data appendBytes:&color2 length:1];
    NSUInteger color3 = 0x0;
    [data appendBytes:&color3 length:1];
    
    self.appDelegate.defaultBTServer.selectPeripheralInfo.curCmd = SET_WORK_MODE;
    [self.appDelegate.defaultBTServer writeValue:[self.appDelegate.defaultBTServer converCMD:data] withCharacter:[self.appDelegate.defaultBTServer findCharacteristicFromUUID:[CBUUID UUIDWithString:WRITE_CHARACTERISTIC]]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        for(UInt8 i = 1; i<=6; i++){
            UIButton * btn = (UIButton*)[self.view viewWithTag:i];
            [btn setBackgroundImage:[UIImage imageNamed:@"bg_btn_gray.png"] forState:UIControlStateNormal];
        }
        for(UInt8 i = 11; i<=14; i++){
            UIButton * btn = (UIButton*)[self.view viewWithTag:i];
            [btn setBackgroundImage:[UIImage imageNamed:@"bg_btn_gray.png"] forState:UIControlStateNormal];
        }
    });
    }
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /*if(self.appDelegate.defaultBTServer.selectPeripheralInfo.mode)
    {
        Manager *sharedManager = [Manager sharedManager];
        [sharedManager getWaterStatus];
        
        self.appDelegate.defaultBTServer.selectPeripheralInfo.intentAction = GET_WATER_STATUS;
    }*/
}

- (void)setDoNotShowHint:(BOOL)yesNo{
    if(!self.modeString){ //nil
        return;
    }
    if([self.modeString isEqualToString:@"Relaxation"]){
        self.appDelegate.defaultBTServer.selectPeripheralInfo.doNotShowHint_Relaxation = yesNo;
    }
    else if([self.modeString isEqualToString:@"Sleep"]){
        self.appDelegate.defaultBTServer.selectPeripheralInfo.doNotShowHint_Sleep = yesNo;
    }
    else if([self.modeString isEqualToString:@"Energization"]){
        self.appDelegate.defaultBTServer.selectPeripheralInfo.doNotShowHint_Energization = yesNo;
    }
    else if([self.modeString isEqualToString:@"Soothing"]){
        self.appDelegate.defaultBTServer.selectPeripheralInfo.doNotShowHint_Soothing = yesNo;
    }
    else if([self.modeString isEqualToString:@"Concentration"]){
        self.appDelegate.defaultBTServer.selectPeripheralInfo.doNotShowHint_Concentration = yesNo;
    }
    else if([self.modeString isEqualToString:@"Sensuality"]){
        self.appDelegate.defaultBTServer.selectPeripheralInfo.doNotShowHint_Sensuality = yesNo;
    }
    else{
        self.appDelegate.defaultBTServer.selectPeripheralInfo.doNotShowHint_UserMode = yesNo;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self.appDelegate.defaultBTServer.selectPeripheralInfo];
    [defaults setObject:encodedObject forKey:self.appDelegate.defaultBTServer.selectPeripheralInfo.uuid];
    [defaults synchronize];

}

- (BOOL)getDoNotShowHint{
    BOOL yesNo = NO;
    if(!self.modeString){ //nil
        yesNo = NO;
    }
    else if([self.modeString isEqualToString:@"Relaxation"]){
        yesNo = self.appDelegate.defaultBTServer.selectPeripheralInfo.doNotShowHint_Relaxation;
        //yesNo = [[[NSUserDefaults standardUserDefaults] objectForKey:@"HintRelaxation"] boolValue];
    }
    else if([self.modeString isEqualToString:@"Sleep"]){
        yesNo = self.appDelegate.defaultBTServer.selectPeripheralInfo.doNotShowHint_Sleep;
        //yesNo = [[[NSUserDefaults standardUserDefaults] objectForKey:@"HintSleep"] boolValue];
    }
    else if([self.modeString isEqualToString:@"Energization"]){
        yesNo = self.appDelegate.defaultBTServer.selectPeripheralInfo.doNotShowHint_Energization;
        //yesNo = [[[NSUserDefaults standardUserDefaults] objectForKey:@"HintEnergization"] boolValue];
    }
    else if([self.modeString isEqualToString:@"Soothing"]){
        yesNo = self.appDelegate.defaultBTServer.selectPeripheralInfo.doNotShowHint_Soothing;
        //yesNo = [[[NSUserDefaults standardUserDefaults] objectForKey:@"HintSoothing"] boolValue];
    }
    else if([self.modeString isEqualToString:@"Concentration"]){
        yesNo = self.appDelegate.defaultBTServer.selectPeripheralInfo.doNotShowHint_Concentration;
        //yesNo = [[[NSUserDefaults standardUserDefaults] objectForKey:@"HintConcentration"] boolValue];
    }
    else if([self.modeString isEqualToString:@"Sensuality"]){
        yesNo = self.appDelegate.defaultBTServer.selectPeripheralInfo.doNotShowHint_Sensuality;
        //yesNo = [[[NSUserDefaults standardUserDefaults] objectForKey:@"HintSensuality"] boolValue];
    }
    else {
        yesNo = self.appDelegate.defaultBTServer.selectPeripheralInfo.doNotShowHint_UserMode;
        //yesNo = [[[NSUserDefaults standardUserDefaults] objectForKey:@"HintUserMode"] boolValue];
    }

    return yesNo;
}

-(void)waterStatusUpdated
{
    if(self.appDelegate.defaultBTServer.selectPeripheralInfo.water == [NSNumber numberWithInt:1])
    {
        if(self.appDelegate.defaultBTServer.selectPeripheralInfo.mode){
            self.modeString = self.appDelegate.defaultBTServer.selectPeripheralInfo.mode;
            if(self.appDelegate.defaultBTServer.selectPeripheralInfo.intentAction == SET_WORK_MODE ||
               self.appDelegate.defaultBTServer.selectPeripheralInfo.intentAction == INIT_SET_WORK_MODE){
                [self setMode:self.modeString waterStatus:HAS_WATER_AND_WORK];
            }
            else if(self.appDelegate.defaultBTServer.selectPeripheralInfo.intentAction == SHOW_HINT){
                [self showMode:self.modeString waterStatus:HAS_WATER_NOT_WORK];
                NSString * hintString = [self composeHint:[self.essenceName valueForKey:self.modeString]];
                if(hintString){
                    dispatch_async(dispatch_get_main_queue(), ^{
                    [self showHint:hintString];
                    });
                }
            }
            else if(self.appDelegate.defaultBTServer.selectPeripheralInfo.intentAction == SHOW_WORK_MODE)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showMode:self.modeString waterStatus:HAS_WATER_AND_WORK];
                });
            }
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showMode:self.modeString waterStatus:NO_MODE];
                self.modeString = nil;
            });
        }
    }
    else{
        if(self.appDelegate.defaultBTServer.selectPeripheralInfo.mode){
            self.modeString = self.appDelegate.defaultBTServer.selectPeripheralInfo.mode;
            /*if(self.appDelegate.defaultBTServer.selectPeripheralInfo.intentAction == SET_WORK_MODE){
                dispatch_async(dispatch_get_main_queue(), ^{
                [self showAddWaterAlert];
                });
            }
            else if(self.appDelegate.defaultBTServer.selectPeripheralInfo.intentAction == SHOW_HINT){
                dispatch_async(dispatch_get_main_queue(), ^{
                [self showMode:self.modeString waterStatus:NO_WATER];
                NSString * hintString = [self composeHint:[self.essenceName valueForKey:self.modeString]];
                if(hintString)
                    [self showHint:hintString];
                });
            }*/
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showMode:self.modeString waterStatus:NO_WATER];
                [self showAddWaterAlert];
            });
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
            [self showMode:self.modeString waterStatus:NO_MODE];
            self.modeString = nil;
            });
        }
    }
    self.appDelegate.defaultBTServer.selectPeripheralInfo.intentAction = IDLE;
}

- (void)showAddWaterAlert
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please add water into water" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    alertView.tag = 21;
    [alertView show];
}

@end
