//
//  BTServer.m
//  DarkBlue
//
//  Created by chenee on 14-3-26.
//  Copyright (c) 2014年 chenee. All rights reserved.
//

#import "BTServer.h"

@interface BTServer()


@end


@implementation BTServer{
    BOOL inited;
    CBCentralManager *myCenter;
    //state
    NSInteger scanState;
    NSInteger connectState;
    NSInteger serviceState;
    NSInteger characteristicState;
    NSInteger readState;
    
    eventBlock connectBlock;
    UInt8 seed[5];

//    CBPeripheral *m_Peripheral;

}

static BTServer* _defaultBTServer = nil;
-(NSInteger)getScanState
{
    return scanState;
}
-(NSInteger)getConnectState
{
    return connectState;
}
-(NSInteger)getServiceState
{
    return serviceState;
}
-(NSInteger)getCharacteristicState
{
    return characteristicState;
}
-(NSInteger)getReadState
{
    return readState;
}


+(BTServer*)defaultBTServer
{
    if (nil == _defaultBTServer) {
        _defaultBTServer = [[BTServer alloc]init];
        
        [_defaultBTServer initBLE];
    }
    
    return _defaultBTServer;
}

-(void)initBLE
{
    if (inited) {
        return;
    }
    inited = TRUE;
    self.delegate = nil;
    self.discoveredPeripherals = [NSMutableArray array];
//    self.services = [NSMutableArray array];
    self.selectPeripheral = nil;
    connectState = KNOT;
    connectBlock = nil;
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], CBCentralManagerOptionShowPowerAlertKey, @"ImistRestoreIdentifier",CBCentralManagerOptionRestoreIdentifierKey,nil];

    myCenter = [[CBCentralManager alloc]
                           initWithDelegate:self
                           queue:dispatch_queue_create("com.oc.Imist", NULL)
                           options:options]; // TODO: options
    
    NSLog(@"init bt server ........");
    _responeData = [[NSMutableData alloc] init];
    _respPassword = [[NSMutableData alloc] init];
}
-(void)finishBLE
{
    //??
}

#pragma mark -- APIs
-(void)startScan
{
    [self startScan:10];
}
-(void)startScan:(NSInteger)forLastTime
{
    NSLog(@"ble server start scan.....");

    [self.discoveredPeripherals removeAllObjects];
    scanState = KING;
    
    //0:retrive
#if 1
    //method 1:
    NSArray *atmp = [NSArray arrayWithObjects:[CBUUID UUIDWithString:UUIDPrimaryService], nil];
    NSArray *retrivedArray = [myCenter retrieveConnectedPeripheralsWithServices:atmp];
    NSLog(@"retrivedArray:\n%@",retrivedArray);

    for (CBPeripheral* peripheral in retrivedArray) {
        [self addPeripheral:peripheral advertisementData:nil  RSSI:nil];
    }
    
    //method 2:
//    [myCenter retrieveConnectedPeripherals];//XXX: deprecated\ˈdɛprɪˌket\ but still work

#endif
    //1: scan
//    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], CBCentralManagerScanOptionAllowDuplicatesKey, nil];
//    [myCenter scanForPeripheralsWithServices:[NSArray arrayWithObject:[CBUUID UUIDWithString:@"0xFFA0"]]  options:options];
    [myCenter scanForPeripheralsWithServices:nil options:nil];

    
    if (forLastTime > 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(forLastTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self stopScan];
        });
