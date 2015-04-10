//
//  ViewController.m
//  ShareDemo
//
//  Created by Martin Bateson on 9/17/14.
//  Copyright (c) 2014 Pleiades Apps. All rights reserved.
//

#import "ShareVC.h"
#import "MFSideMenu.h"

@interface ShareVC ()<UIAlertViewDelegate>

@end

@implementation ShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if(!self.title) self.title = @"Share";
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake( 0, 0, 44, 44)];
    [leftBtn setImage:[UIImage imageNamed:@"menu-icon.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftSideMenuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationController.navigationBar.translucent=NO;
    [self.view setBackgroundColor:[UIColor whiteColor]];

    /*UIButton *facebookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [facebookBtn setTitle:@"Facebook" forState:UIControlStateNormal];
    [facebookBtn setBackgroundColor:[UIColor clearColor]];
    [facebookBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn_green.png"] forState:UIControlStateNormal];
    facebookBtn.frame = CGRectMake((self.view.frame.size.width - 140)/2, 100, 140, 44);
    [facebookBtn addTarget:self action:@selector(FacebookShare:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:facebookBtn];
    
    UIButton *twitterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [twitterBtn setTitle:@"Twitter" forState:UIControlStateNormal];
    [twitterBtn setBackgroundColor:[UIColor clearColor]];
    [twitterBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn_green.png"] forState:UIControlStateNormal];
    twitterBtn.frame = CGRectMake((self.view.frame.size.width - 140)/2, 180, 140, 44);
    [twitterBtn addTarget:self action:@selector(TwitterShare:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:twitterBtn];

    UIButton *sinaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sinaBtn setTitle:@"Sina Weibo" forState:UIControlStateNormal];
    [sinaBtn setBackgroundColor:[UIColor clearColor]];
    [sinaBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn_green.png"] forState:UIControlStateNormal];
    sinaBtn.frame = CGRectMake((self.view.frame.size.width - 140)/2, 260, 140, 44);
    [sinaBtn addTarget:self action:@selector(SinaShare:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sinaBtn];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setTitle:@"Share to ..." forState:UIControlStateNormal];
    [shareBtn setBackgroundColor:[UIColor clearColor]];
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn_green.png"] forState:UIControlStateNormal];
    shareBtn.frame = CGRectMake((self.view.frame.size.width - 140)/2, 340, 140, 44);
    [shareBtn addTarget:self action:@selector(ShareButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];*/
    [self shareContent];


    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ShareButton:(id)sender {
    [self shareContent];
}

- (void)FacebookShare:(id)sender {
    [self targetedShare:SLServiceTypeFacebook];
}

- (void)TwitterShare:(id)sender {
    [self targetedShare:SLServiceTypeTwitter];
}


- (void)SinaShare:(id)sender {
    [self targetedShare:SLServiceTypeSinaWeibo];
}

-(void)shareContent{
    NSString * message = @"IMSIT is cool! Come to explore this Smart Aroma diffuser by downloading IMIST APP on the APP Store or getting in on Google Play.\nThanks!\nParlex Household Industrial Company Limited\n";
    NSURL *url = [NSURL URLWithString:@"http://www.ghcn.com/"];
    UIImage * image = [UIImage imageNamed:@"aboutScreen"];
    NSArray * shareItems = @[message, url, image];
    
    UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    [avc setCompletionHandler:^(NSString *activityType, BOOL completed) {
        NSLog(@"start completion block");
        NSString *output;
        if(completed == NO)
            output = @"Post Fail";
        else
            output = @"Post Successfull";

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Share to social" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        alert.tag = 222;
        alert.delegate = self;
        [alert show];

    }];
    [self presentViewController:avc animated:YES completion:nil];
}

-(void)targetedShare:(NSString *)serviceType {
    if([SLComposeViewController isAvailableForServiceType:serviceType]){
        SLComposeViewController *shareView = [SLComposeViewController composeViewControllerForServiceType:serviceType];
        
        [shareView setInitialText:@"IMSIT is cool! Come to explore this Smart Aroma diffuser by downloading IMIST APP on the APP Store or getting in on Google Play."];
        [shareView addURL:[NSURL URLWithString:@"http://www.ghcn.com/"]];
        [shareView addImage:[UIImage imageNamed:@"aboutScreen"]];
        [shareView setCompletionHandler:^(SLComposeViewControllerResult result) {
            NSLog(@"start completion block");
            NSString *output;
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    output = @"Post Cancelled";
                    break;
                case SLComposeViewControllerResultDone:
                    output = @"Post Successfull";
                    break;
                default:
                    output = @"Post Fail";
                    break;
            }
            if (result != SLComposeViewControllerResultCancelled)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Share to social" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                alert.tag = 222;
                alert.delegate = self;
                [alert show];
            }
            else{
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];

        [self presentViewController:shareView animated:YES completion:nil];
        
    } else {
        
        UIAlertView *alert;
        alert = [[UIAlertView alloc]
                 initWithTitle:@"Fail"
                 message:@"Have you installed the according social app and correctly set your account?"
                 delegate:self
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil];
        alert.tag = 222;
        alert.delegate = self;
        [alert show];
    }
    
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==222) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UIBarButtonItem Callbacks

- (void)leftSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
    }];
}


@end
