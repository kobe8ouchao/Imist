//
//  BaseViewController.m
//  TinyRunner
//
//  Created by jason on 8/9/12.
//  Copyright (c) 2012 jason. All rights reserved.
//

#import "BaseViewController.h"
#import "MFSideMenu.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

@synthesize appDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView{
    [super loadView];
    self.appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.TintColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.barTintColor=[UIColor colorWith256Red:129 green:189 blue:82];
    self.navigationController.navigationBar.translucent=NO;
    self.view.backgroundColor=[UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWith256Red:222 green:222 blue:221];
}

- (void)viewDidUnload
{
    self.appDelegate = nil;
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