//        [NSTimer scheduledTimerWithTimeInterval:forLastTime target:self selector:@selector(stopScan) userInfo:nil repeats:NO];
//        [NSObject cancelPreviousPerformRequestsWithTarget:self
//                                                 selector:@selector(stopScan)
//                                                   object:nil];
//        [self performSelector:@selector(stopScan)
//                   withObject:nil
//                   afterDelay:forLastTime];
    }
}
-(void)stopScan:(BOOL)withOutEvent
{

    if (scanState != KING) {
        return;
    }
    
    NSLog(@"stop scan ...");

    scanState = KSUCCESS;
    [myCenter stopScan];
    
    if(withOutEvent)
        return;
    
    if (self.delegate) {
        if([(id)self.delegate respondsToSelector:@selector(didStopScan)]){
            [self.delegate didStopScan];
        }
    }
}
-(void)stopScan
{
    [self stopScan:FALSE];
}
-(void)cancelConnect
{
    if (myCenter && self.selectPeripheral) {
        if(self.selectPeripheral.state == CBPeripheralStateConnecting){
            NSLog(@"timeout cancel connect to peripheral:%@",self.selectPeripheral.name);

            [myCenter cancelPeripheralConnection:self.selectPeripheral];
            connectState = KNOT;
        }
    }
}
-(void)connect:(PeriperalInfo *)peripheralInfo
{
    NSLog(@"connecting to peripheral:%@",peripheralInfo.peripheral.name);
    
    [myCenter connectPeripheral:peripheralInfo.peripheral options:@{CBConnectPeripheralOptionNotifyOnConnectionKey: @YES, CBConnectPeripheralOptionNotifyOnDisconnectionKey: @YES, CBConnectPeripheralOptionNotifyOnNotificationKey: @YES}];

    self.selectPeripheral = peripheralInfo.peripheral;
    self.selectPeripheralInfo = peripheralInfo;
    connectState = KING;
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(AUTO_CANCEL_CONNECT_TIMEOUT * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self cancelConnect];
//
//    });
//    [NSTimer scheduledTimerWithTimeInterval:AUTO_CANCEL_CONNECT_TIMEOUT target:self selector:@selector(cancelConnect) userInfo:nil repeats:NO];
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(cancelConnect)
                                               object:nil];
    [self performSelector:@selector(cancelConnect)
               withObject:nil
               afterDelay:AUTO_CANCEL_CONNECT_TIMEOUT];
}

-(void)connect:(PeriperalInfo *)peripheralInfo withFinishCB:(eventBlock)callback
{
    [self connect:peripheralInfo];
    connectBlock = callback;
}
-(void)disConnect
{
    if(myCenter && self.selectPeripheral){
        [myCenter cancelPeripheralConnection:self.selectPeripheral];
    }
}
-(void)discoverService:(CBService*)service
{
    if(self.selectPeripheral){
        characteristicState = KING;
        self.discoveredSevice = service;
        [self.selectPeripheral discoverCharacteristics:nil forService:service];
    }

}
-(void)readValue:(CBCharacteristic*)characteristic
{
    if (readState == KING) {
        NSLog(@"BTServer: should wait read over");
        return;
    }
    if (characteristic != nil) {
        self.selectCharacteristic = characteristic;
    }
    readState = KING;
    [self.selectPeripheral readValueForCharacteristic:self.selectCharacteristic];
}

