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
@property (nonatomic, strong) NSMutableDictionary * essenceName;
@property (nonatomic, assign) BOOL doNotShowHint;

@end
typedef enum{
    HAS_WATER_AND_WORK,
    HAS_WATER_NOT_WORK,
    NO_WATER,
}waterStatus;
@implementation SettingModeVC
@synthesize title,essenceName,doNotShowHint;
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
    
    self.essenceName = [[NSMutableDictionary alloc] init];
    [self.essenceName setValue:@" Lemon " forKey:@"Relaxation"];
    [self.essenceName setValue:@" Lavender " forKey:@"Sleep"];
    [self.essenceName setValue:@" Rosemary " forKey:@"Energization"];
    [self.essenceName setValue:@" Orange " forKey:@"Soothing"];
    [self.essenceName setValue:@" Eucalytus " forKey:@"Concentration"];
    [self.essenceName setValue:@" Rose " forKey:@"Sensuality"];
    [self.essenceName setValue:@"Your likes oil" forKey:@"2 Hours"];
    [self.essenceName setValue:@" Your likes oil " forKey:@"4 Hours"];
    [self.essenceName setValue:@" Your likes oil " forKey:@"8 Hours"];
    [self.essenceName setValue:@" Your likes oil " forKey:@"16 Hours"];
    

}

- (NSString *) composeHint:(NSString*)essence
{
    NSMutableString * hint = [[NSMutableString alloc] init];
    [hint appendString:@"Please add clean, cold water & 5-10 drops of"];
    [hint appendString:essence];
    [hint appendString:@"essential oil into water tank of IMIST(make sure not over max level), then replace the cover."];
    return hint;
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

- (void)showHint:(NSString*)hintString{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hint" message:hintString delegate:self cancelButtonTitle:@"Don't show again" otherButtonTitles:@"OK", nil];
    alertView.tag = 20;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 20 && buttonIndex == 0){ //"don't show this again" touched
        [self getWaterStatus];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(200 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
            if(self.appDelegate.defaultBTServer.selectPeripheralInfo.water){
                self.doNotShowHint = YES;
                [self setMode:self.appDelegate.defaultBTServer.selectPeripheralInfo.mode waterStatus:HAS_WATER_AND_WORK];
            }
            else{
                NSString * hintString = [[NSString alloc]init];
                hintString = [self composeHint:[self.essenceName valueForKey:self.appDelegate.defaultBTServer.selectPeripheralInfo.mode]];
                [self showHint:hintString];
            }
        });
    }
    else{ //"done" touched
        [self getWaterStatus];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(200 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
            if(self.appDelegate.defaultBTServer.selectPeripheralInfo.water){
                [self setMode:self.appDelegate.defaultBTServer.selectPeripheralInfo.mode waterStatus:HAS_WATER_AND_WORK];
            }
            else{
                NSString * hintString = [[NSString alloc]init];
                hintString = [self composeHint:[self.essenceName valueForKey:self.appDelegate.defaultBTServer.selectPeripheralInfo.mode]];
                [self showHint:hintString];
            }
        });
    }
}

-(void)btnClick:(UIButton*)sender{
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
    
    [self getWaterStatus];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(200 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
        if(self.appDelegate.defaultBTServer.selectPeripheralInfo.water){//has water
            if(NO == self.doNotShowHint){
                [self setMode:self.appDelegate.defaultBTServer.selectPeripheralInfo.mode waterStatus:HAS_WATER_NOT_WORK];
                
                NSString * hintString = [self composeHint:[self.essenceName valueForKey:self.appDelegate.defaultBTServer.selectPeripheralInfo.mode]];
                [self showHint:hintString];
            }
            else{
                [self setMode:self.appDelegate.defaultBTServer.selectPeripheralInfo.mode waterStatus:HAS_WATER_AND_WORK];
            }
        }
        else{
            NSString * hintString = [self composeHint:[self.essenceName valueForKey:self.appDelegate.defaultBTServer.selectPeripheralInfo.mode]];
            [self showHint:hintString];
        }
    });
}


-(void)hoursClick:(UIButton*)btn{
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
    
    [self getWaterStatus];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(200 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
        if(self.appDelegate.defaultBTServer.selectPeripheralInfo.water){//has water
            if(NO == self.doNotShowHint){
                [self setMode:self.appDelegate.defaultBTServer.selectPeripheralInfo.mode waterStatus:HAS_WATER_NOT_WORK];
                
                NSString * hintString = [self composeHint:[self.essenceName valueForKey:self.appDelegate.defaultBTServer.selectPeripheralInfo.mode]];
                [self showHint:hintString];
            }
            else{
                [self setMode:self.appDelegate.defaultBTServer.selectPeripheralInfo.mode waterStatus:HAS_WATER_AND_WORK];
            }
        }
        else{
            NSString * hintString = [self composeHint:[self.essenceName valueForKey:self.appDelegate.defaultBTServer.selectPeripheralInfo.mode]];
            [self showHint:hintString];
        }
    });


}

- (void)setMode:(NSString*)modeString waterStatus:(NSInteger)status{
    NSInteger btnTag;
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
    
    if(status == HAS_WATER_AND_WORK)
        [self sendAutoModeCmd:self.appDelegate.defaultBTServer.selectPeripheralInfo.mode];
    
    
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
    }else if([modeString isEqualToString:@"2 Hours"]){
        cmd = 1;
    }
    else if([modeString isEqualToString:@"4 Hours"]){
        cmd = 2;
    }
    else if([modeString isEqualToString:@"8 Hours"]){
        cmd = 3;
    }
    else if([modeString isEqualToString:@"16 Hours"]){
        cmd = 4;
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
    
    self.appDelegate.defaultBTServer.selectPeripheralInfo.curCmd = SET_WORK_MODE;
    [self.appDelegate.defaultBTServer writeValue:[self.appDelegate.defaultBTServer converCMD:data] withCharacter:[self.appDelegate.defaultBTServer findCharacteristicFromUUID:[CBUUID UUIDWithString:WRITE_CHARACTERISTIC]]];
    
}

- (void)getWaterStatus{
    
    NSMutableData* data = [NSMutableData data];
    
    NSUInteger query = 0xa1;
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
    
    self.appDelegate.defaultBTServer.selectPeripheralInfo.curCmd = GET_WATER_STATUS;
    
    [self.appDelegate.defaultBTServer writeValue:[self.appDelegate.defaultBTServer converCMD:data] withCharacter:[self.appDelegate.defaultBTServer findCharacteristicFromUUID:[CBUUID UUIDWithString:WRITE_CHARACTERISTIC]]];
}

@end
