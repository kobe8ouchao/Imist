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
    sv.contentSize=CGSizeMake(sv.frame.size.width*5, sv.frame.size.height);
    UIImageView *help1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, sv.frame.size.width, sv.frame.size.height)];
    [help1 setBackgroundColor:[UIColor redColor]];
//    help1.image=[UIImage imageNamed:@"tutoral_1.jpg"];
    [sv addSubview:help1];
    
    UIImageView *help2=[[UIImageView alloc] initWithFrame:CGRectMake(sv.frame.size.width, 0, sv.frame.size.width, sv.frame.size.height)];
    [help2 setBackgroundColor:[UIColor greenColor]];
//    help2.image = [UIImage imageNamed:@"tutoral_2.jpg"];
    [sv addSubview:help2];
    
    UIImageView *help3=[[UIImageView alloc] initWithFrame:CGRectMake(sv.frame.size.width*2, 0, sv.frame.size.width, sv.frame.size.height)];
    [help3 setBackgroundColor:[UIColor blueColor]];
//    help3.image=[UIImage imageNamed:@"tutoral_3.jpg"];
    [sv addSubview:help3];
    
    UIImageView *help4=[[UIImageView alloc] initWithFrame:CGRectMake(sv.frame.size.width*3, 0, sv.frame.size.width, sv.frame.size.height)];
    [help4 setBackgroundColor:[UIColor yellowColor]];
//    help2.image = [UIImage imageNamed:@"tutoral_2.jpg"];
    [sv addSubview:help4];
    
    UIImageView *help5=[[UIImageView alloc] initWithFrame:CGRectMake(sv.frame.size.width*4, 0, sv.frame.size.width, sv.frame.size.height)];
    [help5 setBackgroundColor:[UIColor grayColor]];
//    help3.image=[UIImage imageNamed:@"tutoral_3.jpg"];
    [sv addSubview:help5];
    
    pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-40, self.view.frame.size.width, 20)];
    [self.view addSubview:pageControl];
    [pageControl addTarget:self action:@selector(goPage:) forControlEvents:UIControlEventValueChanged];
    pageControl.numberOfPages=5;
    pageControl.currentPage=0;
    

    UIButton *termbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    termbtn.backgroundColor = [UIColor orangeColor];
    [termbtn setFrame:CGRectMake(self.view.frame.size.width/2 - 110/2, self.view.frame.size.height-90, 110, 44)];
    NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleNone)};
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:@"Skip" attributes:underlineAttribute];
    termbtn.titleLabel.attributedText = attString;
    [termbtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [termbtn setTitleColor:[UIColor colorWith256Red:192 green:238 blue:32] forState:UIControlStateNormal];
    termbtn.titleLabel.textAlignment=NSTextAlignmentRight;
    [termbtn setTitle:termbtn.titleLabel.text forState:UIControlStateNormal];
    [termbtn addTarget:self action:@selector(Skip:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:termbtn];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    pageControl.currentPage=scrollView.contentOffset.x/sv.frame.size.width;
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
