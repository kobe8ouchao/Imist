//
//  AppDelegate.m
//  Imist
//
//  Created by chao.ou on 14/12/27.
//  Copyright (c) 2014年 oc. All rights reserved.
//

#import "AppDelegate.h"
#import "TutoralVC.h"
#import "SideMenuViewController.h"
#import "MFSideMenuContainerViewController.h"
#import "ScanDevicesVC.h"
#import <AVFoundation/AVFoundation.h>
#import "Manager.h"

@interface AppDelegate ()
@property(nonatomic, strong)NSTimer *playerTM;
@property (nonatomic,strong) AVAudioPlayer *player1;
@property (nonatomic,strong) AVAudioPlayer *player2;
@property (nonatomic,strong) AVAudioPlayer *player3;
@end

@implementation AppDelegate

@synthesize scanVC,playerTM,player1,player2,player3;

- (UIViewController *)scanDevicesController {
    self.scanVC = [[ScanDevicesVC alloc] init];
    return self.scanVC;
}

- (UINavigationController *)navi {
    return [[UINavigationController alloc]
            initWithRootViewController:[self scanDevicesController]];
}


- (NSInteger)currentWeekDay
{
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents * componentsToday = [calendar components:(NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:today];
    
    NSLog(@"componentsToday.weekday %i", componentsToday.weekday);
    return componentsToday.weekday;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.defaultBTServer = [BTServer defaultBTServer];
    
    [self currentWeekDay];

    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isFirst"] == NULL && ![[[NSUserDefaults standardUserDefaults] objectForKey:@"isFirst"] boolValue]) { // First
        TutoralVC *tutorvc=[[TutoralVC alloc] init];
        self.window.rootViewController = tutorvc;
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isFirst"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        self.scanVC = [self scanDevicesController];
        SideMenuViewController *leftMenuViewController = [[SideMenuViewController alloc] init];
        MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController
                                                        containerWithCenterViewController:[self navi]
                                                        leftMenuViewController:leftMenuViewController
                                                        rightMenuViewController:nil];
        self.window.rootViewController = container;
    }
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)])
    {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
//    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
//    [localNotif setFireDate:[[NSDate date] dateByAddingTimeInterval:5]];
//    localNotif.timeZone = [NSTimeZone defaultTimeZone];
//    NSLog(@"fireDate %@", localNotif.fireDate);
//    NSLog(@"datepicker %@", [[NSDate date] dateByAddingTimeInterval:5]);
//    
//    [localNotif setRepeatInterval:0];
//    localNotif.alertBody = @"some text";
//    localNotif.soundName = [[NSBundle mainBundle] pathForResource:@"Bicker.mp3" ofType:@"mp3"];
//    localNotif.alertAction = @"...";
//    
//    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    // Set AVAudioSession
    NSError *sessionError = nil;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    BOOL success = [audioSession setCategory:AVAudioSessionCategoryPlayback error:&sessionError];
    //NSLog(@"%@",success?@"YES":@"NO");
    
    NSError *activationError = nil;
    [audioSession setActive:YES error:&activationError];
    
    // Change the default output audio route
    UInt32 doChangeDefaultRoute = 1;
    AudioSessionSetProperty(kAudioSessionProperty_OverrideCategoryDefaultToSpeaker, sizeof(doChangeDefaultRoute), &doChangeDefaultRoute);
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];


    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
