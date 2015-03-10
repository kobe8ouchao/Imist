//
//  AlertSettingCell.m
//  Imist
//
//  Created by chao.ou on 15/2/1.
//  Copyright (c) 2015年 oc. All rights reserved.
//

#import "AlertSettingCell.h"
#import "AppDelegate.h"

@implementation AlertSettingCell
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
        [self addSubview:bg];
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(20, 11, 100 ,18)];
        [lable setFont:[UIFont boldSystemFontOfSize:18]];
        lable.tag = 1;
        lable.textAlignment = NSTextAlignmentLeft;
        lable.text = time;
        lable.textColor = [UIColor whiteColor];
        [bg addSubview:lable];
        
        UILabel *alarmName = [[UILabel alloc] initWithFrame:CGRectMake(40, 11, 200 ,18)];
        [alarmName setFont:[UIFont boldSystemFontOfSize:18]];
        alarmName.tag = 2;
        alarmName.textAlignment = NSTextAlignmentLeft;
        alarmName.text = name;
        alarmName.textColor = [UIColor whiteColor];
        [bg addSubview:alarmName];
//        UILabel *weekday = [[UILabel alloc] initWithFrame:CGRectMake(40, 11, 200 ,18)];
//        [weekday setFont:[UIFont boldSystemFontOfSize:14]];
//        weekday.tag = 2;
//        weekday.textAlignment = NSTextAlignmentLeft;
//        weekday.textColor = [UIColor whiteColor];
//        [bg addSubview:weekday];
        
        UISwitch *showBuzzerSwich = [[UISwitch alloc] initWithFrame:CGRectMake(bg.frame.size.width - 40 - 20,(bg.frame.size.height - 40)/2 + 4,40.0,40.0)];
        
        showBuzzerSwich.onTintColor=[UIColor colorWith256Red:192 green:238 blue:32];
        [showBuzzerSwich addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        showBuzzerSwich.tag = 3;
//        [bg addSubview:showBuzzerSwich];
        [self addSubview:showBuzzerSwich];
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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)switchAction:(UISwitch*)showBuzzerSwich{
    if(showBuzzerSwich.on){
        self.isOpen = YES;
    }
    else{
        self.isOpen = NO;
    }
    if ([self.delegate respondsToSelector:@selector(switchChange: enable:)]) {
        [self.delegate switchChange:self.index.row enable:self.isOpen];
    }
}

@end
