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
    if(!self.title) self.title = @"Advanced Setting";

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
    UIAlertView *factoryResetPop = [[UIAlertView alloc] initWithTitle:@"Reset" message:@"Do you want to reset the diffuser setting?" delegate:nil cancelButtonTitle:InterNation(@"cancel") otherButtonTitles:InterNation(@"confirm") ,nil];
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
            [defaults synchronize];
            [defaults removeObjectForKey:@"nameKey"];
            [defaults removeObjectForKey:@"waterKey"];
            [defaults removeObjectForKey:@"modeKey"];
            [defaults removeObjectForKey:@"alertKey"];
            [defaults removeObjectForKey:@"2Hour"];
            [defaults removeObjectForKey:@"4Hour"];
            [defaults removeObjectForKey:@"8Hour"];
            [defaults removeObjectForKey:@"16Hour"];
            [defaults removeObjectForKey:@"UserMode"];
            [defaults removeObjectForKey:@"Relaxation"];
            [defaults removeObjectForKey:@"Sleep"];
            [defaults removeObjectForKey:@"Energization"];
            [defaults removeObjectForKey:@"Soothing"];
            [defaults removeObjectForKey:@"Concentration"];
            [defaults removeObjectForKey:@"Sensuality"];
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
