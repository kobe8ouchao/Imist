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
@property (assign,nonatomic)NSInteger intentAction;
@property (assign,nonatomic)NSInteger workingMode;
@property (strong,nonatomic)NSMutableDictionary *userset2Hour;
@property (strong,nonatomic)NSMutableDictionary *userset4Hour;
@property (strong,nonatomic)NSMutableDictionary *userset8Hour;
@property (strong,nonatomic)NSMutableDictionary *userset16Hour;
@property (nonatomic, assign) BOOL doNotShowHint_UserMode;
@property (nonatomic, assign) BOOL doNotShowHint_Relaxation;
@property (nonatomic, assign) BOOL doNotShowHint_Sleep;
@property (nonatomic, assign) BOOL doNotShowHint_Energization;
@property (nonatomic, assign) BOOL doNotShowHint_Soothing;
@property (nonatomic, assign) BOOL doNotShowHint_Concentration;
@property (nonatomic, assign) BOOL doNotShowHint_Sensuality;
@property (nonatomic, assign) BOOL diffuserWorkingState;
typedef enum{
    IDLE,
    GET_WATER_STATUS,
    GET_WORK_MODE,
    SET_WORK_MODE,
    INIT_SET_WORK_MODE,
    SHOW_HINT
}Cmd;
@end
