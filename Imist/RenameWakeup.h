//
//  AboutVC.h
//  Imist
//
//  Created by chao.ou on 14/12/30.
//  Copyright (c) 2014年 oc. All rights reserved.
//

#import "BaseViewController.h"
#import <UIKit/UIKit.h>
@protocol pickWakeNameDelegate;

@interface renameWakeupVC : BaseViewController
@property NSString * editName;
@property (nonatomic, assign) id<pickWakeNameDelegate> delegate;
@end

@protocol pickWakeNameDelegate <NSObject>
-(void)saveWakeName:(NSString*)wakeName;
@end
