//
//  AboutVC.m
//  Imist
//
//  Created by chao.ou on 14/12/30.
//  Copyright (c) 2014年 oc. All rights reserved.
//

#import "AboutVC.h"
#import "MFSideMenu.h"

@interface AboutVC ()

@end

@implementation AboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // setup navigationBar
    if(!self.title) self.title = @"About Imist";
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake( 0, 0, 44, 44)];
    [leftBtn setImage:[UIImage imageNamed:@"menu-icon.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftSideMenuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *namelab=[[UILabel alloc] initWithFrame:CGRectMake(10, 30, self.view.frame.size.width - 20, 500)];
    [namelab setFont:[UIFont fontWithName:@"BTGotham-Book" size:15]];
    [namelab setTextColor:[UIColor colorWith256Red:72 green:96 blue:109]];
    [namelab setBackgroundColor:[UIColor clearColor]];
    namelab.numberOfLines = 0;
    namelab.text = @"IMIST is a joint name for a group of “ellestfun” App-enabled Bluetooth 4.0 Connected Smart Aroma Diffusers. Users can download IMIST App from Apple Store or Google Play Store and install it on their iOS devices (iPhone, iPad) or Android Smartphones & Tablets, use it to control the operation of IMIST. These elegant-designed aroma diffusers release fragrant mist generated by ultrasonic wave, with gentle LED lighting, delivering the aromatic luxury feels to your home, adding peaceful tranquility to your life.";
    namelab.textAlignment = NSTextAlignmentCenter;
    namelab.tag=222;
    [self.view addSubview:namelab];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - UIBarButtonItem Callbacks

- (void)leftSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
    }];
}

@end
