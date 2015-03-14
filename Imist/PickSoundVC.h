//
//  PickSoundVC.h
//  Imist
//
//  Created by chao.ou on 15/1/22.
//  Copyright (c) 2015年 oc. All rights reserved.
//

#import "BaseViewController.h"
@protocol pickSoundDelegate;
@interface PickSoundVC : BaseViewController {
}
@property (nonatomic,strong) NSString *selectedSound;
@property (nonatomic,strong) NSString *selectedSoundName;
@property (nonatomic, assign) id<pickSoundDelegate> delegate;
@end
@protocol pickSoundDelegate <NSObject>
-(void)saveSound:(NSString*)sound;
@end