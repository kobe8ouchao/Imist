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
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
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
    self.navigationController.navigationBar.translucent = NO;
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
    if (iPhone4) {
        help1.image=[UIImage imageNamed:@"tutorial_eng1_4.png"];
    }else {
        help1.image=[UIImage imageNamed:@"tutorial_eng.png"];
    }
    
    [sv addSubview:help1];
    
    UIImageView *help2=[[UIImageView alloc] initWithFrame:CGRectMake(sv.frame.size.width, 0, sv.frame.size.width, sv.frame.size.height)];
    [help2 setBackgroundColor:[UIColor clearColor]];
    if (iPhone4) {
       help2.image = [UIImage imageNamed:@"tutorial_eng2_4.png"];
    }else {
       help2.image = [UIImage imageNamed:@"tutorial_eng_0.png"];
    }
    
    [sv addSubview:help2];
    
    UIImageView *help3=[[UIImageView alloc] initWithFrame:CGRectMake(sv.frame.size.width*2, 0, sv.frame.size.width, sv.frame.size.height )];
    [help3 setBackgroundColor:[UIColor clearColor]];
    if (iPhone4) {
        help3.image = [UIImage imageNamed:@"tutorial_eng3_4.png"];
    }else {
        help3.image = [UIImage imageNamed:@"tutorial_eng_1.png"];
    }
    [sv addSubview:help3];
    
    UIImageView *help4=[[UIImageView alloc] initWithFrame:CGRectMake(sv.frame.size.width*3, 0, sv.frame.size.width, sv.frame.size.height)];
    [help4 setBackgroundColor:[UIColor clearColor]];
    if (iPhone4) {
        help4.image = [UIImage imageNamed:@"tutorial_eng4_4.png"];
    }else {
        help4.image = [UIImage imageNamed:@"tutorial_eng_2.png"];
    }
    [sv addSubview:help4];
    
    UIImageView *help5=[[UIImageView alloc] initWithFrame:CGRectMake(sv.frame.size.width*4, 0, sv.frame.size.width, sv.frame.size.height)];
    [help5 setBackgroundColor:[UIColor clearColor]];
    if (iPhone4) {
        help5.image = [UIImage imageNamed:@"tutorial_eng5_4.png"];
    }else {
        help5.image = [UIImage imageNamed:@"tutorial_eng_3.png"];
    }
    [sv addSubview:help5];
    
    UIImageView *help6=[[UIImageView alloc] initWithFrame:CGRectMake(sv.frame.size.width*5, 0, sv.frame.size.width, sv.frame.size.height)];
    [help6 setBackgroundColor:[UIColor clearColor]];
    if (iPhone4) {
        help6.image = [UIImage imageNamed:@"tutorial_eng6_4.png"];
    }else {
        help6.image = [UIImage imageNamed:@"tutorial_eng_4.png"];
    }
    [sv addSubview:help6];
    
    UIImageView *help7=[[UIImageView alloc] initWithFrame:CGRectMake(sv.frame.size.width*6, 0, sv.frame.size.width, sv.frame.size.height)];
    [help7 setBackgroundColor:[UIColor clearColor]];
    if (iPhone4) {
        help7.image = [UIImage imageNamed:@"tutorial_eng7_4.png"];
    }else {
        help7.image = [UIImage imageNamed:@"tutorial_eng_5.png"];
    }
    
    [sv addSubview:help7];
    
    pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 50)];
    pageControl.numberOfPages=7;
    pageControl.currentPage=0;
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWith256Red:129 green:189 blue:82];
    [self.view addSubview:pageControl];
    [pageControl addTarget:self action:@selector(goPage:) forControlEvents:UIControlEventValueChanged];
    
    UIButton *skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [skipBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn_green.png"] forState:UIControlStateNormal];
    skipBtn.tag = 200;
    [skipBtn setTitle:@"Skip" forState:UIControlStateNormal];
    [skipBtn setBackgroundColor:[UIColor clearColor]];
    skipBtn.frame = CGRectMake((self.view.frame.size.width - 140)/2, self.view.frame.size.height - 80, 140, 44);
    [skipBtn addTarget:self action:@selector(Skip:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:skipBtn];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    pageControl.currentPage=scrollView.contentOffset.x/sv.frame.size.width;
    UIButton *skipBtn = (UIButton*)[self.view viewWithTag:200];
    if (6 == scrollView.contentOffset.x/sv.frame.size.width) {
        [skipBtn setTitle:@"Done" forState:UIControlStateNormal];
    }else {
        [skipBtn setTitle:@"Skip" forState:UIControlStateNormal];
    }
}

-(void)goPage:(UIPageControl*)pg{
    [sv setContentOffset:CGPointMake(pageControl.currentPage*sv.frame.size.width, 0) animated:YES];
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
