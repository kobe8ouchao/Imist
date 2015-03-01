//
//  PeriperalInfo.m
//  DarkBlue
//
//  Created by chenee on 14-3-26.
//  Copyright (c) 2014年 chenee. All rights reserved.
//

#import "PeriperalInfo.h"

@implementation PeriperalInfo
@synthesize water,mode,alert,ledauto,ledcolor,ledlight,imist;
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.water forKey:@"waterKey"];
    [encoder encodeObject:self.mode forKey:@"modeKey"];
    [encoder encodeObject:self.alert forKey:@"alertKey"];
    [encoder encodeObject:self.ledauto forKey:@"ledautoKey"];
    [encoder encodeObject:self.ledcolor forKey:@"ledcolorKey"];
    [encoder encodeObject:self.ledlight forKey:@"ledlightKey"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if((self = [super init]))
    {
        self.water = [decoder decodeObjectForKey:@"waterKey"];
        self.mode = [decoder decodeObjectForKey:@"modeKey"];
        self.alert = (NSMutableArray*)[decoder decodeObjectForKey:@"alertKey"];
        self.ledauto = [decoder decodeObjectForKey:@"ledautoKey"];
        self.ledcolor = [decoder decodeObjectForKey:@"ledcolorKey"];
        self.ledlight = [decoder decodeObjectForKey:@"ledlightKey"];
    }
    return self;
}

@end