//    playerTM=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(playAlarm) userInfo:nil repeats:false];
//    [[NSRunLoop currentRunLoop] addTimer:playerTM forMode:NSDefaultRunLoopMode];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    if(self.defaultBTServer.selectPeripheralInfo && [self.defaultBTServer.selectPeripheralInfo.alert count] == 1) {
        NSDictionary *alertItem = [self.defaultBTServer.selectPeripheralInfo.alert objectAtIndex:0];
        if([[alertItem objectForKey:@"isOpen"] boolValue] == YES){
            [self configPlayer1:alertItem];
        }
    } else if(self.defaultBTServer.selectPeripheralInfo && [self.defaultBTServer.selectPeripheralInfo.alert count] == 2) {
        NSDictionary *alertItem = [self.defaultBTServer.selectPeripheralInfo.alert objectAtIndex:0];
        if([[alertItem objectForKey:@"isOpen"] boolValue] == YES){
            [self configPlayer1:alertItem];
        }
        alertItem = [self.defaultBTServer.selectPeripheralInfo.alert objectAtIndex:1];
        if([[alertItem objectForKey:@"isOpen"] boolValue] == YES){
            [self configPlayer2:alertItem];
        }

    }else if(self.defaultBTServer.selectPeripheralInfo && [self.defaultBTServer.selectPeripheralInfo.alert count] == 3) {
        NSDictionary *alertItem = [self.defaultBTServer.selectPeripheralInfo.alert objectAtIndex:0];
        if([[alertItem objectForKey:@"isOpen"] boolValue] == YES){
            [self configPlayer1:alertItem];
        }
        alertItem = [self.defaultBTServer.selectPeripheralInfo.alert objectAtIndex:0];
        if([[alertItem objectForKey:@"isOpen"] boolValue] == YES){
            [self configPlayer2:alertItem];
        }
        alertItem = [self.defaultBTServer.selectPeripheralInfo.alert objectAtIndex:0];
        if([[alertItem objectForKey:@"isOpen"] boolValue] == YES){
            [self configPlayer3:alertItem];
        }
    }

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    if (self.player1) {
        [self.player1 stop];
        self.player1 = nil;
    }
    if (self.player2) {
        [self.player2 stop];
        self.player2 = nil;
    }
    if (self.player3) {
        [self.player3 stop];
        self.player3 = nil;
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    NSLog(@"aaaaa");
}

-(UINavigationController*)Nav{
    UINavigationController *nav=(UINavigationController*)self.window.rootViewController;
    return nav.topViewController.navigationController;
}

-(void) playAlarm1
{
    static UIBackgroundTaskIdentifier bgTaskId;
    UIBackgroundTaskIdentifier newTaskId = UIBackgroundTaskInvalid;
    if (self.player1) {
        [self.player1 prepareToPlay];
        if([self.player1 play]){
            newTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:NULL];
        }
        if (newTaskId != UIBackgroundTaskInvalid && bgTaskId != UIBackgroundTaskInvalid)
            [[UIApplication sharedApplication] endBackgroundTask: bgTaskId];
        bgTaskId = newTaskId;
    }else {
        
    }
    
    Manager *sharedManager = [Manager sharedManager];
    NSMutableData* data = [NSMutableData data];
    NSUInteger query = [sharedManager getCurModeCmd:self.defaultBTServer.selectPeripheralInfo.mode];
    [data appendBytes:&query length:1];
    NSUInteger imist = [self.defaultBTServer.selectPeripheralInfo.imist integerValue];
    [data appendBytes:&imist length:1];
    NSUInteger led = [self.defaultBTServer.selectPeripheralInfo.ledlight integerValue];
    if(self.defaultBTServer.selectPeripheralInfo.ledauto)
        led = 0x65;
    [data appendBytes:&led length:1];
    
    NSUInteger color1 = [sharedManager getColorR:[self.defaultBTServer.selectPeripheralInfo.ledcolor integerValue]];
    [data appendBytes:&color1 length:1];
    NSUInteger color2 = [sharedManager getColorG:[self.defaultBTServer.selectPeripheralInfo.ledcolor integerValue]];
    [data appendBytes:&color2 length:1];
    NSUInteger color3 = [sharedManager getColorB:[self.defaultBTServer.selectPeripheralInfo.ledcolor integerValue]];
    [data appendBytes:&color3 length:1];
    
    self.defaultBTServer.selectPeripheralInfo.curCmd = SET_WORK_MODE;
    [self.defaultBTServer writeValue:[self.defaultBTServer converCMD:data] withCharacter:[self.defaultBTServer findCharacteristicFromUUID:[CBUUID UUIDWithString:WRITE_CHARACTERISTIC]]];
    
}

