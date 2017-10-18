// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: XBasicMessage.proto

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

 #import "XbasicMessage.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - XbasicMessageRoot

@implementation XbasicMessageRoot

// No extensions in the file and no imports, so no need to generate
// +extensionRegistry.

@end

#pragma mark - Enum PBXMessageType

GPBEnumDescriptor *PBXMessageType_EnumDescriptor(void) {
  static GPBEnumDescriptor *descriptor = NULL;
  if (!descriptor) {
    static const char *valueNames =
        "Default\000AppConfigGet\000UserLogin\000UserReset"
        "Pwd\000UserSync\000PortfolioGetList\000Transactio"
        "nGetList\000";
    static const int32_t values[] = {
        PBXMessageType_Default,
        PBXMessageType_AppConfigGet,
        PBXMessageType_UserLogin,
        PBXMessageType_UserResetPwd,
        PBXMessageType_UserSync,
        PBXMessageType_PortfolioGetList,
        PBXMessageType_TransactionGetList,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(PBXMessageType)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:PBXMessageType_IsValidValue];
    if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL PBXMessageType_IsValidValue(int32_t value__) {
  switch (value__) {
    case PBXMessageType_Default:
    case PBXMessageType_AppConfigGet:
    case PBXMessageType_UserLogin:
    case PBXMessageType_UserResetPwd:
    case PBXMessageType_UserSync:
    case PBXMessageType_PortfolioGetList:
    case PBXMessageType_TransactionGetList:
      return YES;
    default:
      return NO;
  }
}


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
