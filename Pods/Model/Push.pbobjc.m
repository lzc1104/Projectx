// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: Push.proto

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

 #import "Push.pbobjc.h"
 #import "CommonModel.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - PushRoot

@implementation PushRoot

// No extensions in the file and none of the imports (direct or indirect)
// defined extensions, so no need to generate +extensionRegistry.

@end

#pragma mark - PushRoot_FileDescriptor

static GPBFileDescriptor *PushRoot_FileDescriptor(void) {
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

#pragma mark - PBPushMessage

@implementation PBPushMessage

@dynamic messageId;
@dynamic type;
@dynamic deviceType;
@dynamic title;
@dynamic description_p;
@dynamic webURL;
@dynamic isOrderTime;
@dynamic timeToSend;
@dynamic externalMsgInfoArray, externalMsgInfoArray_Count;
@dynamic createDate;
@dynamic updateDate;
@dynamic result;
@dynamic coverImageURL;
@dynamic messageAction;
@dynamic groupId;
@dynamic aliasArray, aliasArray_Count;
@dynamic userAccount;
@dynamic timeToLive;

typedef struct PBPushMessage__storage_ {
  uint32_t _has_storage_[1];
  uint32_t messageId;
  uint32_t type;
  uint32_t deviceType;
  uint32_t result;
  uint32_t messageAction;
  uint32_t timeToLive;
  NSString *title;
  NSString *description_p;
  NSString *webURL;
  NSMutableArray *externalMsgInfoArray;
  NSString *coverImageURL;
  NSString *groupId;
  NSMutableArray *aliasArray;
  NSString *userAccount;
  uint64_t timeToSend;
  uint64_t createDate;
  uint64_t updateDate;
} PBPushMessage__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "messageId",
        .dataTypeSpecific.className = NULL,
        .number = PBPushMessage_FieldNumber_MessageId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(PBPushMessage__storage_, messageId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "type",
        .dataTypeSpecific.className = NULL,
        .number = PBPushMessage_FieldNumber_Type,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(PBPushMessage__storage_, type),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "deviceType",
        .dataTypeSpecific.className = NULL,
        .number = PBPushMessage_FieldNumber_DeviceType,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(PBPushMessage__storage_, deviceType),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "title",
        .dataTypeSpecific.className = NULL,
        .number = PBPushMessage_FieldNumber_Title,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(PBPushMessage__storage_, title),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "description_p",
        .dataTypeSpecific.className = NULL,
        .number = PBPushMessage_FieldNumber_Description_p,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(PBPushMessage__storage_, description_p),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "webURL",
        .dataTypeSpecific.className = NULL,
        .number = PBPushMessage_FieldNumber_WebURL,
        .hasIndex = 5,
        .offset = (uint32_t)offsetof(PBPushMessage__storage_, webURL),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "isOrderTime",
        .dataTypeSpecific.className = NULL,
        .number = PBPushMessage_FieldNumber_IsOrderTime,
        .hasIndex = 6,
        .offset = 7,  // Stored in _has_storage_ to save space.
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeBool,
      },
      {
        .name = "timeToSend",
        .dataTypeSpecific.className = NULL,
        .number = PBPushMessage_FieldNumber_TimeToSend,
        .hasIndex = 8,
        .offset = (uint32_t)offsetof(PBPushMessage__storage_, timeToSend),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "externalMsgInfoArray",
        .dataTypeSpecific.className = GPBStringifySymbol(PBExtraInfo),
        .number = PBPushMessage_FieldNumber_ExternalMsgInfoArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(PBPushMessage__storage_, externalMsgInfoArray),
        .flags = (GPBFieldFlags)(GPBFieldRepeated | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "createDate",
        .dataTypeSpecific.className = NULL,
        .number = PBPushMessage_FieldNumber_CreateDate,
        .hasIndex = 9,
        .offset = (uint32_t)offsetof(PBPushMessage__storage_, createDate),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "updateDate",
        .dataTypeSpecific.className = NULL,
        .number = PBPushMessage_FieldNumber_UpdateDate,
        .hasIndex = 10,
        .offset = (uint32_t)offsetof(PBPushMessage__storage_, updateDate),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "result",
        .dataTypeSpecific.className = NULL,
        .number = PBPushMessage_FieldNumber_Result,
        .hasIndex = 11,
        .offset = (uint32_t)offsetof(PBPushMessage__storage_, result),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "coverImageURL",
        .dataTypeSpecific.className = NULL,
        .number = PBPushMessage_FieldNumber_CoverImageURL,
        .hasIndex = 12,
        .offset = (uint32_t)offsetof(PBPushMessage__storage_, coverImageURL),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "messageAction",
        .dataTypeSpecific.className = NULL,
        .number = PBPushMessage_FieldNumber_MessageAction,
        .hasIndex = 13,
        .offset = (uint32_t)offsetof(PBPushMessage__storage_, messageAction),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "groupId",
        .dataTypeSpecific.className = NULL,
        .number = PBPushMessage_FieldNumber_GroupId,
        .hasIndex = 14,
        .offset = (uint32_t)offsetof(PBPushMessage__storage_, groupId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "aliasArray",
        .dataTypeSpecific.className = NULL,
        .number = PBPushMessage_FieldNumber_AliasArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(PBPushMessage__storage_, aliasArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "userAccount",
        .dataTypeSpecific.className = NULL,
        .number = PBPushMessage_FieldNumber_UserAccount,
        .hasIndex = 15,
        .offset = (uint32_t)offsetof(PBPushMessage__storage_, userAccount),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "timeToLive",
        .dataTypeSpecific.className = NULL,
        .number = PBPushMessage_FieldNumber_TimeToLive,
        .hasIndex = 16,
        .offset = (uint32_t)offsetof(PBPushMessage__storage_, timeToLive),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt32,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[PBPushMessage class]
                                     rootClass:[PushRoot class]
                                          file:PushRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(PBPushMessage__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\r\001\t\000\003\n\000\006\004!!\000\007\013\000\010\n\000\t\000externalMsgInfo\000\n\n\000\013"
        "\n\000\016\013!!\000\017\r\000\020\007\000\022\013\000\023\n\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - PBExtraInfo

@implementation PBExtraInfo

@dynamic key;
@dynamic value;

typedef struct PBExtraInfo__storage_ {
  uint32_t _has_storage_[1];
  NSString *key;
  NSString *value;
} PBExtraInfo__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "key",
        .dataTypeSpecific.className = NULL,
        .number = PBExtraInfo_FieldNumber_Key,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(PBExtraInfo__storage_, key),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "value",
        .dataTypeSpecific.className = NULL,
        .number = PBExtraInfo_FieldNumber_Value,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(PBExtraInfo__storage_, value),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[PBExtraInfo class]
                                     rootClass:[PushRoot class]
                                          file:PushRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(PBExtraInfo__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - PBPushMessageList

@implementation PBPushMessageList

@dynamic mesArray, mesArray_Count;
@dynamic hasPageInfo, pageInfo;

typedef struct PBPushMessageList__storage_ {
  uint32_t _has_storage_[1];
  NSMutableArray *mesArray;
  PBPageInfo *pageInfo;
} PBPushMessageList__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "mesArray",
        .dataTypeSpecific.className = GPBStringifySymbol(PBPushMessage),
        .number = PBPushMessageList_FieldNumber_MesArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(PBPushMessageList__storage_, mesArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "pageInfo",
        .dataTypeSpecific.className = GPBStringifySymbol(PBPageInfo),
        .number = PBPushMessageList_FieldNumber_PageInfo,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(PBPushMessageList__storage_, pageInfo),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[PBPushMessageList class]
                                     rootClass:[PushRoot class]
                                          file:PushRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(PBPushMessageList__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\001\004\010\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - PBPushMessageSearchListReq

@implementation PBPushMessageSearchListReq

@dynamic startDate;
@dynamic endDate;
@dynamic diviceType;
@dynamic hasPage, page;

typedef struct PBPushMessageSearchListReq__storage_ {
  uint32_t _has_storage_[1];
  uint32_t diviceType;
  PBPagePara *page;
  uint64_t startDate;
  uint64_t endDate;
} PBPushMessageSearchListReq__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "startDate",
        .dataTypeSpecific.className = NULL,
        .number = PBPushMessageSearchListReq_FieldNumber_StartDate,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(PBPushMessageSearchListReq__storage_, startDate),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "endDate",
        .dataTypeSpecific.className = NULL,
        .number = PBPushMessageSearchListReq_FieldNumber_EndDate,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(PBPushMessageSearchListReq__storage_, endDate),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "diviceType",
        .dataTypeSpecific.className = NULL,
        .number = PBPushMessageSearchListReq_FieldNumber_DiviceType,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(PBPushMessageSearchListReq__storage_, diviceType),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "page",
        .dataTypeSpecific.className = GPBStringifySymbol(PBPagePara),
        .number = PBPushMessageSearchListReq_FieldNumber_Page,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(PBPushMessageSearchListReq__storage_, page),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[PBPushMessageSearchListReq class]
                                     rootClass:[PushRoot class]
                                          file:PushRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(PBPushMessageSearchListReq__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\003\001\t\000\002\007\000\003\n\000";
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