-(void) playAlarm2
{
    static UIBackgroundTaskIdentifier bgTaskId;
    UIBackgroundTaskIdentifier newTaskId = UIBackgroundTaskInvalid;
    if (self.player2) {
        [self.player2 prepareToPlay];
        if([self.player2 play]){
            newTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:NULL];
        }
        if (newTaskId != UIBackgroundTaskInvalid && bgTaskId != UIBackgroundTaskInvalid)
            [[UIApplication sharedApplication] endBackgroundTask: bgTaskId];
        bgTaskId = newTaskId;
    }else {
        
    }
    
    Manager *sharedManager = [Manager sharedManager];
    NSMutableData* data = [NSMutableData data];
    NSUInteger query = [sharedManager getCurModeCmd:self.defaultBTServer.selectPeripheralInfo.mode];
    [data appendBytes:&query length:1];
    NSUInteger imist = [self.defaultBTServer.selectPeripheralInfo.imist integerValue];
    [data appendBytes:&imist length:1];
    NSUInteger led = [self.defaultBTServer.selectPeripheralInfo.ledlight integerValue];
    if(self.defaultBTServer.selectPeripheralInfo.ledauto)
        led = 0x65;
    [data appendBytes:&led length:1];
    
    NSUInteger color1 = [sharedManager getColorR:[self.defaultBTServer.selectPeripheralInfo.ledcolor integerValue]];
    [data appendBytes:&color1 length:1];
    NSUInteger color2 = [sharedManager getColorG:[self.defaultBTServer.selectPeripheralInfo.ledcolor integerValue]];
    [data appendBytes:&color2 length:1];
    NSUInteger color3 = [sharedManager getColorB:[self.defaultBTServer.selectPeripheralInfo.ledcolor integerValue]];
    [data appendBytes:&color3 length:1];
    
    self.defaultBTServer.selectPeripheralInfo.curCmd = SET_WORK_MODE;
    [self.defaultBTServer writeValue:[self.defaultBTServer converCMD:data] withCharacter:[self.defaultBTServer findCharacteristicFromUUID:[CBUUID UUIDWithString:WRITE_CHARACTERISTIC]]];
    
}

-(void) playAlarm3
{
    static UIBackgroundTaskIdentifier bgTaskId;
    UIBackgroundTaskIdentifier newTaskId = UIBackgroundTaskInvalid;
    if (self.player3) {
        [self.player3 prepareToPlay];
        if([self.player3 play]){
            newTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:NULL];
        }
        if (newTaskId != UIBackgroundTaskInvalid && bgTaskId != UIBackgroundTaskInvalid)
            [[UIApplication sharedApplication] endBackgroundTask: bgTaskId];
        bgTaskId = newTaskId;
    }else {
        
    }
    
    Manager *sharedManager = [Manager sharedManager];
    NSMutableData* data = [NSMutableData data];
    NSUInteger query = [sharedManager getCurModeCmd:self.defaultBTServer.selectPeripheralInfo.mode];
    [data appendBytes:&query length:1];
    NSUInteger imist = [self.defaultBTServer.selectPeripheralInfo.imist integerValue];
    [data appendBytes:&imist length:1];
    NSUInteger led = [self.defaultBTServer.selectPeripheralInfo.ledlight integerValue];
    if(self.defaultBTServer.selectPeripheralInfo.ledauto)
        led = 0x65;
    [data appendBytes:&led length:1];
    
    NSUInteger color1 = [sharedManager getColorR:[self.defaultBTServer.selectPeripheralInfo.ledcolor integerValue]];
    [data appendBytes:&color1 length:1];
    NSUInteger color2 = [sharedManager getColorG:[self.defaultBTServer.selectPeripheralInfo.ledcolor integerValue]];
    [data appendBytes:&color2 length:1];
    NSUInteger color3 = [sharedManager getColorB:[self.defaultBTServer.selectPeripheralInfo.ledcolor integerValue]];
    [data appendBytes:&color3 length:1];
    
    self.defaultBTServer.selectPeripheralInfo.curCmd = SET_WORK_MODE;
    [self.defaultBTServer writeValue:[self.defaultBTServer converCMD:data] withCharacter:[self.defaultBTServer findCharacteristicFromUUID:[CBUUID UUIDWithString:WRITE_CHARACTERISTIC]]];
    
}

