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
    self.navigationController.navigationBar.barTintColor=[UIColor colorWith256Red:8 green:173 blue:203];
    self.view.backgroundColor=[UIColor clearColor];
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

#pragma mark -
#pragma mark - UIBarButtonItem Callbacks

- (void)leftSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
        //        [self setupMenuBarButtonItems];
    }];
}

@end
