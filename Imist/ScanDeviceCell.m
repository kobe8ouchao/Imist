//
//  ScanDeviceCell.m
//  Imist
//
//  Created by chao.ou on 15/1/10.
//  Copyright (c) 2015年 oc. All rights reserved.
//

#import "ScanDeviceCell.h"

@implementation ScanDeviceCell
@synthesize name,icon,delegate;
- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, 50.0f)];
        bg.backgroundColor = [UIColor darkGrayColor];
        [self addSubview:bg];
        
        UIImageView *vicon = [[UIImageView alloc] initWithFrame:CGRectMake(23, 10, 30, 30)];
        vicon.backgroundColor = [UIColor redColor];
        vicon.tag = 1;
        [self addSubview:vicon];
        
        UILabel *vname = [[UILabel alloc] initWithFrame:CGRectMake(60, 16, self.frame.size.width,18)];
        [vname setFont:[UIFont boldSystemFontOfSize:18]];
        vname.tag = 2;
        vname.textColor = [UIColor whiteColor];
        [self addSubview:vname];
        
        UIButton *connectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [connectBtn setBackgroundImage:[[UIImage imageNamed:@"bg_btn_line_normal.png"] stretchableImageWithLeftCapWidth:12 topCapHeight:12] forState:UIControlStateNormal];
        [connectBtn setTitle:@"Connect" forState:UIControlStateNormal];
        [connectBtn setBackgroundColor:[UIColor blueColor]];
        connectBtn.frame = CGRectMake(self.frame.size.width - 120, 5, 100, 40);
        [connectBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:connectBtn];
    }
    return self;
}

- (void)setStyle
{
    UIImageView *vicon = (UIImageView *)[self viewWithTag:1];
    UILabel *vname = (UILabel *)[self viewWithTag:2];
    vicon.image = [UIImage imageNamed:self.icon];
    vname.text = self.name;
}

-(void)btnClick:(UIButton*)btn{
    if ([delegate respondsToSelector:@selector(btnClick:)]) {
        [delegate btnClick:self.index.row];
    }
}


@end
