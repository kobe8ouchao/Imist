//
//  PickDayVC.h
//  Imist
//
//  Created by chao.ou on 15/1/21.
//  Copyright (c) 2015年 oc. All rights reserved.
//

#import "BaseViewController.h"
@protocol pickDayDelegate;
@interface PickDayVC : BaseViewController {
    __weak id <pickDayDelegate> delegate;
}

@end
@protocol pickDayDelegate <NSObject>
-(void)saveDay:(NSArray*)days;
@end