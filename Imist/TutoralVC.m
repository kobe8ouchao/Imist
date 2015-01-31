//
//  TutoralVC.m
//  Imist
//
//  Created by chao.ou on 14/12/28.
//  Copyright (c) 2014年 oc. All rights reserved.
//

#import "TutoralVC.h"
#import "SideMenuViewController.h"
#import "MFSideMenuContainerViewController.h"
#import "ScanDevicesVC.h"
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
@interface TutoralVC ()

@end

@implementation TutoralVC

- (void)loadView {
    [super loadView];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    sv=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    sv.pagingEnabled=YES;
    sv.scrollsToTop=NO;
    sv.delegate=self;
    sv.showsHorizontalScrollIndicator=NO;
    sv.showsVerticalScrollIndicator=NO;
    sv.bounces = NO;
    [self.view addSubview:sv];
    sv.contentSize=CGSizeMake(sv.frame.size.width*7, sv.frame.size.height);
    UIImageView *help1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, sv.frame.size.width, sv.frame.size.height)];
    [help1 setBackgroundColor:[UIColor clearColor]];
    help1.image=[UIImage imageNamed:@"tutorial_eng.png"];
    [sv addSubview:help1];
    UIButton *skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (iPhone5)
    {
        skipBtn.frame = CGRectMake((self.view.frame.size.width - 110)/2, self.view.frame.size.height-60, 110, 44 );
    }
    else
    {
        skipBtn.frame = CGRectMake((self.view.frame.size.width - 110)/2, self.view.frame.size.height-60, 110, 44 );
    }
    [skipBtn setBackgroundColor:[UIColor clearColor]];
    [skipBtn addTarget:self action:@selector(Skip:) forControlEvents:UIControlEventTouchUpInside];
    [sv addSubview:skipBtn];

    
    
    
    UIImageView *help2=[[UIImageView alloc] initWithFrame:CGRectMake(sv.frame.size.width, 0, sv.frame.size.width, sv.frame.size.height)];
    [help2 setBackgroundColor:[UIColor clearColor]];
    help2.image = [UIImage imageNamed:@"tutorial_eng_0.png"];
    [sv addSubview:help2];
    
    UIImageView *help3=[[UIImageView alloc] initWithFrame:CGRectMake(sv.frame.size.width*2, 0, sv.frame.size.width, sv.frame.size.height)];
    [help3 setBackgroundColor:[UIColor clearColor]];
    help3.image=[UIImage imageNamed:@"tutorial_eng_1.png"];
    [sv addSubview:help3];
    
    UIImageView *help4=[[UIImageView alloc] initWithFrame:CGRectMake(sv.frame.size.width*3, 0, sv.frame.size.width, sv.frame.size.height)];
    [help4 setBackgroundColor:[UIColor clearColor]];
    help4.image = [UIImage imageNamed:@"tutorial_eng_2.png"];
    [sv addSubview:help4];
    
    UIImageView *help5=[[UIImageView alloc] initWithFrame:CGRectMake(sv.frame.size.width*4, 0, sv.frame.size.width, sv.frame.size.height)];
    [help5 setBackgroundColor:[UIColor clearColor]];
    help5.image=[UIImage imageNamed:@"tutorial_eng_3.png"];
    [sv addSubview:help5];
    
    UIImageView *help6=[[UIImageView alloc] initWithFrame:CGRectMake(sv.frame.size.width*5, 0, sv.frame.size.width, sv.frame.size.height)];
    [help6 setBackgroundColor:[UIColor clearColor]];
    help6.image=[UIImage imageNamed:@"tutorial_eng_4.png"];
    [sv addSubview:help6];
    
    UIImageView *help7=[[UIImageView alloc] initWithFrame:CGRectMake(sv.frame.size.width*6, 0, sv.frame.size.width, sv.frame.size.height)];
    [help7 setBackgroundColor:[UIColor clearColor]];
    help7.image=[UIImage imageNamed:@"tutorial_eng_5.png"];
    [sv addSubview:help7];
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (iPhone5)
    {
        doneBtn.frame = CGRectMake((self.view.frame.size.width - 110)/2, self.view.frame.size.height-60, 110, 44 );
    }
    else
    {
        doneBtn.frame = CGRectMake(sv.frame.size.width*6 + (self.view.frame.size.width - 110)/2, self.view.frame.size.height-60, 110, 44 );
    }
    [doneBtn setBackgroundColor:[UIColor clearColor]];
    [doneBtn addTarget:self action:@selector(Skip:) forControlEvents:UIControlEventTouchUpInside];
    [sv addSubview:doneBtn];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    pageControl.currentPage=scrollView.contentOffset.x/sv.frame.size.width;
}

-(void)goPage:(UIPageControl*)pg{
//    [sv setContentOffset:CGPointMake(pageControl.currentPage*sv.frame.size.width, 0) animated:YES];
}

-(void)Skip:(id) sender
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    app.scanVC = [app scanDevicesController];
    SideMenuViewController *leftMenuViewController = [[SideMenuViewController alloc] init];
    MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController
                                                    containerWithCenterViewController:[app navi]
                                                    leftMenuViewController:leftMenuViewController
                                                    rightMenuViewController:nil];
    app.window.rootViewController = container;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