-(void)writeValue:(NSData*) data withCharacter:(CBCharacteristic*)characteristic
{
    [self.selectPeripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
}

- (NSArray *)retrievePeripheralsWithIdentifiers:(NSArray *)identifiers {
    NSArray *result = [myCenter retrievePeripheralsWithIdentifiers:identifiers];
    //[self centralManager:myCenter didRetrievePeripherals:result];
    return result;
}

#pragma mark CBCentralManagerDelegate
-(void)addPeripheralInfo:(PeriperalInfo *)peripheralInfo
{
    for(int i=0;i<self.discoveredPeripherals.count;i++){
        PeriperalInfo *pi = self.discoveredPeripherals[i];
        
        if([peripheralInfo.uuid isEqualToString:pi.uuid]){
            [self.discoveredPeripherals replaceObjectAtIndex:i withObject:peripheralInfo];
            return;
        }
    }
    
    [self.discoveredPeripherals addObject:peripheralInfo];
    
    if (self.delegate) {
        if([(id)self.delegate respondsToSelector:@selector(didFoundPeripheral)]){
            [self.delegate didFoundPeripheral];
        }
    }
}
-(void)addPeripheral:(CBPeripheral*)peripheral advertisementData:(NSDictionary*)advertisementData RSSI:(NSNumber*)RSSI
{
    PeriperalInfo *pi = [[PeriperalInfo alloc]init];
    
    pi.peripheral = peripheral;
    pi.uuid = [peripheral.identifier UUIDString];
    pi.name = peripheral.name;
    switch (peripheral.state) {
        case CBPeripheralStateDisconnected:
            pi.state = @"disConnected";
            break;
        case CBPeripheralStateConnecting:
            pi.state = @"connecting";
            break;
        case CBPeripheralStateConnected:
            pi.state = @"connected";
            break;
        default:
            break;
    }
    //    pi.channel = advertisementData objectForKey:
    if (advertisementData) {
        pi.localName = [advertisementData objectForKey:CBAdvertisementDataLocalNameKey];
        NSArray *array = [advertisementData objectForKey:CBAdvertisementDataServiceUUIDsKey];
        pi.serviceUUIDS = [array componentsJoinedByString:@"; "];
        NSData *manuData = [advertisementData objectForKey:CBAdvertisementDataManufacturerDataKey];
        if([manuData length]>=8){
            NSRange macRange = {2,6};
            pi.macAddr = [manuData subdataWithRange:macRange];
        }
    }

    
    if (RSSI) {
        pi.RSSI = RSSI;
    }
    
    [self addPeripheralInfo:pi];
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    //NSLog(@"discover peripheral: %@; advertisementData: %@; RSSI: %@", peripheral, advertisementData, RSSI);
    if(([peripheral.name rangeOfString:@"Imist"].length > 0) || ([peripheral.name rangeOfString:@"IMIST"].length > 0)){
    //if ([peripheral.name containsString:@"Imist"] || [peripheral.name containsString:@"IMIST"]) {
        [self addPeripheral:peripheral advertisementData:advertisementData RSSI:RSSI];
    }
    
}
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"didconnect to peripheral: %@",peripheral.name);

    connectState = KSUCCESS;
//    if (connectBlock) {
//        connectBlock(peripheral,true,nil);
//        connectBlock = nil;
//    }
    
    self.selectPeripheralInfo.manualDisconnect = NO;
    self.selectPeripheral = peripheral;
    self.selectPeripheral.delegate = self;
    serviceState = KING;
    NSArray *sUUIDArray = [NSArray arrayWithObjects:[CBUUID UUIDWithString:UUIDPrimaryService], nil];
    [self.selectPeripheral discoverServices:sUUIDArray];
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"didDisConnected peripheral: %@",peripheral.name);

    connectState = KFAILED;
    if (connectBlock) {
        connectBlock(peripheral,false,nil);
        connectBlock = nil;
    }
    if (self.delegate) {
        if([(id)self.delegate respondsToSelector:@selector(didDisconnect)]){
            [self.delegate didDisconnect];
        }
    }
    
    UIApplication *app=[UIApplication sharedApplication];
    if (app.applicationState == UIApplicationStateBackground) {
        UIUserNotificationSettings *notifySettings=[[UIApplication sharedApplication] currentUserNotificationSettings];
        if ((notifySettings.types & UIUserNotificationTypeAlert)!=0) {
            UILocalNotification *notification=[UILocalNotification new];
            notification.alertBody=@"Diffuser Disconnected";
            [app presentLocalNotificationNow:notification];
        }
    }
    else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PERIPHERAL_DISCONNECT" object:nil];
    }
    
    if ([self.selectPeripheral.identifier.UUIDString isEqualToString:peripheral.identifier.UUIDString] && self.selectPeripheralInfo.manualDisconnect==NO) {
        NSLog(@"Retrying");
        [self connect:self.selectPeripheralInfo];
    }
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"DidFailToConnectPeripheral .....");
}

