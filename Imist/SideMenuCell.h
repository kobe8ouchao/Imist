//
//  SideMenuCell.h
//  Imist
//
//  Created by chao.ou on 15/1/10.
//  Copyright (c) 2015年 oc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuCell : UITableViewCell
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *icon;

-(void)setStyle;
@end