-(void) configPlayer1:(NSDictionary*)alertItem
{
    NSString *soundurl = [alertItem objectForKey:@"sound"];
    if([soundurl rangeOfString:@"ipod"].location != NSNotFound) {
        self.player1 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:[alertItem objectForKey:@"sound"]] error:nil];
    }else if([soundurl rangeOfString:@"Bicker"].location != NSNotFound || [soundurl rangeOfString:@"Chirp"].location != NSNotFound || [soundurl rangeOfString:@"Hill"].location != NSNotFound || [soundurl rangeOfString:@"Rain"].location != NSNotFound || [soundurl rangeOfString:@"Zen"].location != NSNotFound) {
        NSString *urlString = [[NSBundle mainBundle]pathForResource:
                               soundurl ofType:@"mp3"];
        NSURL *url = [NSURL fileURLWithPath:urlString];
        self.player1 = [[AVAudioPlayer alloc]
                        initWithContentsOfURL:url
                        error:nil];
    }
    
    //        self.player.delegate = self;
    NSString *time = [alertItem objectForKey:@"time"];
    NSString *repeat = [alertItem objectForKey:@"repeat"];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    NSDateFormatter *timeFormat2 = [[NSDateFormatter alloc] init];
    NSString *nowday = [[NSDate date] formattedDatePattern:@"yyyy-MM-dd"];
    [timeFormat2 setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [timeFormat2 dateFromString:[NSString stringWithFormat:@"%@ %@",nowday,time]];
    //
    
    NSInteger weekday = [comps weekday];
    NSArray *repeatdays = [repeat componentsSeparatedByString:@"|"];
    BOOL isAlert = NO;
    NSInteger fireDateApart = 0;
    NSDate *fireDate = [[NSDate alloc]init];
    if([repeatdays count]){
        for (NSString *d in repeatdays) {
            if ([d integerValue] < weekday) {
                fireDateApart = 7-weekday+[d integerValue];
                fireDate = [NSDate dateWithTimeInterval:fireDateApart*24*3600 sinceDate:date];
            }
            else if([d integerValue] > weekday){
                fireDateApart = [d integerValue] - weekday;
                fireDate = [NSDate dateWithTimeInterval:fireDateApart*24*3600 sinceDate:date];
            }
            else{
                NSDate *d = [[NSDate date] earlierDate: date];
                if([d isEqualToDate:date]){
                    fireDateApart = 7;
                    NSTimeInterval distanceBetweenDates = [[NSDate date] timeIntervalSinceDate:date];
                    fireDate = [NSDate dateWithTimeInterval:fireDateApart*24*3600+distanceBetweenDates sinceDate:date];
                }
                else{
                    fireDate = date;
                }
            }
            
            if (self.player1) {
                NSTimer *timer = [[NSTimer alloc] initWithFireDate:fireDate
                                                          interval:7*24*3600
                                                            target:self
                                                          selector:@selector(playAlarm1)
                                                          userInfo:nil
                                                           repeats:YES];
                
                NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
                [runLoop addTimer:timer forMode:NSDefaultRunLoopMode];
                [runLoop run];
            }
        }
    }
    else{
        //fix me
    }
}

-(void) configPlayer2:(NSDictionary*)alertItem
{
    NSString *soundurl = [alertItem objectForKey:@"sound"];
    if([soundurl rangeOfString:@"ipod"].location != NSNotFound) {
        self.player1 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:[alertItem objectForKey:@"sound"]] error:nil];
    }else if([soundurl rangeOfString:@"Bicker"].location != NSNotFound || [soundurl rangeOfString:@"Chirp"].location != NSNotFound || [soundurl rangeOfString:@"Hill"].location != NSNotFound || [soundurl rangeOfString:@"Rain"].location != NSNotFound || [soundurl rangeOfString:@"Zen"].location != NSNotFound) {
        NSString *urlString = [[NSBundle mainBundle]pathForResource:
                               soundurl ofType:@"mp3"];
        NSURL *url = [NSURL fileURLWithPath:urlString];
        self.player2 = [[AVAudioPlayer alloc]
                        initWithContentsOfURL:url
                        error:nil];
    }
    
    //        self.player.delegate = self;
    NSString *time = [alertItem objectForKey:@"time"];
    NSString *repeat = [alertItem objectForKey:@"repeat"];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    NSInteger weekday = [comps weekday];
    NSArray *repeatdays = [repeat componentsSeparatedByString:@"|"];
    BOOL isAlert = NO;
    for (NSString *d in repeatdays) {
        if ([d integerValue] == weekday) {
            isAlert = YES;
            break;
        }
    }
    if (isAlert) {
        NSDateFormatter *timeFormat2 = [[NSDateFormatter alloc] init];
        NSString *nowday = [[NSDate date] formattedDatePattern:@"yyyy-MM-dd"];
        [timeFormat2 setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSDate *date = [timeFormat2 dateFromString:[NSString stringWithFormat:@"%@ %@",nowday,time]];
        NSTimeInterval distanceBetweenDates = [date timeIntervalSinceDate:[NSDate date]];
        if (distanceBetweenDates >= 0) {
            NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:distanceBetweenDates];
            if (self.player2) {
                NSTimer *timer = [[NSTimer alloc] initWithFireDate:fireDate
                                                          interval:10
                                                            target:self
                                                          selector:@selector(playAlarm2)
                                                          userInfo:nil
                                                           repeats:NO];
                
                NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
                [runLoop addTimer:timer forMode:NSDefaultRunLoopMode];
                [runLoop run];
            }else {
                
                UILocalNotification *notification=[[UILocalNotification alloc] init];
                if (notification!=nil)
                {
                    notification.repeatInterval=0;
                    notification.fireDate=fireDate;//距现在多久后触发代理方法
                    notification.timeZone=[NSTimeZone defaultTimeZone];
                    notification.soundName = soundurl;
                    notification.alertBody = [NSString stringWithFormat:@"IMIST ALARM!"];
                    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
                }
            }
            
        }
        
    }
}

