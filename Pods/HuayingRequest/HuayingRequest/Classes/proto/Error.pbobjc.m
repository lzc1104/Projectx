// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: Error.proto

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

 #import "Error.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - ErrorRoot

@implementation ErrorRoot

// No extensions in the file and no imports, so no need to generate
// +extensionRegistry.

@end

#pragma mark - Enum PBError

GPBEnumDescriptor *PBError_EnumDescriptor(void) {
  static GPBEnumDescriptor *descriptor = NULL;
  if (!descriptor) {
    static const char *valueNames =
        "Success\000ReadPostData\000ParsePostData\000NoSer"
        "viceForType\000ServiceCatchException\000Unknow"
        "n\000IncorrectInputData\000ResponseServiceData"
        "Null\000ParseMessageDataException\000AppParseR"
        "esponseMessageNull\000AppClientCatchExcepti"
        "on\000AppNetworkError\000ValidateParameterErro"
        "r\000ValidateParameterException\000LimitTooBig"
        "\000ErrorInvalidSecurity\000OperationNotSuppor"
        "t\000DataEmptyException\000UserMobileExists\000Us"
        "erIncorrectPassword\000UserNotLoginYet\000User"
        "AccessTokenExpired\000UserAccessTokenInvali"
        "d\000KeyExists\000KeyNotExists\000ValueCanNotBeMo"
        "dified\000AdminNotFound\000AdminExist\000Feedback"
        "NotExists\000SendValidCodeError\000SendValidCo"
        "deTypeIncorrect\000LocationNotFound\000Locatio"
        "nGetRemoteAdcodeFailure\000LocationGetServe"
        "rVersionFailure\000LocationGetAllFailure\000Lo"
        "cationAdcodeNotDigits\000LocationCityNameNo"
        "tFound\000LocationCityIsHot\000LocationCityIsN"
        "otHot\000LocationCityIsOverLimit\000LocationDe"
        "tectNotFound\000LocationGetLngLatFailure\000";
    static const int32_t values[] = {
        PBError_Success,
        PBError_ReadPostData,
        PBError_ParsePostData,
        PBError_NoServiceForType,
        PBError_ServiceCatchException,
        PBError_Unknown,
        PBError_IncorrectInputData,
        PBError_ResponseServiceDataNull,
        PBError_ParseMessageDataException,
        PBError_AppParseResponseMessageNull,
        PBError_AppClientCatchException,
        PBError_AppNetworkError,
        PBError_ValidateParameterError,
        PBError_ValidateParameterException,
        PBError_LimitTooBig,
        PBError_ErrorInvalidSecurity,
        PBError_OperationNotSupport,
        PBError_DataEmptyException,
        PBError_UserMobileExists,
        PBError_UserIncorrectPassword,
        PBError_UserNotLoginYet,
        PBError_UserAccessTokenExpired,
        PBError_UserAccessTokenInvalid,
        PBError_KeyExists,
        PBError_KeyNotExists,
        PBError_ValueCanNotBeModified,
        PBError_AdminNotFound,
        PBError_AdminExist,
        PBError_FeedbackNotExists,
        PBError_SendValidCodeError,
        PBError_SendValidCodeTypeIncorrect,
        PBError_LocationNotFound,
        PBError_LocationGetRemoteAdcodeFailure,
        PBError_LocationGetServerVersionFailure,
        PBError_LocationGetAllFailure,
        PBError_LocationAdcodeNotDigits,
        PBError_LocationCityNameNotFound,
        PBError_LocationCityIsHot,
        PBError_LocationCityIsNotHot,
        PBError_LocationCityIsOverLimit,
        PBError_LocationDetectNotFound,
        PBError_LocationGetLngLatFailure,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(PBError)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:PBError_IsValidValue];
    if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL PBError_IsValidValue(int32_t value__) {
  switch (value__) {
    case PBError_Success:
    case PBError_ReadPostData:
    case PBError_ParsePostData:
    case PBError_NoServiceForType:
    case PBError_ServiceCatchException:
    case PBError_Unknown:
    case PBError_IncorrectInputData:
    case PBError_ResponseServiceDataNull:
    case PBError_ParseMessageDataException:
    case PBError_AppParseResponseMessageNull:
    case PBError_AppClientCatchException:
    case PBError_AppNetworkError:
    case PBError_ValidateParameterError:
    case PBError_ValidateParameterException:
    case PBError_LimitTooBig:
    case PBError_ErrorInvalidSecurity:
    case PBError_OperationNotSupport:
    case PBError_DataEmptyException:
    case PBError_UserMobileExists:
    case PBError_UserIncorrectPassword:
    case PBError_UserNotLoginYet:
    case PBError_UserAccessTokenExpired:
    case PBError_UserAccessTokenInvalid:
    case PBError_KeyExists:
    case PBError_KeyNotExists:
    case PBError_ValueCanNotBeModified:
    case PBError_AdminNotFound:
    case PBError_AdminExist:
    case PBError_FeedbackNotExists:
    case PBError_SendValidCodeError:
    case PBError_SendValidCodeTypeIncorrect:
    case PBError_LocationNotFound:
    case PBError_LocationGetRemoteAdcodeFailure:
    case PBError_LocationGetServerVersionFailure:
    case PBError_LocationGetAllFailure:
    case PBError_LocationAdcodeNotDigits:
    case PBError_LocationCityNameNotFound:
    case PBError_LocationCityIsHot:
    case PBError_LocationCityIsNotHot:
    case PBError_LocationCityIsOverLimit:
    case PBError_LocationDetectNotFound:
    case PBError_LocationGetLngLatFailure:
      return YES;
    default:
      return NO;
  }
}


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
