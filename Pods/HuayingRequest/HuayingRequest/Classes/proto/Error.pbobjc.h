// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: Error.proto

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

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Enum PBError

typedef GPB_ENUM(PBError) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  PBError_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  /** 成功 */
  PBError_Success = 0,

  /** 系统错误 */
  PBError_ReadPostData = 10001,

  /** 系统请求失败，解析POST数据出错 */
  PBError_ParsePostData = 10002,

  /** 系统请求失败，该接口未实现 */
  PBError_NoServiceForType = 10003,

  /** 系统请求失败，业务处理异常 */
  PBError_ServiceCatchException = 10004,

  /** 系统请求失败，未知错误 */
  PBError_Unknown = 10005,

  /** 系统请求失败，不正确的请求参数 */
  PBError_IncorrectInputData = 10008,

  /** 系统请求失败，响应消息业务数据处理异常 */
  PBError_ResponseServiceDataNull = 10009,

  /** 系统请求失败，解析消息的内容体异常 */
  PBError_ParseMessageDataException = 10010,

  /** 系统请求失败，客户端解析消息中的内容体异常 */
  PBError_AppParseResponseMessageNull = 10011,

  /** 客户端处理异常 */
  PBError_AppClientCatchException = 10012,

  /** 网络错误 */
  PBError_AppNetworkError = 10013,

  /** 校验请求参数错误 */
  PBError_ValidateParameterError = 10014,

  /** 校验请求参数异常 */
  PBError_ValidateParameterException = 10015,

  /** 请求数据数目超过最大数量 */
  PBError_LimitTooBig = 10016,

  /** 数据验证错误 */
  PBError_ErrorInvalidSecurity = 10018,

  /** 操作不支持 */
  PBError_OperationNotSupport = 10019,

  /** 提交数据空异常 */
  PBError_DataEmptyException = 10020,

  /** 用户 */
  PBError_UserMobileExists = 11002,

  /** 用户名或密码错误 */
  PBError_UserIncorrectPassword = 11005,

  /** 用户尚未登录，accessToken 为空时 */
  PBError_UserNotLoginYet = 11006,

  /** 长时间未使用 App，accessToken 已过期 */
  PBError_UserAccessTokenExpired = 11007,

  /** 异地登录，accessToken 校验失败，返回此错误码，此时消息体的内容为 PBUserLoginData */
  PBError_UserAccessTokenInvalid = 11008,

  /** 系统参数配置 */
  PBError_KeyExists = 15000,

  /** key不存在 */
  PBError_KeyNotExists = 15001,

  /** 配置不能被修改 */
  PBError_ValueCanNotBeModified = 15002,

  /** 管理员 */
  PBError_AdminNotFound = 16001,

  /** 管理员已存在 */
  PBError_AdminExist = 16002,

  /** 用户反馈 */
  PBError_FeedbackNotExists = 18001,

  /** 验证码 */
  PBError_SendValidCodeError = 19000,

  /** 发送验证码类型不正确 */
  PBError_SendValidCodeTypeIncorrect = 19001,

  /** LOCATION */
  PBError_LocationNotFound = 19500,

  /** 远程调用高德api获取adcode失败 */
  PBError_LocationGetRemoteAdcodeFailure = 19501,

  /** 获取服务器location版本失败 */
  PBError_LocationGetServerVersionFailure = 19502,

  /** redis 获取所有location数据失败 */
  PBError_LocationGetAllFailure = 19503,

  /** 地区行政编码不是数字 */
  PBError_LocationAdcodeNotDigits = 19504,

  /** 城市名未找到 */
  PBError_LocationCityNameNotFound = 19505,

  /** 城市已经是热门城市 */
  PBError_LocationCityIsHot = 19506,

  /** 城市已经不是热门城市 */
  PBError_LocationCityIsNotHot = 19507,

  /** 热门城市数量超过限制 */
  PBError_LocationCityIsOverLimit = 19508,

  /** 未找到对应定位城市 */
  PBError_LocationDetectNotFound = 19509,

  /** 获取经纬度失败 */
  PBError_LocationGetLngLatFailure = 19510,
};

GPBEnumDescriptor *PBError_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL PBError_IsValidValue(int32_t value);

#pragma mark - ErrorRoot

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
@interface ErrorRoot : GPBRootObject
@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
