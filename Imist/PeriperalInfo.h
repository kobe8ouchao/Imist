//
//  PeriperalInfo.h
//  DarkBlue
//
//  Created by chenee on 14-3-26.
//  Copyright (c) 2014年 chenee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface PeriperalInfo : NSObject
@property (strong,nonatomic)CBPeripheral* peripheral;

@property (strong,nonatomic)NSString* uuid;
@property (strong,nonatomic)NSString* name;
@property (strong,nonatomic)NSString* state;

//advertisement
@property (strong,nonatomic)NSString* channel;
@property (strong,nonatomic)NSString* isConnectable;
@property (strong,nonatomic)NSString* localName;

@property (strong,nonatomic)NSString* manufactureData;
@property (strong,nonatomic)NSString* serviceUUIDS;
//rssi
@property (strong,nonatomic)NSNumber *RSSI;
//property
@property (strong,nonatomic)NSNumber *water;
@property (strong,nonatomic)NSString *mode;
@property (strong,nonatomic)NSNumber *ledcolor;
@property (strong,nonatomic)NSNumber *ledlight;
@property (strong,nonatomic)NSNumber *ledauto;
@property (strong,nonatomic)NSNumber *imist;
@property (strong,nonatomic)NSMutableArray *alert;
@property (assign,nonatomic)NSInteger curCmd;

typedef enum{
    GET_WATER_STATUS,
    GET_WORK_MODE,
    SET_WORK_MODE,
}currentCmd;

@end
