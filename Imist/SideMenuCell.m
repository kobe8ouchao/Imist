//
//  SideMenuCell.m
//  Imist
//
//  Created by chao.ou on 15/1/10.
//  Copyright (c) 2015年 oc. All rights reserved.
//

#import "SideMenuCell.h"

@implementation SideMenuCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width, self.frame.size.height )];
        bg.image = [UIImage imageNamed:@"bg_sidemenu_cell.png"];
        [self addSubview:bg];
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(23, 8, 30, 30)];
        icon.backgroundColor = [UIColor clearColor];
        icon.tag = 1;
        [self addSubview:icon];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(60, 12, self.frame.size.width,18)];
        [name setFont:[UIFont boldSystemFontOfSize:18]];
        name.tag = 2;
        name.textColor = [UIColor whiteColor];
        [self addSubview:name];
    }
    return self;
}

- (void)setStyle
{
    UIImageView *icon = (UIImageView *)[self viewWithTag:1];
    UILabel *name = (UILabel *)[self viewWithTag:2];
    icon.image = [UIImage imageNamed:self.icon];
    name.text = self.name;
}

@end
