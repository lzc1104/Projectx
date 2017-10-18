// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: XError.proto

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

 #import "Xerror.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - XerrorRoot

@implementation XerrorRoot

// No extensions in the file and no imports, so no need to generate
// +extensionRegistry.

@end

#pragma mark - Enum PBXError

GPBEnumDescriptor *PBXError_EnumDescriptor(void) {
  static GPBEnumDescriptor *descriptor = NULL;
  if (!descriptor) {
    static const char *valueNames =
        "Success\000UserNotFound\000CardnoOrPwdNotCorre"
        "ct\000PwdNotCorrect\000";
    static const int32_t values[] = {
        PBXError_Success,
        PBXError_UserNotFound,
        PBXError_CardnoOrPwdNotCorrect,
        PBXError_PwdNotCorrect,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(PBXError)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:PBXError_IsValidValue];
    if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL PBXError_IsValidValue(int32_t value__) {
  switch (value__) {
    case PBXError_Success:
    case PBXError_UserNotFound:
    case PBXError_CardnoOrPwdNotCorrect:
    case PBXError_PwdNotCorrect:
      return YES;
    default:
      return NO;
  }
}


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)