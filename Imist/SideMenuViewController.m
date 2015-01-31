//
//  SideMenuViewController.m
//  MFSideMenuDemo
//
//  Created by Michael Frederick on 3/19/12.

#import "SideMenuViewController.h"
#import "MFSideMenu.h"
#import "AboutVC.h"
#import "ScanDevicesVC.h"
#import "SideMenuCell.h"
#import "TutoralVC.h"

@interface SideMenuViewController () <UITableViewDelegate, UITableViewDataSource>{
    UITableView *_table;
}

@end

@implementation SideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];//[UIColor colorWith256Red:55 green:51 blue:48];
    //menu header
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    view.backgroundColor = [UIColor colorWith256Red:31 green:26 blue:23];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(26, 30, self.view.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:22]];
    NSString *sectionTitle = @"Menu";
    [label setTextColor:[UIColor colorWith256Red:221 green:32 blue:36]];
    [label setText:sectionTitle];
    [view addSubview:label];
    [self.view addSubview:view];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
    _table.tag = 1111;
    _table.delegate = self;
    _table.dataSource = self;
    _table.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight);
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.backgroundColor = [UIColor clearColor];
    _table.scrollsToTop=YES;
    _table.bounces = NO;
    [self.view addSubview:_table];


}

#pragma mark -
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 56.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"SideMenuCell";
    
    SideMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SideMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone; 
    switch (indexPath.row) {
        case 0:
            cell.name = [NSString stringWithFormat:@"Diffusers"];
            cell.icon = @"ico_scancell.png";
            break;
        case 1:
            cell.name = [NSString stringWithFormat:@"Abount"];
            cell.icon = @"ico_sidemenu_share.png";
            break;
        case 2:
            cell.name = [NSString stringWithFormat:@"Totural"];
            cell.icon = @"ico_sidemenu_tutorial.png";
            break;
        default:
            break;
    }
    [cell setStyle];
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AboutVC *aboutVC;
    TutoralVC *tutoralVC;
    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSArray *controllers;
    switch (indexPath.row) {
        case 0: {
            controllers = [NSArray arrayWithObject:app.scanVC];
            navigationController.viewControllers = controllers;
            break;
        }
            
        case 1: {
            aboutVC = [[AboutVC alloc] init];
            NSArray *controllers = [NSArray arrayWithObject:aboutVC];
            navigationController.viewControllers = controllers;
            break;
        }
        case 2: {
            tutoralVC = [[TutoralVC alloc] init];
            NSArray *controllers = [NSArray arrayWithObject:tutoralVC];
            navigationController.viewControllers = controllers;
            break;
        }
        default: {
            break;
        }
            
    }
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
}



@end
