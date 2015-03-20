//
//  AppDelegate.h
//  Imist
//
//  Created by chao.ou on 14/12/27.
//  Copyright (c) 2014年 oc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTServer.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *scanVC;
@property (strong, nonatomic) BTServer *defaultBTServer;

- (UIViewController *)scanDevicesController;
- (UINavigationController *)navi;
- (UINavigationController*) Nav;

-(void) scheduleNotification:(NSDictionary*)alertItem;

@end

