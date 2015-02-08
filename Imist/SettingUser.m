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
@property (nonatomic, assign) NSInteger color1Value;
@property (nonatomic, assign) NSInteger color2Value;
@property (nonatomic, assign) NSInteger color3Value;
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
    
    UIButton *modeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [modeBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn_green.png"] forState:UIControlStateNormal];
    [modeBtn setTitle:self.appDelegate.defaultBTServer.selectPeripheralInfo.mode forState:UIControlStateNormal];
    [modeBtn setBackgroundColor:[UIColor clearColor]];
    modeBtn.frame = CGRectMake((self.view.frame.size.width - 130)/2, 10, 130, 40);
    [self.view addSubview:modeBtn];
    
    NSInteger mistValue,brightnessValue,colorValue;
    
    if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"2 Hours"]){
        mistValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour valueForKey:@"mist"] integerValue];
        brightnessValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour valueForKey:@"brightness"] integerValue];
        colorValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset2Hour valueForKey:@"color"] integerValue];
        
    }
    else if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"4 Hours"]){
        mistValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour valueForKey:@"mist"] integerValue];
        brightnessValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour valueForKey:@"brightness"] integerValue];
        colorValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset4Hour valueForKey:@"color"] integerValue];
    }
    else if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"8 Hours"]){
        mistValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour valueForKey:@"mist"] integerValue];
        brightnessValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour valueForKey:@"brightness"] integerValue];
        colorValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset8Hour valueForKey:@"color"] integerValue];
    }
    else if([self.appDelegate.defaultBTServer.selectPeripheralInfo.mode isEqualToString:@"16 Hours"]){
        mistValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour valueForKey:@"mist"] integerValue];
        brightnessValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour valueForKey:@"brightness"] integerValue];
        colorValue = [[self.appDelegate.defaultBTServer.selectPeripheralInfo.userset16Hour valueForKey:@"color"] integerValue];
    }

    
    [self setUpBar:CGRectMake(20, 60, self.view.frame.size.width - 40 ,80) withTitle:@"mist" withMin:0 withMax:50 withTag:1 withValue:mistValue];
    [self setUpBar:CGRectMake(20, 130, self.view.frame.size.width - 40 ,80) withTitle:@"led brightness" withMin:0 withMax:100 withTag:2 withValue:brightnessValue];
    [self setUpBar:CGRectMake(20, 210, self.view.frame.size.width - 40 ,80) withTitle:@"led color" withMin:0 withMax:50 withTag:3 withValue:colorValue];
//    [self setUpBar:CGRectMake(20, 230, self.view.frame.size.width - 40 ,40) withTitle:@"led auto" withMin:0 withMax:50 withTag:4];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 280, self.view.frame.size.width ,18)];
    [lable setFont:[UIFont boldSystemFontOfSize:18]];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = @"led auto";
    lable.textColor = [UIColor colorWith256Red:129 green:189 blue:82];
    [self.view addSubview:lable];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(80, 310, 30, 30);
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
    noBtn.frame = CGRectMake(self.view.frame.size.width - 800, 310, 30, 30);
    [noBtn addTarget:self action:@selector(btnNo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noBtn];
    
    self.color1Value = 33;
    self.color2Value = 33;
    self.color3Value = 34;
    

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
    slider.value = value;
    //continuous属性，是指滑块值在拖地触发滑块值变动
    slider.continuous = YES;
    slider.tag = tag;
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventTouchUpInside];
    [bg addSubview:slider];
    
    UIImageView *plus = [[UIImageView alloc] initWithFrame:CGRectMake(bg.frame.size.width - 35, 24, 30 ,30)];
    plus.image = [UIImage imageNamed:@"ico_plus2.png"];
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
    NSLog(@"%f",value);
    if (control.tag == 1) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(200 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
            NSMutableData* data = [NSMutableData data];
            NSUInteger query = 0x09;
            NSNumber *imistObj = [NSNumber numberWithInteger:value];
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
            NSUInteger imist = value;
            self.imistValue = value;
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
        });
    }else if(control.tag == 2) {
        NSMutableData* data = [NSMutableData data];
        NSUInteger query = 0x09;
        NSNumber *brightnessObj = [NSNumber numberWithInteger:value];
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
        NSUInteger led = value;
        self.brightnessValue = value;
        [data appendBytes:&led length:1];
        NSUInteger color1 = self.color1Value;
        [data appendBytes:&color1 length:1];
        NSUInteger color2 = self.color1Value;
        [data appendBytes:&color2 length:1];
        NSUInteger color3 = self.color1Value;
        [data appendBytes:&color3 length:1];
        
        self.appDelegate.defaultBTServer.selectPeripheralInfo.curCmd = SET_WORK_MODE;
        [self.appDelegate.defaultBTServer writeValue:[self.appDelegate.defaultBTServer converCMD:data] withCharacter:[self.appDelegate.defaultBTServer findCharacteristicFromUUID:[CBUUID UUIDWithString:WRITE_CHARACTERISTIC]]];
    }else if(control.tag == 3) {
        NSMutableData* data = [NSMutableData data];
        NSUInteger query = 0x01;
        NSNumber *colorObj = [NSNumber numberWithInteger:value];
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
        NSUInteger color1 = self.color1Value;
        [data appendBytes:&color1 length:1];
        NSUInteger color2 = self.color2Value;
        [data appendBytes:&color2 length:1];
        NSUInteger color3 = self.color3Value;
        [data appendBytes:&color3 length:1];
        
        self.appDelegate.defaultBTServer.selectPeripheralInfo.curCmd = SET_WORK_MODE;
        [self.appDelegate.defaultBTServer writeValue:[self.appDelegate.defaultBTServer converCMD:data] withCharacter:[self.appDelegate.defaultBTServer findCharacteristicFromUUID:[CBUUID UUIDWithString:WRITE_CHARACTERISTIC]]];
    }

    
    
}

- (void) btnSure:(id)sender
{
    
}

- (void) btnNo:(id)sender
{
    
}

@end