-(void) configPlayer3:(NSDictionary*)alertItem
{
    NSString *soundurl = [alertItem objectForKey:@"sound"];
    if([soundurl rangeOfString:@"ipod"].location != NSNotFound) {
        self.player1 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:[alertItem objectForKey:@"sound"]] error:nil];
    }else if([soundurl rangeOfString:@"Bicker"].location != NSNotFound || [soundurl rangeOfString:@"Chirp"].location != NSNotFound || [soundurl rangeOfString:@"Hill"].location != NSNotFound || [soundurl rangeOfString:@"Rain"].location != NSNotFound || [soundurl rangeOfString:@"Zen"].location != NSNotFound) {
        NSString *urlString = [[NSBundle mainBundle]pathForResource:
                               soundurl ofType:@"mp3"];
        NSURL *url = [NSURL fileURLWithPath:urlString];
        self.player3 = [[AVAudioPlayer alloc]
                        initWithContentsOfURL:url
                        error:nil];
    }
    
    //        self.player.delegate = self;
    NSString *time = [alertItem objectForKey:@"time"];
    NSString *repeat = [alertItem objectForKey:@"repeat"];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    NSInteger weekday = [comps weekday];
    NSArray *repeatdays = [repeat componentsSeparatedByString:@"|"];
    BOOL isAlert = NO;
    for (NSString *d in repeatdays) {
        if ([d integerValue] == weekday) {
            isAlert = YES;
            break;
        }
    }
    if (isAlert) {
        NSDateFormatter *timeFormat2 = [[NSDateFormatter alloc] init];
        NSString *nowday = [[NSDate date] formattedDatePattern:@"yyyy-MM-dd"];
        [timeFormat2 setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSDate *date = [timeFormat2 dateFromString:[NSString stringWithFormat:@"%@ %@",nowday,time]];
        NSTimeInterval distanceBetweenDates = [date timeIntervalSinceDate:[NSDate date]];
        if (distanceBetweenDates >= 0) {
            NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:distanceBetweenDates];
            if (self.player3) {
                NSTimer *timer = [[NSTimer alloc] initWithFireDate:fireDate
                                                          interval:10
                                                            target:self
                                                          selector:@selector(playAlarm3)
                                                          userInfo:nil
                                                           repeats:NO];
                
                NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
                [runLoop addTimer:timer forMode:NSDefaultRunLoopMode];
                [runLoop run];
            }else {
                
                UILocalNotification *notification=[[UILocalNotification alloc] init];
                if (notification!=nil)
                {
                    notification.repeatInterval=0;
                    notification.fireDate=fireDate;//距现在多久后触发代理方法
                    notification.timeZone=[NSTimeZone defaultTimeZone];
                    notification.soundName = soundurl;
                    notification.alertBody = [NSString stringWithFormat:@"IMIST ALARM!"];
                    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
                }
            }
            
        }
        
    }
}


@end
