// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: BasicMessage.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers.h>
#else
 #import "GPBProtocolBuffers.h"
#endif

#if GOOGLE_PROTOBUF_OBJC_VERSION < 30002
#error This file was generated by a newer version of protoc which is incompatible with your Protocol Buffer library sources.
#endif
#if 30002 < GOOGLE_PROTOBUF_OBJC_MIN_SUPPORTED_VERSION
#error This file was generated by an older version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

CF_EXTERN_C_BEGIN

GPB_ENUM_FWD_DECLARE(PBDeviceType);
GPB_ENUM_FWD_DECLARE(PBNetwork);

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Enum PBMessageType

/** 通用消息定义在 0-9999 之间 */
typedef GPB_ENUM(PBMessageType) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  PBMessageType_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  PBMessageType_Default = 0,

  /** 系统配置 */
  PBMessageType_BasicConfigGet = 1,

  /** 增加系统参数， PBSystemParaConfig -> PBSystemParaConfig */
  PBMessageType_SystemParaAdd = 2,

  /** 更新系统参数, PBSystemParaConfig -> PBSystemParaConfig */
  PBMessageType_SystemParaUpdate = 3,

  /** 获取系统参数， void -> PBSystemParaConfigList */
  PBMessageType_SystemParaGetList = 4,

  /** 获取某个参数， PBStrValue -> PBSystemParaConfig */
  PBMessageType_SystemParaGetOne = 5,

  /** 获取某个参数，没有则返回默认值，PBSystemParaReq -> PBSystemParaConfig */
  PBMessageType_SystemParaGetOneDefault = 6,

  /** 用户相关接口 */
  PBMessageType_UserSendValidCode = 21,

  /** 用户反馈 */
  PBMessageType_FeedbackAdd = 31,

  /** 获取反馈列表，PBGetUserFeedBackListReq -> PBUserFeedbackList */
  PBMessageType_FeedbackGetList = 32,

  /** 删除反馈, PBIntValue -> void */
  PBMessageType_FeedbackDelete = 33,

  /** 更新反馈，PBUserFeedback(feedbackId & remark & required) -> PBUserFeedback */
  PBMessageType_FeedbackUpdate = 34,

  /** 后台管理员 */
  PBMessageType_AdminLogin = 41,

  /** 新增管理员用户，PBAdmin(realName, mobile, password & roles required) --> PBAdmin */
  PBMessageType_AdminAdd = 42,

  /** 获取管理员列表，PBGetAdminListReq --> PBAdminList */
  PBMessageType_AdminGetList = 43,

  /** 重置管理员密码，PBResetAdminPasswordReq --> PBAdmin */
  PBMessageType_AdminResetPassword = 44,

  /** 修改管理员信息，PBAdmin(adminId, realName, mobile, roles & locked required) --> PBAdmin */
  PBMessageType_AdminUpdate = 45,

  /** 后台管理员操作日志 */
  PBMessageType_AdminLogGetList = 51,

  /** 位置区域相关 */
  PBMessageType_LocationGetAll = 61,

  /** 根据经纬度查询对应的Location数据, PBLocationDetectReq -> PBLocation */
  PBMessageType_LocationDetect = 62,

  /** 得到所有省份 */
  PBMessageType_LocationGetProvince = 64,

  /** 根据省份得到所有市 */
  PBMessageType_LocationGetCityByProvince = 65,

  /** 根据市得到区县 */
  PBMessageType_LocationGetDistrictByCity = 66,

  /** 根据id 得到Location */
  PBMessageType_LocationGetById = 67,
};

GPBEnumDescriptor *PBMessageType_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL PBMessageType_IsValidValue(int32_t value);

#pragma mark - BasicMessageRoot

/**
 * Exposes the extension registry for this file.
 *
 * The base class provides:
 * @code
 *   + (GPBExtensionRegistry *)extensionRegistry;
 * @endcode
 * which is a @c GPBExtensionRegistry that includes all the extensions defined by
 * this file and all files that it depends on.
 **/
@interface BasicMessageRoot : GPBRootObject
@end

#pragma mark - PBMessageRequest

typedef GPB_ENUM(PBMessageRequest_FieldNumber) {
  PBMessageRequest_FieldNumber_Encrypt = 1,
  PBMessageRequest_FieldNumber_Compress = 2,
  PBMessageRequest_FieldNumber_Type = 3,
  PBMessageRequest_FieldNumber_MessageData = 4,
  PBMessageRequest_FieldNumber_RequestId = 5,
  PBMessageRequest_FieldNumber_Version = 6,
  PBMessageRequest_FieldNumber_TimeStamp = 7,
  PBMessageRequest_FieldNumber_DeviceOs = 8,
  PBMessageRequest_FieldNumber_DeviceModel = 9,
  PBMessageRequest_FieldNumber_DeviceId = 10,
  PBMessageRequest_FieldNumber_DeviceType = 11,
  PBMessageRequest_FieldNumber_AppVersion = 12,
  PBMessageRequest_FieldNumber_AppKey = 13,
  PBMessageRequest_FieldNumber_Token = 14,
  PBMessageRequest_FieldNumber_Signature = 15,
  PBMessageRequest_FieldNumber_AdminId = 16,
  PBMessageRequest_FieldNumber_Network = 18,
};

