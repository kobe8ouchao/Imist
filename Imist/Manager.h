//
//  Manager.h
//  Imist
//
//  Created by Christ on 3/6/15.
//  Copyright (c) 2015 oc. All rights reserved.
//

#ifndef Imist_Manager_h
#define Imist_Manager_h

#import <foundation/Foundation.h>

@interface Manager : NSObject {
    NSDictionary *colorR;
    NSDictionary *colorG;
    NSDictionary *colorB;
}


+ (id)sharedManager;
- (NSInteger) getColorR:(NSInteger)color;
- (NSInteger) getColorG:(NSInteger)color;
- (NSInteger) getColorB:(NSInteger)color;
- (NSInteger)getCurModeCmd:(NSString*)modeString;

@end

#endif
