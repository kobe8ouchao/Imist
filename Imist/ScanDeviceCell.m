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
        bg.image = [UIImage imageNamed:@"bg_scancell_gray.png"];
        bg.backgroundColor = [UIColor clearColor];
        bg.tag = 4;
        [self addSubview:bg];
        
        UIImageView *vicon = [[UIImageView alloc] initWithFrame:CGRectMake(23, 10, 30, 30)];
        vicon.backgroundColor = [UIColor clearColor];
        vicon.image = [UIImage imageNamed:@"ico_imist.png"];
        vicon.tag = 1;
        [self addSubview:vicon];
        
        UILabel *vname = [[UILabel alloc] initWithFrame:CGRectMake(60, 16, self.frame.size.width,18)];
        [vname setFont:[UIFont boldSystemFontOfSize:18]];
        vname.tag = 2;
        vname.textColor = [UIColor whiteColor];
        [self addSubview:vname];
        
        UIButton *connectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [connectBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn_blue.png"] forState:UIControlStateNormal];
        [connectBtn setTitle:@"Connect" forState:UIControlStateNormal];
        connectBtn.tag = 3;
        [connectBtn setBackgroundColor:[UIColor clearColor]];
        connectBtn.frame = CGRectMake(self.frame.size.width - 120, 5, 100, 40);
        [connectBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        connectBtn.hidden = YES;
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

- (void) setState:(NSInteger)state
{
    UIButton *connectBtn = (UIButton *)[self viewWithTag:3];
    if (1 <= state) {
        connectBtn.hidden = NO;
        [connectBtn setTitle:@"Disconnect" forState:UIControlStateNormal];
    }else {
        dispatch_async(dispatch_get_main_queue(), ^{
        connectBtn.hidden = YES;
        });
        //[connectBtn setTitle:@"Connect" forState:UIControlStateNormal];
    }
    UIImageView *bg = (UIImageView *)[self viewWithTag:4];
    if (1 == state) {
        bg.image = [UIImage imageNamed:@"bg_scancell_green.png"];
    }else if(0 == state){
        dispatch_async(dispatch_get_main_queue(), ^{
        bg.image = [UIImage imageNamed:@"bg_scancell_gray.png"];
        });
    }else if(2 == state){
        bg.image = [UIImage imageNamed:@"bg_scancell_red.png"];
    }else if(3 == state) {
        bg.image = [UIImage imageNamed:@"bg_scancell_blue.png"];
    }
    
    
}

-(void)btnClick:(UIButton*)btn{
    if ([delegate respondsToSelector:@selector(btnClick:)]) {
        [delegate btnClick:self.index.row];
    }
}


@end
