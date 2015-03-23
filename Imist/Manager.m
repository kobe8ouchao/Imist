//
//  Manager.m
//  Imist
//
//  Created by Christ on 3/6/15.
//  Copyright (c) 2015 oc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Manager.h"
#import "AppDelegate.h"

@implementation Manager

static NSDictionary *colorR;
static NSDictionary *colorG;
static NSDictionary *colorB;
#pragma mark Singleton Methods

+ (id)sharedManager {
    static Manager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        colorR = @{
                   @"1" : [NSNumber numberWithInt:100],
                   @"2" : [NSNumber numberWithInt:100],
                   @"3" : [NSNumber numberWithInt:100],
                   @"4" : [NSNumber numberWithInt:100],
                   @"5" : [NSNumber numberWithInt:100],
                   @"6" : [NSNumber numberWithInt:100],
                   @"7" : [NSNumber numberWithInt:100],
                   @"8" : [NSNumber numberWithInt:100],
                   @"9" : [NSNumber numberWithInt:100],
                   @"10" : [NSNumber numberWithInt:100],
                   @"11" : [NSNumber numberWithInt:100],
                   @"12" : [NSNumber numberWithInt:100],
                   @"13" : [NSNumber numberWithInt:100],
                   @"14" : [NSNumber numberWithInt:100],
                   @"15" : [NSNumber numberWithInt:100],
                   @"16" : [NSNumber numberWithInt:100],
                   @"17" : [NSNumber numberWithInt:100],
                   @"18" : [NSNumber numberWithInt:100],
                   @"19" : [NSNumber numberWithInt:94],
                   @"20" : [NSNumber numberWithInt:88],
                   @"21" : [NSNumber numberWithInt:82],
                   @"22" : [NSNumber numberWithInt:76],
                   @"23" : [NSNumber numberWithInt:70],
                   @"24" : [NSNumber numberWithInt:64],
                   @"25" : [NSNumber numberWithInt:58],
                   @"26" : [NSNumber numberWithInt:52],
                   @"27" : [NSNumber numberWithInt:46],
                   @"28" : [NSNumber numberWithInt:40],
                   @"29" : [NSNumber numberWithInt:34],
                   @"30" : [NSNumber numberWithInt:28],
                   @"31" : [NSNumber numberWithInt:22],
                   @"32" : [NSNumber numberWithInt:16],
                   @"33" : [NSNumber numberWithInt:10],
                   @"34" : [NSNumber numberWithInt:4],
                   @"35" : [NSNumber numberWithInt:0],
                   @"36" : [NSNumber numberWithInt:0],
                   @"37" : [NSNumber numberWithInt:0],
                   @"38" : [NSNumber numberWithInt:0],
                   @"39" : [NSNumber numberWithInt:0],
                   @"40" : [NSNumber numberWithInt:0],
                   @"41" : [NSNumber numberWithInt:0],
                   @"42" : [NSNumber numberWithInt:0],
                   @"43" : [NSNumber numberWithInt:0],
                   @"44" : [NSNumber numberWithInt:0],
                   @"45" : [NSNumber numberWithInt:0],
                   @"46" : [NSNumber numberWithInt:0],
                   @"47" : [NSNumber numberWithInt:0],
                   @"48" : [NSNumber numberWithInt:0],
                   @"49" : [NSNumber numberWithInt:0],
                   @"50" : [NSNumber numberWithInt:0],
                   @"51" : [NSNumber numberWithInt:0],
                   @"52" : [NSNumber numberWithInt:0],
                   @"53" : [NSNumber numberWithInt:0],
                   @"54" : [NSNumber numberWithInt:0],
                   @"55" : [NSNumber numberWithInt:0],
                   @"56" : [NSNumber numberWithInt:0],
                   @"57" : [NSNumber numberWithInt:0],
                   @"58" : [NSNumber numberWithInt:0],
                   @"59" : [NSNumber numberWithInt:0],
                   @"60" : [NSNumber numberWithInt:0],
                   @"61" : [NSNumber numberWithInt:0],
                   @"62" : [NSNumber numberWithInt:0],
                   @"63" : [NSNumber numberWithInt:0],
                   @"64" : [NSNumber numberWithInt:0],
                   @"65" : [NSNumber numberWithInt:0],
                   @"66" : [NSNumber numberWithInt:0],
                   @"67" : [NSNumber numberWithInt:0],
                   @"68" : [NSNumber numberWithInt:6],
                   @"69" : [NSNumber numberWithInt:12],
                   @"70" : [NSNumber numberWithInt:18],
                   @"71" : [NSNumber numberWithInt:24],
                   @"72" : [NSNumber numberWithInt:30],
                   @"73" : [NSNumber numberWithInt:36],
                   @"74" : [NSNumber numberWithInt:42],
                   @"75" : [NSNumber numberWithInt:48],
                   @"76" : [NSNumber numberWithInt:54],
                   @"77" : [NSNumber numberWithInt:60],
                   @"78" : [NSNumber numberWithInt:66],
                   @"79" : [NSNumber numberWithInt:72],
                   @"80" : [NSNumber numberWithInt:78],
                   @"81" : [NSNumber numberWithInt:84],
                   @"82" : [NSNumber numberWithInt:90],
                   @"83" : [NSNumber numberWithInt:96],
                   @"84" : [NSNumber numberWithInt:100],
                   @"85" : [NSNumber numberWithInt:100],
                   @"86" : [NSNumber numberWithInt:100],
                   @"87" : [NSNumber numberWithInt:100],
                   @"88" : [NSNumber numberWithInt:100],
                   @"89" : [NSNumber numberWithInt:100],
                   @"90" : [NSNumber numberWithInt:100],
                   @"91" : [NSNumber numberWithInt:100],
                   @"92" : [NSNumber numberWithInt:100],
                   @"93" : [NSNumber numberWithInt:100],
                   @"94" : [NSNumber numberWithInt:100],
                   @"95" : [NSNumber numberWithInt:100],
                   @"96" : [NSNumber numberWithInt:100],
                   @"97" : [NSNumber numberWithInt:100],
                   @"98" : [NSNumber numberWithInt:100],
                   @"99" : [NSNumber numberWithInt:100],
                   @"100" : [NSNumber numberWithInt:100],
                   };
        colorG = @{
                   @"1" : [NSNumber numberWithInt:0],
                   @"2" : [NSNumber numberWithInt:6],
                   @"3" : [NSNumber numberWithInt:12],
                   @"4" : [NSNumber numberWithInt:18],
                   @"5" : [NSNumber numberWithInt:24],
                   @"6" : [NSNumber numberWithInt:30],
                   @"7" : [NSNumber numberWithInt:36],
                   @"8" : [NSNumber numberWithInt:42],
                   @"9" : [NSNumber numberWithInt:48],
                   @"10" : [NSNumber numberWithInt:54],
                   @"11" : [NSNumber numberWithInt:60],
                   @"12" : [NSNumber numberWithInt:66],
                   @"13" : [NSNumber numberWithInt:72],
                   @"14" : [NSNumber numberWithInt:78],
                   @"15" : [NSNumber numberWithInt:84],
                   @"16" : [NSNumber numberWithInt:90],
                   @"17" : [NSNumber numberWithInt:96],
                   @"18" : [NSNumber numberWithInt:100],
                   @"19" : [NSNumber numberWithInt:100],
                   @"20" : [NSNumber numberWithInt:100],
                   @"21" : [NSNumber numberWithInt:100],
                   @"22" : [NSNumber numberWithInt:100],
                   @"23" : [NSNumber numberWithInt:100],
                   @"24" : [NSNumber numberWithInt:100],
                   @"25" : [NSNumber numberWithInt:100],
                   @"26" : [NSNumber numberWithInt:100],
                   @"27" : [NSNumber numberWithInt:100],
                   @"28" : [NSNumber numberWithInt:100],
                   @"29" : [NSNumber numberWithInt:100],
                   @"30" : [NSNumber numberWithInt:100],
                   @"31" : [NSNumber numberWithInt:100],
                   @"32" : [NSNumber numberWithInt:100],
                   @"33" : [NSNumber numberWithInt:100],
                   @"34" : [NSNumber numberWithInt:100],
                   @"35" : [NSNumber numberWithInt:100],
                   @"36" : [NSNumber numberWithInt:100],
                   @"37" : [NSNumber numberWithInt:100],
                   @"38" : [NSNumber numberWithInt:100],
                   @"39" : [NSNumber numberWithInt:100],
                   @"40" : [NSNumber numberWithInt:100],
                   @"41" : [NSNumber numberWithInt:100],
                   @"42" : [NSNumber numberWithInt:100],
                   @"43" : [NSNumber numberWithInt:100],
                   @"44" : [NSNumber numberWithInt:100],
                   @"45" : [NSNumber numberWithInt:100],
                   @"46" : [NSNumber numberWithInt:100],
                   @"47" : [NSNumber numberWithInt:100],
                   @"48" : [NSNumber numberWithInt:100],
                   @"49" : [NSNumber numberWithInt:100],
                   @"50" : [NSNumber numberWithInt:100],
                   @"51" : [NSNumber numberWithInt:100],
                   @"52" : [NSNumber numberWithInt:94],
                   @"53" : [NSNumber numberWithInt:88],
                   @"54" : [NSNumber numberWithInt:82],
                   @"55" : [NSNumber numberWithInt:76],
                   @"56" : [NSNumber numberWithInt:70],
                   @"57" : [NSNumber numberWithInt:64],
                   @"58" : [NSNumber numberWithInt:58],
                   @"59" : [NSNumber numberWithInt:52],
                   @"60" : [NSNumber numberWithInt:46],
                   @"61" : [NSNumber numberWithInt:40],
                   @"62" : [NSNumber numberWithInt:34],
                   @"63" : [NSNumber numberWithInt:28],
                   @"64" : [NSNumber numberWithInt:22],
                   @"65" : [NSNumber numberWithInt:16],
                   @"66" : [NSNumber numberWithInt:10],
                   @"67" : [NSNumber numberWithInt:4],
                   @"68" : [NSNumber numberWithInt:0],
                   @"69" : [NSNumber numberWithInt:0],
                   @"70" : [NSNumber numberWithInt:0],
                   @"71" : [NSNumber numberWithInt:0],
                   @"72" : [NSNumber numberWithInt:0],
                   @"73" : [NSNumber numberWithInt:0],
                   @"74" : [NSNumber numberWithInt:0],
                   @"75" : [NSNumber numberWithInt:0],
                   @"76" : [NSNumber numberWithInt:0],
                   @"77" : [NSNumber numberWithInt:0],
                   @"78" : [NSNumber numberWithInt:0],
                   @"79" : [NSNumber numberWithInt:0],
                   @"80" : [NSNumber numberWithInt:0],
                   @"81" : [NSNumber numberWithInt:0],
                   @"82" : [NSNumber numberWithInt:0],
                   @"83" : [NSNumber numberWithInt:0],
                   @"84" : [NSNumber numberWithInt:0],
                   @"85" : [NSNumber numberWithInt:0],
                   @"86" : [NSNumber numberWithInt:0],
                   @"87" : [NSNumber numberWithInt:0],
                   @"88" : [NSNumber numberWithInt:0],
                   @"89" : [NSNumber numberWithInt:0],
                   @"90" : [NSNumber numberWithInt:0],
                   @"91" : [NSNumber numberWithInt:0],
                   @"92" : [NSNumber numberWithInt:0],
                   @"93" : [NSNumber numberWithInt:0],
                   @"94" : [NSNumber numberWithInt:0],
                   @"95" : [NSNumber numberWithInt:0],
                   @"96" : [NSNumber numberWithInt:0],
                   @"97" : [NSNumber numberWithInt:0],
                   @"98" : [NSNumber numberWithInt:0],
                   @"99" : [NSNumber numberWithInt:0],
                   @"100" : [NSNumber numberWithInt:0],
                   };
        colorB = @{
                    @"1" : [NSNumber numberWithInt:0],
                    @"2" : [NSNumber numberWithInt:0],
                    @"3" : [NSNumber numberWithInt:0],
                    @"4" : [NSNumber numberWithInt:0],
                    @"5" : [NSNumber numberWithInt:0],
                    @"6" : [NSNumber numberWithInt:0],
                    @"7" : [NSNumber numberWithInt:0],
                    @"8" : [NSNumber numberWithInt:0],
                    @"9" : [NSNumber numberWithInt:0],
                    @"10" : [NSNumber numberWithInt:0],
                    @"11" : [NSNumber numberWithInt:0],
                    @"12" : [NSNumber numberWithInt:0],
                    @"13" : [NSNumber numberWithInt:0],
                    @"14" : [NSNumber numberWithInt:0],
                    @"15" : [NSNumber numberWithInt:0],
                    @"16" : [NSNumber numberWithInt:0],
                    @"17" : [NSNumber numberWithInt:0],
                    @"18" : [NSNumber numberWithInt:0],
                    @"19" : [NSNumber numberWithInt:0],
                    @"20" : [NSNumber numberWithInt:0],
                    @"21" : [NSNumber numberWithInt:0],
                    @"22" : [NSNumber numberWithInt:0],
                    @"23" : [NSNumber numberWithInt:0],
                    @"24" : [NSNumber numberWithInt:0],
                    @"25" : [NSNumber numberWithInt:0],
                    @"26" : [NSNumber numberWithInt:0],
                    @"27" : [NSNumber numberWithInt:0],
                    @"28" : [NSNumber numberWithInt:0],
                    @"29" : [NSNumber numberWithInt:0],
                    @"30" : [NSNumber numberWithInt:0],
                    @"31" : [NSNumber numberWithInt:0],
                    @"32" : [NSNumber numberWithInt:0],
                    @"33" : [NSNumber numberWithInt:0],
                    @"34" : [NSNumber numberWithInt:0],
                    @"35" : [NSNumber numberWithInt:6],
                    @"36" : [NSNumber numberWithInt:12],
                    @"37" : [NSNumber numberWithInt:18],
                    @"38" : [NSNumber numberWithInt:24],
                    @"39" : [NSNumber numberWithInt:30],
                    @"40" : [NSNumber numberWithInt:36],
                    @"41" : [NSNumber numberWithInt:42],
                    @"42" : [NSNumber numberWithInt:48],
                    @"43" : [NSNumber numberWithInt:54],
                    @"44" : [NSNumber numberWithInt:60],
                    @"45" : [NSNumber numberWithInt:66],
                    @"46" : [NSNumber numberWithInt:72],
                    @"47" : [NSNumber numberWithInt:78],
                    @"48" : [NSNumber numberWithInt:84],
                    @"49" : [NSNumber numberWithInt:90],
                    @"50" : [NSNumber numberWithInt:96],
                    @"51" : [NSNumber numberWithInt:100],
                    @"52" : [NSNumber numberWithInt:100],
                    @"53" : [NSNumber numberWithInt:100],
                    @"54" : [NSNumber numberWithInt:100],
                    @"55" : [NSNumber numberWithInt:100],
                    @"56" : [NSNumber numberWithInt:100],
                    @"57" : [NSNumber numberWithInt:100],
                    @"58" : [NSNumber numberWithInt:100],
                    @"59" : [NSNumber numberWithInt:100],
                    @"60" : [NSNumber numberWithInt:100],
                    @"61" : [NSNumber numberWithInt:100],
                    @"62" : [NSNumber numberWithInt:100],
                    @"63" : [NSNumber numberWithInt:100],
                    @"64" : [NSNumber numberWithInt:100],
                    @"65" : [NSNumber numberWithInt:100],
                    @"66" : [NSNumber numberWithInt:100],
                    @"67" : [NSNumber numberWithInt:100],
                    @"68" : [NSNumber numberWithInt:100],
                    @"69" : [NSNumber numberWithInt:100],
                    @"70" : [NSNumber numberWithInt:100],
                    @"71" : [NSNumber numberWithInt:100],
                    @"72" : [NSNumber numberWithInt:100],
                    @"73" : [NSNumber numberWithInt:100],
                    @"74" : [NSNumber numberWithInt:100],
                    @"75" : [NSNumber numberWithInt:100],
                    @"76" : [NSNumber numberWithInt:100],
                    @"77" : [NSNumber numberWithInt:100],
                    @"78" : [NSNumber numberWithInt:100],
                    @"79" : [NSNumber numberWithInt:100],
                    @"80" : [NSNumber numberWithInt:100],
                    @"81" : [NSNumber numberWithInt:100],
                    @"82" : [NSNumber numberWithInt:100],
                    @"83" : [NSNumber numberWithInt:100],
                    @"84" : [NSNumber numberWithInt:100],
                    @"85" : [NSNumber numberWithInt:94],
                    @"86" : [NSNumber numberWithInt:88],
                    @"87" : [NSNumber numberWithInt:82],
                    @"88" : [NSNumber numberWithInt:76],
                    @"89" : [NSNumber numberWithInt:70],
                    @"90" : [NSNumber numberWithInt:64],
                    @"91" : [NSNumber numberWithInt:58],
                    @"92" : [NSNumber numberWithInt:46],
                    @"93" : [NSNumber numberWithInt:40],
                    @"94" : [NSNumber numberWithInt:34],
                    @"95" : [NSNumber numberWithInt:28],
                    @"96" : [NSNumber numberWithInt:22],
                    @"97" : [NSNumber numberWithInt:16],
                    @"98" : [NSNumber numberWithInt:10],
                    @"99" : [NSNumber numberWithInt:4],
                    @"100" : [NSNumber numberWithInt:0],
                    };

    }
    return self;
}

