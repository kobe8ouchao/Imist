//
//  AlertSettingCell.m
//  Imist
//
//  Created by chao.ou on 15/2/1.
//  Copyright (c) 2015年 oc. All rights reserved.
//

#import "WakeDetailCell.h"
#import "AppDelegate.h"

@implementation WakeDetailCell
@synthesize time,days,name;
- (void)awakeFromNib {
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.height)];
        bg.image = [UIImage imageNamed:@"bg_scancell_green.png"];
        bg.backgroundColor = [UIColor clearColor];
        bg.tag = 4;
        [self addSubview:bg];
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(20, 11, 80 ,18)];
        [lable setFont:[UIFont boldSystemFontOfSize:18]];
        lable.tag = 1;
        lable.textAlignment = NSTextAlignmentLeft;
        lable.text = time;
        lable.textColor = [UIColor whiteColor];
        [bg addSubview:lable];
        
        UILabel *alarmName = [[UILabel alloc] initWithFrame:CGRectMake(120, 11, 120 ,18)];
        [alarmName setFont:[UIFont boldSystemFontOfSize:18]];
        alarmName.tag = 2;
        alarmName.textAlignment = NSTextAlignmentLeft;
        alarmName.text = name;
        alarmName.textColor = [UIColor whiteColor];
        [bg addSubview:alarmName];

    }
    return self;
}

- (void)setStyle
{
//    NSDictionary *weekday = [NSDictionary dictionaryWithObjectsAndKeys:@"Mon",@"1",@"thu",@"2",@"Wed",@"3",@"Thr",@"4",@"Fri",@"5",@"Sat",@"6",@"Sun",@"7",nil];
    UILabel *timelable = (UILabel *)[self viewWithTag:1];
    timelable.text = self.time;
    UILabel *namelabel = (UILabel *)[self viewWithTag:2];
    namelabel.text = self.name;
//    UILabel *weekdays = (UILabel *)[self viewWithTag:2];
//    NSArray *weds = [self.days componentsSeparatedByString:@"|"];
//    NSString *repeatText = @"(";
//    NSInteger i = 0;
//    for (NSString *d in weds) {
//        [repeatText stringByAppendingString:[weekday valueForKey:d]];
//        if (i != [weds count] - 1) {
//            [repeatText stringByAppendingString:@","];
//        }
//        i++;
//    }
//    [repeatText stringByAppendingString:@")"];
//    weekdays.text = repeatText;
    UISwitch *showBuzzerSwich = (UISwitch *)[self viewWithTag:3];
    if (self.isOpen) {
        showBuzzerSwich.on = YES;
    }else {
        showBuzzerSwich.on = NO;
    }
    UIImageView *bg = (UIImageView *)[self viewWithTag:4];
    if (self.isOpen) {
        bg.image = [UIImage imageNamed:@"bg_scancell_green.png"];
    }else {
        bg.image = [UIImage imageNamed:@"bg_scancell_gray.png"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)switchAction:(UISwitch*)showBuzzerSwich{
    UIImageView *bg = (UIImageView *)[self viewWithTag:4];
    if(showBuzzerSwich.on){
        self.isOpen = YES;
        bg.image = [UIImage imageNamed:@"bg_scancell_green.png"];
    }
    else{
        self.isOpen = NO;
        bg.image = [UIImage imageNamed:@"bg_scancell_gray.png"];
    }
    if ([self.delegate respondsToSelector:@selector(switchChange: enable:)]) {
        [self.delegate switchChange:self.index.row enable:self.isOpen];
    }
}

@end
