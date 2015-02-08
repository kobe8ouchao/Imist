//
//  AlertSettingCell.h
//  Imist
//
//  Created by chao.ou on 15/2/1.
//  Copyright (c) 2015年 oc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertSettingCell : UITableViewCell
@property (nonatomic, strong)NSString *time;
@property (nonatomic, strong)NSString *days;
@property (nonatomic, assign)BOOL isOpen;
-(void) setStyle;
@end
