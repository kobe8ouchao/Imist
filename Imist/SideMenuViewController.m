//
//  SideMenuViewController.m
//  MFSideMenuDemo
//
//  Created by Michael Frederick on 3/19/12.

#import "SideMenuViewController.h"
#import "MFSideMenu.h"
#import "AboutVC.h"
#import "ScanDevicesVC.h"

@implementation SideMenuViewController

#pragma mark -
#pragma mark - UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Left Menu"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = [NSString stringWithFormat:@"Devices"];
            break;
        case 1:
            cell.textLabel.text = [NSString stringWithFormat:@"Abount"];
            break;
        default:
            break;
    }    
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AboutVC *aboutVC;
    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSArray *controllers;
    switch (indexPath.row) {
        case 0:
            controllers = [NSArray arrayWithObject:app.scanVC];
            navigationController.viewControllers = controllers;
            break;
        case 1:
            aboutVC = [[AboutVC alloc] init];
            NSArray *controllers = [NSArray arrayWithObject:aboutVC];
            navigationController.viewControllers = controllers;
            break;
    }
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
}

@end