/**
 * 消息请求包
 **/
@interface PBMessageRequest : GPBMessage

/** 数据是否加密 */
@property(nonatomic, readwrite) BOOL encrypt;

/** 数据是否压缩 */
@property(nonatomic, readwrite) BOOL compress;

/** 消息类型 */
@property(nonatomic, readwrite) uint32_t type;

/** 请求数据 */
@property(nonatomic, readwrite, copy, null_resettable) NSData *messageData;

/** 请求 ID */
@property(nonatomic, readwrite) uint64_t requestId;

/** 消息接口版本 */
@property(nonatomic, readwrite) uint32_t version;

/** 客户端时间戳 */
@property(nonatomic, readwrite) uint64_t timeStamp;

/** 设备操作系统 */
@property(nonatomic, readwrite) uint32_t deviceOs;

/** 设备模型 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *deviceModel;

/** 设备ID */
@property(nonatomic, readwrite, copy, null_resettable) NSString *deviceId;

/** 设备类型，参考PBDeviceType */
@property(nonatomic, readwrite) enum PBDeviceType deviceType;

/** 应用程序版本号 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *appVersion;

/** 客户端APP KEY，各个客户端不同，用于加密 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *appKey;

/** 用户TOKEN，暂无用 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *token;

/** 数据签名，用于防伪，暂无用 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *signature;

/** 管理员 ID */
@property(nonatomic, readwrite) uint32_t adminId;

/** 网络类型，参考PBNetwork */
@property(nonatomic, readwrite) enum PBNetwork network;

@end

/**
 * Fetches the raw value of a @c PBMessageRequest's @c deviceType property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t PBMessageRequest_DeviceType_RawValue(PBMessageRequest *message);
/**
 * Sets the raw value of an @c PBMessageRequest's @c deviceType property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetPBMessageRequest_DeviceType_RawValue(PBMessageRequest *message, int32_t value);

/**
 * Fetches the raw value of a @c PBMessageRequest's @c network property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t PBMessageRequest_Network_RawValue(PBMessageRequest *message);
/**
 * Sets the raw value of an @c PBMessageRequest's @c network property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetPBMessageRequest_Network_RawValue(PBMessageRequest *message, int32_t value);

#pragma mark - PBMessageResponse

typedef GPB_ENUM(PBMessageResponse_FieldNumber) {
  PBMessageResponse_FieldNumber_Encrypt = 1,
  PBMessageResponse_FieldNumber_Compress = 2,
  PBMessageResponse_FieldNumber_Type = 3,
  PBMessageResponse_FieldNumber_MessageData = 4,
  PBMessageResponse_FieldNumber_RequestId = 5,
  PBMessageResponse_FieldNumber_ResultCode = 6,
  PBMessageResponse_FieldNumber_ResultInfo = 7,
  PBMessageResponse_FieldNumber_AppKey = 8,
};

/**
 * 消息响应包
 **/
@interface PBMessageResponse : GPBMessage

/** 返回数据是否加密 */
@property(nonatomic, readwrite) BOOL encrypt;

/** 返回数据是否压缩 */
@property(nonatomic, readwrite) BOOL compress;

/** 消息类型 */
@property(nonatomic, readwrite) uint32_t type;

/** 返回数据 */
@property(nonatomic, readwrite, copy, null_resettable) NSData *messageData;

/** 客户端APP KEY，各个客户端不同，用于加密 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *appKey;

/** 返回的ID，和请求ID一致 */
@property(nonatomic, readwrite) uint64_t requestId;

/** 返回的结果码 (PBError) */
@property(nonatomic, readwrite) uint32_t resultCode;

/** 返回的结果消息提示文本（一般用于错误提示） */
@property(nonatomic, readwrite, copy, null_resettable) NSString *resultInfo;

@end

#pragma mark - PBValidCodeReq

typedef GPB_ENUM(PBValidCodeReq_FieldNumber) {
  PBValidCodeReq_FieldNumber_MobileCode = 1,
  PBValidCodeReq_FieldNumber_Mobile = 2,
  PBValidCodeReq_FieldNumber_ValidCodeType = 3,
};

@interface PBValidCodeReq : GPBMessage

/** 国际电话区号，默认为 86，可选 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *mobileCode;

/** 手机号 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *mobile;

/** 验证码类型 */
@property(nonatomic, readwrite) uint32_t validCodeType;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)