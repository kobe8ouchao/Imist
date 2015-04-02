//
//  AlertSettingCell.h
//  Imist
//
//  Created by chao.ou on 15/2/1.
//  Copyright (c) 2015年 oc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol wakeDetailCellDelegate;
@interface WakeDetailCell : UITableViewCell{
    __weak id <wakeDetailCellDelegate> delegate;
}

@property (nonatomic, strong)NSString *time;
@property (nonatomic, strong)NSString *days;
@property (nonatomic, assign)BOOL isOpen;
@property (nonatomic, strong)NSIndexPath *index;
@property (nonatomic, strong)NSString *name;
@property (nonatomic ,weak) id delegate;
-(void) setStyle;
@end
@protocol wakeDetailCellDelegate <NSObject>
-(void)switchChange:(NSInteger)index enable:(BOOL)yesNo;
@end