- (NSInteger)getColorR:(NSInteger)color{
    NSInteger returncolor;
    returncolor = [[colorR objectForKey:[NSString stringWithFormat:@"%ld",(long)color]] integerValue] *2.55;
    //NSLog(@"R = %ld",returncolor);
    return returncolor;
}

- (NSInteger)getColorG:(NSInteger)color{
    NSInteger returncolor;
    returncolor = [[colorG objectForKey:[NSString stringWithFormat:@"%ld",(long)color]] integerValue] *2.55;
    //NSLog(@"G = %ld",returncolor);
    return returncolor;
}

- (NSInteger)getColorB:(NSInteger)color{
    NSInteger returncolor;
    returncolor = [[colorB objectForKey:[NSString stringWithFormat:@"%ld",(long)color]] integerValue] *2.55;
    //NSLog(@"B = %ld",returncolor);
    return returncolor;
}

- (NSInteger)getCurModeCmd:(NSString*)modeString{
    NSInteger cmd = 0;
    if([modeString isEqualToString:@"Relaxation"]){
        cmd = 3;
    }
    else if([modeString isEqualToString:@"Sleep"]){
        cmd = 4;
    }
    else if([modeString isEqualToString:@"Energization"]){
        cmd = 5;
    }
    else if([modeString isEqualToString:@"Soothing"]){
        cmd = 6;
    }
    else if([modeString isEqualToString:@"Concentration"]){
        cmd = 7;
    }
    else if([modeString isEqualToString:@"Sensuality"]){
        cmd = 8;
    }
    
    else if([modeString isEqualToString:@"2 Hours"]){
        cmd = 9;
    }
    else if([modeString isEqualToString:@"4 Hours"]){
        cmd = 10;
    }
    else if([modeString isEqualToString:@"8 Hours"]){
        cmd = 11;
    }
    else if([modeString isEqualToString:@"16 Hours"]){
        cmd = 12;
    }
    
    return cmd;
    
}

- (void)getWaterStatus{
    AppDelegate *application = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if(application.defaultBTServer.selectPeripheral.state == CBPeripheralStateConnected){
        NSMutableData* data = [NSMutableData data];
        
        NSUInteger query = 0xa1;
        [data appendBytes:&query length:1];
        NSUInteger imist = 0x0;
        [data appendBytes:&imist length:1];
        NSUInteger led = 0x0;
        [data appendBytes:&led length:1];
        NSUInteger color1 = 0x0;
        [data appendBytes:&color1 length:1];
        NSUInteger color2 = 0x0;
        [data appendBytes:&color2 length:1];
        NSUInteger color3 = 0x0;
        [data appendBytes:&color3 length:1];
        
        application.defaultBTServer.selectPeripheralInfo.curCmd = GET_WATER_STATUS;
        
        [application.defaultBTServer writeValue:[application.defaultBTServer converCMD:data] withCharacter:[application.defaultBTServer findCharacteristicFromUUID:[CBUUID UUIDWithString:WRITE_CHARACTERISTIC]]];
    }
}


- (void)dealloc {
    // 永远不要调用这个方法
}

@end