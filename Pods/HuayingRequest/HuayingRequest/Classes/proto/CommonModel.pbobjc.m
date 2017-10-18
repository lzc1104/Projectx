// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: CommonModel.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers_RuntimeSupport.h>
#else
 #import "GPBProtocolBuffers_RuntimeSupport.h"
#endif

 #import "CommonModel.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - CommonModelRoot

@implementation CommonModelRoot

// No extensions in the file and no imports, so no need to generate
// +extensionRegistry.

@end

#pragma mark - CommonModelRoot_FileDescriptor

static GPBFileDescriptor *CommonModelRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPB_DEBUG_CHECK_RUNTIME_VERSIONS();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@"framework"
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - Enum PBDeviceType

GPBEnumDescriptor *PBDeviceType_EnumDescriptor(void) {
  static GPBEnumDescriptor *descriptor = NULL;
  if (!descriptor) {
    static const char *valueNames =
        "DeviceAndroid\000DeviceIos\000DevicePc\000";
    static const int32_t values[] = {
        PBDeviceType_DeviceAndroid,
        PBDeviceType_DeviceIos,
        PBDeviceType_DevicePc,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(PBDeviceType)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:PBDeviceType_IsValidValue];
    if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL PBDeviceType_IsValidValue(int32_t value__) {
  switch (value__) {
    case PBDeviceType_DeviceAndroid:
    case PBDeviceType_DeviceIos:
    case PBDeviceType_DevicePc:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - Enum PBNetworkType

GPBEnumDescriptor *PBNetworkType_EnumDescriptor(void) {
  static GPBEnumDescriptor *descriptor = NULL;
  if (!descriptor) {
    static const char *valueNames =
        "NetUnknown\000NetWifi\000Net2G\000Net3G\000Net4G\000";
    static const int32_t values[] = {
        PBNetworkType_NetUnknown,
        PBNetworkType_NetWifi,
        PBNetworkType_Net2G,
        PBNetworkType_Net3G,
        PBNetworkType_Net4G,
    };
    static const char *extraTextFormatInfo = "\003\002c\202\000\003c\202\000\004c\202\000";
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(PBNetworkType)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:PBNetworkType_IsValidValue
                              extraTextFormatInfo:extraTextFormatInfo];
    if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL PBNetworkType_IsValidValue(int32_t value__) {
  switch (value__) {
    case PBNetworkType_NetUnknown:
    case PBNetworkType_NetWifi:
    case PBNetworkType_Net2G:
    case PBNetworkType_Net3G:
    case PBNetworkType_Net4G:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - Enum PBPaymentChannel

GPBEnumDescriptor *PBPaymentChannel_EnumDescriptor(void) {
  static GPBEnumDescriptor *descriptor = NULL;
  if (!descriptor) {
    static const char *valueNames =
        "PayAli\000PayWechat\000PayAppstoreIap\000";
    static const int32_t values[] = {
        PBPaymentChannel_PayAli,
        PBPaymentChannel_PayWechat,
        PBPaymentChannel_PayAppstoreIap,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(PBPaymentChannel)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:PBPaymentChannel_IsValidValue];
    if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL PBPaymentChannel_IsValidValue(int32_t value__) {
  switch (value__) {
    case PBPaymentChannel_PayAli:
    case PBPaymentChannel_PayWechat:
    case PBPaymentChannel_PayAppstoreIap:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - Enum PBSex

GPBEnumDescriptor *PBSex_EnumDescriptor(void) {
  static GPBEnumDescriptor *descriptor = NULL;
  if (!descriptor) {
    static const char *valueNames =
        "SexNone\000SexMale\000SexFemale\000";
    static const int32_t values[] = {
        PBSex_SexNone,
        PBSex_SexMale,
        PBSex_SexFemale,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(PBSex)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:PBSex_IsValidValue];
    if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL PBSex_IsValidValue(int32_t value__) {
  switch (value__) {
    case PBSex_SexNone:
    case PBSex_SexMale:
    case PBSex_SexFemale:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - Enum PBBoolValue

GPBEnumDescriptor *PBBoolValue_EnumDescriptor(void) {
  static GPBEnumDescriptor *descriptor = NULL;
  if (!descriptor) {
    static const char *valueNames =
        "BoolNone\000BoolTrue\000BoolFalse\000";
    static const int32_t values[] = {
        PBBoolValue_BoolNone,
        PBBoolValue_BoolTrue,
        PBBoolValue_BoolFalse,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(PBBoolValue)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:PBBoolValue_IsValidValue];
    if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL PBBoolValue_IsValidValue(int32_t value__) {
  switch (value__) {
    case PBBoolValue_BoolNone:
    case PBBoolValue_BoolTrue:
    case PBBoolValue_BoolFalse:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - PBDeviceScreenSize

@implementation PBDeviceScreenSize

@dynamic width;
@dynamic height;

typedef struct PBDeviceScreenSize__storage_ {
  uint32_t _has_storage_[1];
  int32_t width;
  int32_t height;
} PBDeviceScreenSize__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "width",
        .dataTypeSpecific.className = NULL,
        .number = PBDeviceScreenSize_FieldNumber_Width,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(PBDeviceScreenSize__storage_, width),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt32,
      },
      {
        .name = "height",
        .dataTypeSpecific.className = NULL,
        .number = PBDeviceScreenSize_FieldNumber_Height,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(PBDeviceScreenSize__storage_, height),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt32,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[PBDeviceScreenSize class]
                                     rootClass:[CommonModelRoot class]
                                          file:CommonModelRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(PBDeviceScreenSize__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - PBDevice

@implementation PBDevice

@dynamic deviceOs;
@dynamic deviceModel;
@dynamic deviceId;
@dynamic deviceType;
@dynamic hasScreenSize, screenSize;

typedef struct PBDevice__storage_ {
  uint32_t _has_storage_[1];
  PBDeviceType deviceType;
  NSString *deviceOs;
  NSString *deviceModel;
  NSString *deviceId;
  PBDeviceScreenSize *screenSize;
} PBDevice__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "deviceOs",
        .dataTypeSpecific.className = NULL,
        .number = PBDevice_FieldNumber_DeviceOs,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(PBDevice__storage_, deviceOs),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "deviceModel",
        .dataTypeSpecific.className = NULL,
        .number = PBDevice_FieldNumber_DeviceModel,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(PBDevice__storage_, deviceModel),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "deviceId",
        .dataTypeSpecific.className = NULL,
        .number = PBDevice_FieldNumber_DeviceId,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(PBDevice__storage_, deviceId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "deviceType",
        .dataTypeSpecific.enumDescFunc = PBDeviceType_EnumDescriptor,
        .number = PBDevice_FieldNumber_DeviceType,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(PBDevice__storage_, deviceType),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom | GPBFieldHasEnumDescriptor),
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "screenSize",
        .dataTypeSpecific.className = GPBStringifySymbol(PBDeviceScreenSize),
        .number = PBDevice_FieldNumber_ScreenSize,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(PBDevice__storage_, screenSize),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[PBDevice class]
                                     rootClass:[CommonModelRoot class]
                                          file:CommonModelRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(PBDevice__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\005\001\010\000\002\013\000\003\010\000\004\n\000\005\n\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t PBDevice_DeviceType_RawValue(PBDevice *message) {
  GPBDescriptor *descriptor = [PBDevice descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:PBDevice_FieldNumber_DeviceType];
  return GPBGetMessageInt32Field(message, field);
}

void SetPBDevice_DeviceType_RawValue(PBDevice *message, int32_t value) {
  GPBDescriptor *descriptor = [PBDevice descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:PBDevice_FieldNumber_DeviceType];
  GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}

#pragma mark - PBNetwork

@implementation PBNetwork

@dynamic type;

typedef struct PBNetwork__storage_ {
  uint32_t _has_storage_[1];
  PBNetworkType type;
} PBNetwork__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "type",
        .dataTypeSpecific.enumDescFunc = PBNetworkType_EnumDescriptor,
        .number = PBNetwork_FieldNumber_Type,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(PBNetwork__storage_, type),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldHasEnumDescriptor),
        .dataType = GPBDataTypeEnum,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[PBNetwork class]
                                     rootClass:[CommonModelRoot class]
                                          file:CommonModelRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(PBNetwork__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t PBNetwork_Type_RawValue(PBNetwork *message) {
  GPBDescriptor *descriptor = [PBNetwork descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:PBNetwork_FieldNumber_Type];
  return GPBGetMessageInt32Field(message, field);
}

void SetPBNetwork_Type_RawValue(PBNetwork *message, int32_t value) {
  GPBDescriptor *descriptor = [PBNetwork descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:PBNetwork_FieldNumber_Type];
  GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}

#pragma mark - PBPagePara

@implementation PBPagePara

@dynamic offset;
@dynamic limit;

typedef struct PBPagePara__storage_ {
  uint32_t _has_storage_[1];
  uint32_t offset;
  uint32_t limit;
} PBPagePara__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "offset",
        .dataTypeSpecific.className = NULL,
        .number = PBPagePara_FieldNumber_Offset,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(PBPagePara__storage_, offset),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "limit",
        .dataTypeSpecific.className = NULL,
        .number = PBPagePara_FieldNumber_Limit,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(PBPagePara__storage_, limit),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeUInt32,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[PBPagePara class]
                                     rootClass:[CommonModelRoot class]
                                          file:CommonModelRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(PBPagePara__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - PBPageInfo

@implementation PBPageInfo

@dynamic total;
@dynamic pageOffset;
@dynamic pageSize;
@dynamic filterCount;

typedef struct PBPageInfo__storage_ {
  uint32_t _has_storage_[1];
  uint32_t total;
  uint32_t pageOffset;
  uint32_t pageSize;
  uint32_t filterCount;
} PBPageInfo__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "total",
        .dataTypeSpecific.className = NULL,
        .number = PBPageInfo_FieldNumber_Total,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(PBPageInfo__storage_, total),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "pageOffset",
        .dataTypeSpecific.className = NULL,
        .number = PBPageInfo_FieldNumber_PageOffset,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(PBPageInfo__storage_, pageOffset),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "pageSize",
        .dataTypeSpecific.className = NULL,
        .number = PBPageInfo_FieldNumber_PageSize,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(PBPageInfo__storage_, pageSize),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "filterCount",
        .dataTypeSpecific.className = NULL,
        .number = PBPageInfo_FieldNumber_FilterCount,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(PBPageInfo__storage_, filterCount),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt32,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[PBPageInfo class]
                                     rootClass:[CommonModelRoot class]
                                          file:CommonModelRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(PBPageInfo__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\003\002\n\000\003\010\000\004\013\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - PBIntValue

@implementation PBIntValue

@dynamic value;

typedef struct PBIntValue__storage_ {
  uint32_t _has_storage_[1];
  uint32_t value;
} PBIntValue__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "value",
        .dataTypeSpecific.className = NULL,
        .number = PBIntValue_FieldNumber_Value,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(PBIntValue__storage_, value),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeUInt32,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[PBIntValue class]
                                     rootClass:[CommonModelRoot class]
                                          file:CommonModelRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(PBIntValue__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - PBLongValue

@implementation PBLongValue

@dynamic value;

typedef struct PBLongValue__storage_ {
  uint32_t _has_storage_[1];
  uint64_t value;
} PBLongValue__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "value",
        .dataTypeSpecific.className = NULL,
        .number = PBLongValue_FieldNumber_Value,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(PBLongValue__storage_, value),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeUInt64,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[PBLongValue class]
                                     rootClass:[CommonModelRoot class]
                                          file:CommonModelRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(PBLongValue__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - PBStrValue

@implementation PBStrValue

@dynamic value;

typedef struct PBStrValue__storage_ {
  uint32_t _has_storage_[1];
  NSString *value;
} PBStrValue__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "value",
        .dataTypeSpecific.className = NULL,
        .number = PBStrValue_FieldNumber_Value,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(PBStrValue__storage_, value),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[PBStrValue class]
                                     rootClass:[CommonModelRoot class]
                                          file:CommonModelRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(PBStrValue__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - PBKeyValue

@implementation PBKeyValue

@dynamic key;
@dynamic value;

typedef struct PBKeyValue__storage_ {
  uint32_t _has_storage_[1];
  NSString *key;
  NSString *value;
} PBKeyValue__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "key",
        .dataTypeSpecific.className = NULL,
        .number = PBKeyValue_FieldNumber_Key,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(PBKeyValue__storage_, key),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "value",
        .dataTypeSpecific.className = NULL,
        .number = PBKeyValue_FieldNumber_Value,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(PBKeyValue__storage_, value),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[PBKeyValue class]
                                     rootClass:[CommonModelRoot class]
                                          file:CommonModelRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(PBKeyValue__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - PBKeyValueList

@implementation PBKeyValueList

@dynamic kvArray, kvArray_Count;

typedef struct PBKeyValueList__storage_ {
  uint32_t _has_storage_[1];
  NSMutableArray *kvArray;
} PBKeyValueList__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "kvArray",
        .dataTypeSpecific.className = GPBStringifySymbol(PBKeyValue),
        .number = PBKeyValueList_FieldNumber_KvArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(PBKeyValueList__storage_, kvArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[PBKeyValueList class]
                                     rootClass:[CommonModelRoot class]
                                          file:CommonModelRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(PBKeyValueList__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - PBValidCodeReq

@implementation PBValidCodeReq

@dynamic mobileCode;
@dynamic mobile;
@dynamic validCodeType;

typedef struct PBValidCodeReq__storage_ {
  uint32_t _has_storage_[1];
  uint32_t validCodeType;
  NSString *mobileCode;
  NSString *mobile;
} PBValidCodeReq__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "mobileCode",
        .dataTypeSpecific.className = NULL,
        .number = PBValidCodeReq_FieldNumber_MobileCode,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(PBValidCodeReq__storage_, mobileCode),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "mobile",
        .dataTypeSpecific.className = NULL,
        .number = PBValidCodeReq_FieldNumber_Mobile,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(PBValidCodeReq__storage_, mobile),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "validCodeType",
        .dataTypeSpecific.className = NULL,
        .number = PBValidCodeReq_FieldNumber_ValidCodeType,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(PBValidCodeReq__storage_, validCodeType),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt32,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[PBValidCodeReq class]
                                     rootClass:[CommonModelRoot class]
                                          file:CommonModelRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(PBValidCodeReq__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\002\001\n\000\003\r\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - PBUserLoginData

@implementation PBUserLoginData

@dynamic userId;
@dynamic userName;
@dynamic hasLastLoginDevice, lastLoginDevice;
@dynamic lastLoginClientIp;
@dynamic lastLoginLocation;
@dynamic lastLoginDate;

typedef struct PBUserLoginData__storage_ {
  uint32_t _has_storage_[1];
  NSString *userId;
  NSString *userName;
  PBDevice *lastLoginDevice;
  NSString *lastLoginClientIp;
  NSString *lastLoginLocation;
  uint64_t lastLoginDate;
} PBUserLoginData__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "userId",
        .dataTypeSpecific.className = NULL,
        .number = PBUserLoginData_FieldNumber_UserId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(PBUserLoginData__storage_, userId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "userName",
        .dataTypeSpecific.className = NULL,
        .number = PBUserLoginData_FieldNumber_UserName,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(PBUserLoginData__storage_, userName),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "lastLoginDevice",
        .dataTypeSpecific.className = GPBStringifySymbol(PBDevice),
        .number = PBUserLoginData_FieldNumber_LastLoginDevice,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(PBUserLoginData__storage_, lastLoginDevice),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "lastLoginClientIp",
        .dataTypeSpecific.className = NULL,
        .number = PBUserLoginData_FieldNumber_LastLoginClientIp,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(PBUserLoginData__storage_, lastLoginClientIp),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "lastLoginLocation",
        .dataTypeSpecific.className = NULL,
        .number = PBUserLoginData_FieldNumber_LastLoginLocation,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(PBUserLoginData__storage_, lastLoginLocation),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "lastLoginDate",
        .dataTypeSpecific.className = NULL,
        .number = PBUserLoginData_FieldNumber_LastLoginDate,
        .hasIndex = 5,
        .offset = (uint32_t)offsetof(PBUserLoginData__storage_, lastLoginDate),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt64,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[PBUserLoginData class]
                                     rootClass:[CommonModelRoot class]
                                          file:CommonModelRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(PBUserLoginData__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\006\001\006\000\002\010\000\003\017\000\004\021\000\005\021\000\006\r\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
