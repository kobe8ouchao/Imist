//
//  ViewController.h
//  ShareDemo
//
//  Created by Martin Bateson on 9/17/14.
//  Copyright (c) 2014 Pleiades Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import "BaseViewController.h"

@interface ShareVC : BaseViewController
- (void)ShareButton:(id)sender;
- (void)FacebookShare:(id)sender;
- (void)TwitterShare:(id)sender;
- (void)SinaShare:(id)sender;

@end