- (void)centralManager:(CBCentralManager *)central didRetrieveConnectedPeripherals:(NSArray *)peripherals
{
    NSLog(@"retrive connected peripheral %@",peripherals);
}

- (void)centralManager:(CBCentralManager *)central didRetrievePeripherals:(NSArray *)peripherals
{
    NSLog(@"retrive %@",peripherals);

}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    // Determine the state of the peripheral
    if ([central state] == CBCentralManagerStatePoweredOff) {
        NSLog(@"CoreBluetooth BLE hardware is powered off");
    }
    else if ([central state] == CBCentralManagerStatePoweredOn) {
        NSLog(@"CoreBluetooth BLE hardware is powered on and ready");
        [self startScan:10];
    }
    else if ([central state] == CBCentralManagerStateUnauthorized) {
        NSLog(@"CoreBluetooth BLE state is unauthorized");
    }
    else if ([central state] == CBCentralManagerStateUnknown) {
        NSLog(@"CoreBluetooth BLE state is unknown");
    }
    else if ([central state] == CBCentralManagerStateUnsupported) {
        NSLog(@"CoreBluetooth BLE hardware is unsupported on this platform");
    }

}

- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary *)dict
{
    NSLog(@"will restore ....");
}


#pragma mark CBPeripheralDelegate

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if (nil == error) {
        serviceState = KSUCCESS;
        NSLog(@"found services:\n%@",peripheral.services);
        for (CBService *service in peripheral.services) {
            NSLog(@"Service found with UUID: %@", service.UUID);
            if ([service.UUID isEqual:[CBUUID UUIDWithString:UUIDPrimaryService]]) {
                NSLog(@"Imist SERVICE FOUND");
                NSArray *cUUIDArray = [NSArray arrayWithObjects:
                                       [CBUUID UUIDWithString:CODE_TX_CHARACTERISTIC],
                                       [CBUUID UUIDWithString:CODE_RX_CHARACTERISTIC],
                                       [CBUUID UUIDWithString:WRITE_CHARACTERISTIC],
                                       [CBUUID UUIDWithString:NOTIFY_CHARACTERISTIC],
                                       nil];
                [peripheral discoverCharacteristics:cUUIDArray forService:service];
                break;
            }
        }
    }else{
        serviceState = KFAILED;
        NSLog(@"discover service failed:%@",error);
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverIncludedServicesForService:(CBService *)service error:(NSError *)error
{
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if (nil == error) {
        characteristicState = KSUCCESS;
        self.discoveredSevice = service;
        if([service.UUID isEqual:[CBUUID UUIDWithString:UUIDPrimaryService]]) {
            for (CBCharacteristic *characteristic in service.characteristics) {
                NSLog(@"discovered characteristic %@", characteristic.UUID);
                if([characteristic.UUID isEqual:[CBUUID UUIDWithString:WRITE_CHARACTERISTIC]]) {
                    NSLog(@"Found Write Characteristic %@", characteristic);
                    [self sendRandomSeed];
                }
                if([characteristic.UUID isEqual:[CBUUID UUIDWithString:NOTIFY_CHARACTERISTIC]]) {
                    [self.selectPeripheral setNotifyValue:YES forCharacteristic:characteristic];
                    NSLog(@"Found Notify Characteristic %@", characteristic);
                    if (connectBlock) {
                        connectBlock(peripheral,true,nil);
                        connectBlock = nil;
                    }

                }
            }
        }
    }else{
        characteristicState = KFAILED;
        self.discoveredSevice = nil;
        NSLog(@"discover characteristic failed:%@",error);
    }
    
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{

}


- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    
    if (error){
        readState = KFAILED;
        NSLog(@"Error updating value for characteristic %@ error: %@", characteristic.UUID, [error localizedDescription]);
        return;
    }
    readState = KSUCCESS;
    if([characteristic.UUID isEqual:[CBUUID UUIDWithString:NOTIFY_CHARACTERISTIC]]){
        BOOL isEnd = [self isTail:characteristic.value];
        [self.responeData appendData:characteristic.value];
        if (isEnd) {
            self.selectCharacteristic = characteristic;
            if (self.delegate && [(id)self.delegate respondsToSelector:@selector(didReadvalue:)]) {
                [self.delegate didReadvalue:self.responeData];
            }
            [self.responeData setLength:0];
        }
    }
    else{
        [self.respPassword appendData:characteristic.value];
        if([self.respPassword length]>= 5){
            if([self comparePassword:self.respPassword] == NO){
                //[self disConnect];
            }
            [self.respPassword setLength:0];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error
{
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{

}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error
{
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    
}

- (void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(NSError *)error
{
}

- (void)peripheralDidUpdateName:(CBPeripheral *)peripheral
{
    
}

- (void)peripheral:(CBPeripheral *)peripheral didModifyServices:(NSArray *)invalidatedServices
{
}

- (void) sendRandomSeed
{
    
    seed[0] =arc4random_uniform(250+1);
    seed[1] =arc4random_uniform(250+1);
    seed[2] =arc4random_uniform(250+1);
    seed[3] =arc4random_uniform(250+1);
    seed[4] =arc4random_uniform(250+1);

    
    NSData * seedNum = [NSData dataWithBytes:seed length:5];
    [self writeValue:seedNum withCharacter:[self findCharacteristicFromUUID:[CBUUID UUIDWithString:CODE_TX_CHARACTERISTIC]]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(200 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
        [self readPassword];
    });

}

- (void) readPassword
{
    [self readValue:[self findCharacteristicFromUUID:[CBUUID UUIDWithString:CODE_RX_CHARACTERISTIC]]];
}

- (BOOL) comparePassword:(NSData *) returnedPass
{
    UInt8 password_ret[5];
    const UInt8 * Mac = [self.selectPeripheralInfo.macAddr bytes];

    password_ret[0] = ((Mac[0] ^ seed[0]) / 11) ^ (seed[1] | seed[2]);
    password_ret[1] = ((Mac[2] + Mac[3] + seed[3]) * 35) ^ (seed[4] - Mac[5]) ;
    password_ret[2] = (password_ret[0] ^ Mac[3]);
    password_ret[3] = (password_ret[1] ^ Mac[4]);
    password_ret[4] = password_ret[0] + password_ret[1] + password_ret[2] + password_ret[3];
    
    UInt8 * mcuPass = [returnedPass bytes];
    for(UInt8 i = 0; i<5; i++)
    {
        if(password_ret[i] != mcuPass[i])
            return NO;
    }
    return YES;
}

-(NSData*)converCMD:(NSData*)cmd
{
    NSMutableData* data = [NSMutableData data];
    NSUInteger head1 = 0xAA;
    NSUInteger head2 = 0xBB;
    NSUInteger tail1 = 0xCC;
    NSUInteger tail2 = 0xDD;
    [data appendBytes:&head1 length:1];
    [data appendBytes:&head2 length:1];
    [data appendData:cmd];
    UInt8 bcc = 0;
    const char * arrData = [data bytes];
    for(UInt8 i = 0; i<[data length]; i++) {
       bcc =  arrData[i]^ bcc;
    }
    [data appendBytes:&bcc length:1];
    [data appendBytes:&tail1 length:1];
    [data appendBytes:&tail2 length:1];
    return data;
}

-(CBCharacteristic *) findCharacteristicFromUUID:(CBUUID *)UUID {
    for(int i=0; i < self.discoveredSevice.characteristics.count; i++) {
        CBCharacteristic *c = [self.discoveredSevice.characteristics objectAtIndex:i];
        if ([c.UUID isEqual:UUID]) {
            return c;
        }
    }
    return nil;
}

-(BOOL) isTail:(NSData *)data
{
    Byte *chunkByte = (Byte *)[data bytes];
    long length = [data length];
    for(long i = 0;i < length;i++) {
        if (chunkByte[i] == 0xdd) {
            return YES;
        }
    }
    return NO;
}


@end
