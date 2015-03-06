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
    [encoder encodeObject:self.userset2Hour forKey:@"2Hour"];
    [encoder encodeObject:self.userset4Hour forKey:@"4Hour"];
    [encoder encodeObject:self.userset8Hour forKey:@"8Hour"];
    [encoder encodeObject:self.userset16Hour forKey:@"16Hour"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if((self = [super init]))
    {
        self.water = [decoder decodeObjectForKey:@"waterKey"];
        self.mode = [decoder decodeObjectForKey:@"modeKey"];
        self.alert = (NSMutableArray*)[decoder decodeObjectForKey:@"alertKey"];
        self.userset2Hour = [decoder decodeObjectForKey:@"2Hour"];
        self.userset4Hour = [decoder decodeObjectForKey:@"4Hour"];
        self.userset8Hour = [decoder decodeObjectForKey:@"8Hour"];
        self.userset16Hour = [decoder decodeObjectForKey:@"16Hour"];
    }
    return self;
}

@end
