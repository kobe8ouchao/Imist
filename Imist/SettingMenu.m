//
//  ViewController.m
//  ShareDemo
//
//  Created by Martin Bateson on 9/17/14.
//  Copyright (c) 2014 Pleiades Apps. All rights reserved.
//

#import "SettingMenu.h"
#import "MFSideMenu.h"

@interface SettingMenuVC ()<UIAlertViewDelegate>

@end

@implementation SettingMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Advanced Setting";

    UIButton *changeNameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [changeNameBtn setTitle:@"Rename IMIST" forState:UIControlStateNormal];
    [changeNameBtn setBackgroundColor:[UIColor clearColor]];
    [changeNameBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn_green.png"] forState:UIControlStateNormal];
    changeNameBtn.frame = CGRectMake((self.view.frame.size.width - 140)/2, 100, 140, 44);
    [changeNameBtn addTarget:self action:@selector(changeName:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeNameBtn];
    
    UIButton *factoryResetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [factoryResetBtn setTitle:@"Factory Reset" forState:UIControlStateNormal];
    [factoryResetBtn setBackgroundColor:[UIColor clearColor]];
    [factoryResetBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn_green.png"] forState:UIControlStateNormal];
    factoryResetBtn.frame = CGRectMake((self.view.frame.size.width - 140)/2, 200, 140, 44);
    [factoryResetBtn addTarget:self action:@selector(factoryReset:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:factoryResetBtn];


    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)changeName:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Rename machine" message:nil delegate:nil cancelButtonTitle:InterNation(@"cancel") otherButtonTitles:InterNation(@"confirm") ,nil];
    alert.tag = 222;
    alert.delegate = self;
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [[alert textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeDefault];
    [alert show];
}

-(void)factoryReset:(id)sender
{
    UIAlertView *factoryResetPop = [[UIAlertView alloc] initWithTitle:@"Reset" message:@"Do you really want to reset this diffuser's setting?" delegate:nil cancelButtonTitle:InterNation(@"cancel") otherButtonTitles:InterNation(@"confirm") ,nil];
    factoryResetPop.tag = 221;
    factoryResetPop.delegate = self;
    factoryResetPop.alertViewStyle = UIAlertViewStyleDefault;
    [factoryResetPop show];
    
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==222) {
        UITextField *tf=[alertView textFieldAtIndex:0];
        
        if (alertView.cancelButtonIndex != buttonIndex) {
            self.title = tf.text;
            AppDelegate *application = (AppDelegate*)[UIApplication sharedApplication].delegate;
            application.defaultBTServer.selectPeripheralInfo.name = tf.text;
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:application.defaultBTServer.selectPeripheralInfo];
            [defaults setObject:encodedObject forKey:application.defaultBTServer.selectPeripheralInfo.uuid];
            [defaults synchronize];
            
        }
    }
    if (alertView.tag==221) {
        
        if (alertView.cancelButtonIndex != buttonIndex) {
            AppDelegate *application = (AppDelegate*)[UIApplication sharedApplication].delegate;
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            //[defaults removeObjectForKey:application.defaultBTServer.selectPeripheralInfo.uuid];
            //[defaults synchronize];
            
            NSNumber *mist = [NSNumber numberWithInt:50];
            NSNumber *brightness = [NSNumber numberWithInt:46];
            NSNumber *color = [NSNumber numberWithInt:100];
            NSNumber *ledauto = [NSNumber numberWithInt:0];
      
            application.defaultBTServer.selectPeripheralInfo.userset2Hour = [NSMutableDictionary dictionaryWithObjectsAndKeys:mist,@"mist",brightness,@"brightness",color,@"color",ledauto,@"auto", nil];
            application.defaultBTServer.selectPeripheralInfo.userset4Hour = [NSMutableDictionary dictionaryWithObjectsAndKeys:mist,@"mist",brightness,@"brightness",color,@"color",ledauto,@"auto", nil];
            application.defaultBTServer.selectPeripheralInfo.userset8Hour = [NSMutableDictionary dictionaryWithObjectsAndKeys:mist,@"mist",brightness,@"brightness",color,@"color",ledauto,@"auto", nil];
            application.defaultBTServer.selectPeripheralInfo.userset16Hour = [NSMutableDictionary dictionaryWithObjectsAndKeys:mist,@"mist",brightness,@"brightness",color,@"color",ledauto,@"auto", nil];
            application.defaultBTServer.selectPeripheralInfo.doNotShowHint_UserMode = NO;
            application.defaultBTServer.selectPeripheralInfo.doNotShowHint_Relaxation = NO;
            application.defaultBTServer.selectPeripheralInfo.doNotShowHint_Sleep = NO;
            application.defaultBTServer.selectPeripheralInfo.doNotShowHint_Energization = NO;
            application.defaultBTServer.selectPeripheralInfo.doNotShowHint_Soothing = NO;
            application.defaultBTServer.selectPeripheralInfo.doNotShowHint_Concentration = NO;
            application.defaultBTServer.selectPeripheralInfo.doNotShowHint_Sensuality = NO;
            application.defaultBTServer.selectPeripheralInfo.name = @"IMIST";
            application.defaultBTServer.selectPeripheralInfo.mode = nil;
            application.defaultBTServer.selectPeripheralInfo.imist = mist;
            application.defaultBTServer.selectPeripheralInfo.ledlight = brightness;
            application.defaultBTServer.selectPeripheralInfo.ledcolor = color;
            application.defaultBTServer.selectPeripheralInfo.ledauto = ledauto;
            NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self.appDelegate.defaultBTServer.selectPeripheralInfo];
            [defaults setObject:encodedObject forKey:application.defaultBTServer.selectPeripheralInfo.uuid];
            [defaults synchronize];
            
            
        }
    }
}



#pragma mark - UIBarButtonItem Callbacks

- (void)leftSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
    }];
}


@end
