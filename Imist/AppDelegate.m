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

@interface AppDelegate ()
@property(nonatomic, strong)NSTimer *playerTM;
@property (nonatomic,strong) AVAudioPlayer *player;
@end

@implementation AppDelegate

@synthesize scanVC,playerTM,player;

- (UIViewController *)scanDevicesController {
    self.scanVC = [[ScanDevicesVC alloc] init];
    return self.scanVC;
}

- (UINavigationController *)navi {
    return [[UINavigationController alloc]
            initWithRootViewController:[self scanDevicesController]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.defaultBTServer = [BTServer defaultBTServer];

    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isFirst"] == NULL && ![[[NSUserDefaults standardUserDefaults] objectForKey:@"isFirst"] boolValue]) { // First
        TutoralVC *tutorvc=[[TutoralVC alloc] init];
        self.window.rootViewController = tutorvc;
    } else {
        self.scanVC = [self scanDevicesController];
        SideMenuViewController *leftMenuViewController = [[SideMenuViewController alloc] init];
        MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController
                                                        containerWithCenterViewController:[self navi]
                                                        leftMenuViewController:leftMenuViewController
                                                        rightMenuViewController:nil];
        self.window.rootViewController = container;
    }
//    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)])
//    {
//        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
//    }
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
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    if(self.defaultBTServer.selectPeripheralInfo && [self.defaultBTServer.selectPeripheralInfo.alert count] > 0) {
        NSDictionary *alertItem = [self.defaultBTServer.selectPeripheralInfo.alert objectAtIndex:0];
        NSString *soundurl = [alertItem objectForKey:@"sound"];
        if([soundurl rangeOfString:@"ipod"].location != NSNotFound) {
            self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:[alertItem objectForKey:@"sound"]] error:nil];
        }else if([soundurl rangeOfString:@"Bicker"].location != NSNotFound || [soundurl rangeOfString:@"Chirp"].location != NSNotFound || [soundurl rangeOfString:@"Hill"].location != NSNotFound || [soundurl rangeOfString:@"Rain"].location != NSNotFound || [soundurl rangeOfString:@"Zen"].location != NSNotFound) {
            NSString *urlString = [[NSBundle mainBundle]pathForResource:
                                   soundurl ofType:@"mp3"];
            NSURL *url = [NSURL fileURLWithPath:urlString];
            self.player = [[AVAudioPlayer alloc]
                            initWithContentsOfURL:url
                            error:nil];
        }else {
            NSURL *url = [NSURL fileURLWithPath:soundurl];
            self.player = [[AVAudioPlayer alloc]
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
                NSTimer *timer = [[NSTimer alloc] initWithFireDate:fireDate
                                                          interval:10
                                                            target:self
                                                          selector:@selector(playAlarm)
                                                          userInfo:nil
                                                           repeats:NO];
                
                NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
                [runLoop addTimer:timer forMode:NSDefaultRunLoopMode];
                [runLoop run];
            }

        }
    }    

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    if (self.player) {
        [self.player stop];
        self.player = nil;
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

-(void) playAlarm
{
    static UIBackgroundTaskIdentifier bgTaskId;
    UIBackgroundTaskIdentifier newTaskId = UIBackgroundTaskInvalid;
    if (self.player) {
        [self.player prepareToPlay];
        if([self.player play]){
            newTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:NULL];
        }
        if (newTaskId != UIBackgroundTaskInvalid && bgTaskId != UIBackgroundTaskInvalid)
            [[UIApplication sharedApplication] endBackgroundTask: bgTaskId];
        bgTaskId = newTaskId;
    }else {
        newTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:NULL];
        NSDictionary *alertItem = [self.defaultBTServer.selectPeripheralInfo.alert objectAtIndex:0];
        NSString *soundurl = [alertItem objectForKey:@"sound"];
        NSURL *url = [NSURL fileURLWithPath:soundurl];
        SystemSoundID soundID;
        AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)url,&soundID);
        AudioServicesPlaySystemSound(soundID);
        if (newTaskId != UIBackgroundTaskInvalid && bgTaskId != UIBackgroundTaskInvalid)
            [[UIApplication sharedApplication] endBackgroundTask: bgTaskId];
        bgTaskId = newTaskId;
    }
    

    
}

@end
