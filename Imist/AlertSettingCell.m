//
//  AlertSettingCell.m
//  Imist
//
//  Created by chao.ou on 15/2/1.
//  Copyright (c) 2015年 oc. All rights reserved.
//

#import "AlertSettingCell.h"

@implementation AlertSettingCell
@synthesize time;
- (void)awakeFromNib {
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.height)];
        bg.image = [UIImage imageNamed:@"bg_scancell_green.png"];
        bg.backgroundColor = [UIColor clearColor];
        [self addSubview:bg];
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 11, 200 ,18)];
        [lable setFont:[UIFont boldSystemFontOfSize:18]];
        lable.tag = 1;
        lable.textAlignment = NSTextAlignmentLeft;
        lable.text = time;
        lable.textColor = [UIColor whiteColor];
        [bg addSubview:lable];
        
        UISwitch *showBuzzerSwich = [[UISwitch alloc] initWithFrame:CGRectMake(bg.frame.size.width - 40 - 20,4,40.0,40.0)];
        
        showBuzzerSwich.onTintColor=[UIColor colorWith256Red:192 green:238 blue:32];
        [showBuzzerSwich addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        showBuzzerSwich.tag = 2;
        [bg addSubview:showBuzzerSwich];
        [self addSubview:bg];
    }
    return self;
}

- (void)setStyle
{
    UILabel *timelable = (UILabel *)[self viewWithTag:1];
    timelable.text = self.time;
    UISwitch *showBuzzerSwich = (UISwitch *)[self viewWithTag:2];
    if (self.isOpen) {
        showBuzzerSwich.on = YES;
    }else {
        showBuzzerSwich.on = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)switchAction:(UISwitch*)showBuzzerSwich{
    
}

@end
