//
//  activityView.m
//  Weigo
//
//  Created by Edwin Hao on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "activityView.h"
#import "UIImage+GIF.h"
@implementation activityView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
		CALayer *layer = [CALayer layer];
		layer.frame = CGRectMake((self.frame.size.width-40)/2, 0, 40, 40);
		layer.contentsGravity = kCAGravityResizeAspect;
		layer.contents = (id)[UIImage imageNamed:@"rh_whirl.png"].CGImage;
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
			layer.contentsScale = [[UIScreen mainScreen] scale];
		}
#endif
		
		[[self layer] addSublayer:layer];
		_arrowImage=layer;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    UIImage *less=[UIImage imageNamed:@"rh_less.png"];
    [less drawAtPoint:CGPointMake((rect.size.width-less.size.width)/2, (rect.size.height-less.size.height)/2)];
    less=nil;
}
-(void)start{
    NSNumber *rotationAtStart = [_arrowImage valueForKeyPath:@"transform.rotation"];
    CATransform3D myRotationTransform = CATransform3DRotate(_arrowImage.transform, 360, 0.0, 0.0, 2.0);
    _arrowImage.transform = myRotationTransform;        
    CABasicAnimation *myAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    myAnimation.duration = 100.0f;
    myAnimation.repeatCount=1000;
    myAnimation.speed=3.2f;
    myAnimation.fromValue = rotationAtStart;
    myAnimation.toValue = [NSNumber numberWithFloat:([rotationAtStart floatValue] + 360)];
    [_arrowImage addAnimation:myAnimation forKey:@"transform.rotation"];

}

@end
