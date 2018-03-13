////
////  DeviceIdManager.m
////  WinTour
////
////  Created by Garen on 16/7/18.
////  Copyright © 2016年 huaying. All rights reserved.
////
//
//#import "DeviceIdManager.h"
//#import "UICKeyChainStore.h"
//
//@implementation DeviceIdManager
//IMPL_SINGLETON_FOR_CLASS(DeviceIdManager)
//
//- (NSString *)deviceId
//{
//    return [[NSUserDefaults standardUserDefaults] objectForKey:DEVICE_ID];
//}
//
//- (instancetype)init {
//    if (self = [super init]) {
//        [self setupDeviceId];
//    }
//    return self;
//}
//
//- (void)setupDeviceId {
//    
//    NSString *deviceID = [UICKeyChainStore stringForKey:DEVICE_ID_FROM_KEYCHAIN_REFERENCE_APP];
//    PPDebug(@"deviceID from Keychain = %@ ",deviceID);
//    
//    //device ID from keychain
//    if (deviceID) {
//        [[NSUserDefaults standardUserDefaults] setObject:deviceID forKey:DEVICE_ID];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        
//    } else if (deviceID == (id)[NSNull null] || deviceID.length == 0 ) {
//        
//        NSString *newDeviceId = [self deviceUUID];
//        [[NSUserDefaults standardUserDefaults] setObject:newDeviceId forKey:DEVICE_ID];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        [UICKeyChainStore setString:newDeviceId forKey:DEVICE_ID_FROM_KEYCHAIN_REFERENCE_APP  service:nil];
//        PPDebug(@"new deviceID = (%@)",newDeviceId);
//    }
//
//}
//
//- (NSString *)deviceUUID
//{
//    if([[NSUserDefaults standardUserDefaults] objectForKey:[[NSBundle mainBundle] bundleIdentifier]]) {
//        return [[NSUserDefaults standardUserDefaults] objectForKey:[[NSBundle mainBundle] bundleIdentifier]];
//    }
//    NSString *uuidString = [[NSUUID UUID] UUIDString];
//    [[NSUserDefaults standardUserDefaults] setObject:uuidString forKey:[[NSBundle mainBundle] bundleIdentifier]];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    return uuidString;
//}
//
//
//@end
