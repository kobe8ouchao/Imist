//
//  ScanDeviceCell.h
//  Imist
//
//  Created by chao.ou on 15/1/10.
//  Copyright (c) 2015年 oc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol scanDeviceCellDelegate;
@interface ScanDeviceCell : UITableViewCell {
    __weak id <scanDeviceCellDelegate> delegate;
}
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *icon;
@property (nonatomic, strong)NSIndexPath *index;
@property (nonatomic ,weak) id delegate;
-(void)setStyle;
@end
@protocol scanDeviceCellDelegate <NSObject>
-(void)btnClick:(NSInteger)index;
@end