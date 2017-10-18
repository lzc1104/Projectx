// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: Config.proto

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

@class PBAndroidVersion;
@class PBDynamicURLConfig;
@class PBIOSVersion;
@class PBLocation;
@class PBQiniuTokenHost;
@class PBShareConfig;
@class PBSocialAppConfig;
@class PBSystemParaConfig;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Enum PBSmsProvider

typedef GPB_ENUM(PBSmsProvider) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  PBSmsProvider_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  /** ihuyi */
  PBSmsProvider_Ihuyi = 0,

  /** jianzhou */
  PBSmsProvider_Jianzhou = 1,
};

GPBEnumDescriptor *PBSmsProvider_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL PBSmsProvider_IsValidValue(int32_t value);

#pragma mark - ConfigRoot

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
@interface ConfigRoot : GPBRootObject
@end

#pragma mark - PBBasicConfig

typedef GPB_ENUM(PBBasicConfig_FieldNumber) {
  PBBasicConfig_FieldNumber_IosSplash = 1,
  PBBasicConfig_FieldNumber_AndroidSplash = 2,
  PBBasicConfig_FieldNumber_IosVersion = 3,
  PBBasicConfig_FieldNumber_AndroidVersion = 4,
  PBBasicConfig_FieldNumber_Copyright = 5,
  PBBasicConfig_FieldNumber_ShareConfig = 10,
  PBBasicConfig_FieldNumber_URLConfig = 11,
  PBBasicConfig_FieldNumber_SocialConfig = 12,
  PBBasicConfig_FieldNumber_QiniuHostTokensArray = 13,
  PBBasicConfig_FieldNumber_HTTPDnsAccount = 14,
  PBBasicConfig_FieldNumber_BusinessConfig = 30,
};

@interface PBBasicConfig : GPBMessage

/** 通用的字段 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *iosSplash;

/** Android 闪屏 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *androidSplash;

/** iOS 版本信息 */
@property(nonatomic, readwrite, strong, null_resettable) PBIOSVersion *iosVersion;
/** Test to see if @c iosVersion has been set. */
@property(nonatomic, readwrite) BOOL hasIosVersion;

/** Android 版本信息 */
@property(nonatomic, readwrite, strong, null_resettable) PBAndroidVersion *androidVersion;
/** Test to see if @c androidVersion has been set. */
@property(nonatomic, readwrite) BOOL hasAndroidVersion;

/** 版权所有 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *copyright;

/** 分享相关设置 */
@property(nonatomic, readwrite, strong, null_resettable) PBShareConfig *shareConfig;
/** Test to see if @c shareConfig has been set. */
@property(nonatomic, readwrite) BOOL hasShareConfig;

/** 动态页面URL配置 */
@property(nonatomic, readwrite, strong, null_resettable) PBDynamicURLConfig *URLConfig;
/** Test to see if @c URLConfig has been set. */
@property(nonatomic, readwrite) BOOL hasURLConfig;

/** 社交App相关配置 */
@property(nonatomic, readwrite, strong, null_resettable) PBSocialAppConfig *socialConfig;
/** Test to see if @c socialConfig has been set. */
@property(nonatomic, readwrite) BOOL hasSocialConfig;

/** 七牛 Host token */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<PBQiniuTokenHost*> *qiniuHostTokensArray;
/** The number of items in @c qiniuHostTokensArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger qiniuHostTokensArray_Count;

/** httpDns account */
@property(nonatomic, readwrite, copy, null_resettable) NSString *HTTPDnsAccount;

/** 具体的业务配置 */
@property(nonatomic, readwrite, copy, null_resettable) NSData *businessConfig;

@end

#pragma mark - PBDynamicURLConfig

typedef GPB_ENUM(PBDynamicURLConfig_FieldNumber) {
  PBDynamicURLConfig_FieldNumber_OfficialWebsite = 1,
  PBDynamicURLConfig_FieldNumber_UserAgreementURL = 2,
  PBDynamicURLConfig_FieldNumber_WeexServerURL = 3,
  PBDynamicURLConfig_FieldNumber_OfficialMobileWebsite = 4,
};

@interface PBDynamicURLConfig : GPBMessage

/** APP配置 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *officialWebsite;

/** APP用户协议 URL */
@property(nonatomic, readwrite, copy, null_resettable) NSString *userAgreementURL;

/** APP中Weex页面的服务器地址,用于内置weex服务,如业余足球的赛事榜单 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *weexServerURL;

/** APP移动官网地址 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *officialMobileWebsite;

@end

#pragma mark - PBSocialAppConfig

typedef GPB_ENUM(PBSocialAppConfig_FieldNumber) {
  PBSocialAppConfig_FieldNumber_WechatAppKey = 1,
  PBSocialAppConfig_FieldNumber_WechatAppSecret = 2,
  PBSocialAppConfig_FieldNumber_WechatPublicAccount = 3,
  PBSocialAppConfig_FieldNumber_QqAppKey = 11,
  PBSocialAppConfig_FieldNumber_QqAppSecret = 12,
  PBSocialAppConfig_FieldNumber_QqGroupNumber = 13,
};

@interface PBSocialAppConfig : GPBMessage

/** 微信设置 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *wechatAppKey;

@property(nonatomic, readwrite, copy, null_resettable) NSString *wechatAppSecret;

/** 微信公众号 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *wechatPublicAccount;

/** QQ设置 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *qqAppKey;

@property(nonatomic, readwrite, copy, null_resettable) NSString *qqAppSecret;

/** QQ群号码 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *qqGroupNumber;

@end

#pragma mark - PBQiniuTokenHost

typedef GPB_ENUM(PBQiniuTokenHost_FieldNumber) {
  PBQiniuTokenHost_FieldNumber_Token = 1,
  PBQiniuTokenHost_FieldNumber_Host = 2,
  PBQiniuTokenHost_FieldNumber_Tag = 3,
};

@interface PBQiniuTokenHost : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *token;

@property(nonatomic, readwrite, copy, null_resettable) NSString *host;

@property(nonatomic, readwrite) uint32_t tag;

@end

#pragma mark - PBShareConfig

typedef GPB_ENUM(PBShareConfig_FieldNumber) {
  PBShareConfig_FieldNumber_AppShareURL = 1,
  PBShareConfig_FieldNumber_AppShareTitle = 2,
  PBShareConfig_FieldNumber_AppShareDescription = 3,
  PBShareConfig_FieldNumber_AppLogoURL = 4,
};

@interface PBShareConfig : GPBMessage

/** APP 分享 URL */
@property(nonatomic, readwrite, copy, null_resettable) NSString *appShareURL;

/** APP 分享标题 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *appShareTitle;

/** APP 分享描述 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *appShareDescription;

/** APP LOGO URL */
@property(nonatomic, readwrite, copy, null_resettable) NSString *appLogoURL;

@end

#pragma mark - PBIOSVersion

typedef GPB_ENUM(PBIOSVersion_FieldNumber) {
  PBIOSVersion_FieldNumber_ReviewVersion = 1,
  PBIOSVersion_FieldNumber_LatestVersion = 2,
  PBIOSVersion_FieldNumber_URL = 3,
  PBIOSVersion_FieldNumber_ForceVersionsArray = 4,
  PBIOSVersion_FieldNumber_Title = 5,
  PBIOSVersion_FieldNumber_ContentsArray = 6,
};

@interface PBIOSVersion : GPBMessage

/** 正在审核版本 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *reviewVersion;

/** 最新版本 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *latestVersion;

/** 更新版本URL */
@property(nonatomic, readwrite, copy, null_resettable) NSString *URL;

/** 强制更新的版本号 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *forceVersionsArray;
/** The number of items in @c forceVersionsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger forceVersionsArray_Count;

/** 更新的提示语 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *title;

/** 更新内容 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *contentsArray;
/** The number of items in @c contentsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger contentsArray_Count;

@end

#pragma mark - PBAndroidVersion

typedef GPB_ENUM(PBAndroidVersion_FieldNumber) {
  PBAndroidVersion_FieldNumber_VersionCode = 1,
  PBAndroidVersion_FieldNumber_VersionName = 2,
  PBAndroidVersion_FieldNumber_URL = 3,
  PBAndroidVersion_FieldNumber_Md5 = 4,
  PBAndroidVersion_FieldNumber_Title = 5,
  PBAndroidVersion_FieldNumber_ContentsArray = 6,
  PBAndroidVersion_FieldNumber_ForceVersionsArray = 7,
};

@interface PBAndroidVersion : GPBMessage

/** 最新版本 */
@property(nonatomic, readwrite) uint32_t versionCode;

/** 最新版本名 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *versionName;

/** apk url */
@property(nonatomic, readwrite, copy, null_resettable) NSString *URL;

/** apk md5 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *md5;

/** 更新的提示语 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *title;

/** 更新内容 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *contentsArray;
/** The number of items in @c contentsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger contentsArray_Count;

/** 强制更新的版本号 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *forceVersionsArray;
/** The number of items in @c forceVersionsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger forceVersionsArray_Count;

@end

#pragma mark - PBLocationConfig

typedef GPB_ENUM(PBLocationConfig_FieldNumber) {
  PBLocationConfig_FieldNumber_HotCitiesArray = 1,
  PBLocationConfig_FieldNumber_OthersArray = 2,
};

/**
 * 地区配置数据
 **/
@interface PBLocationConfig : GPBMessage

/** 热门城市 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<PBLocation*> *hotCitiesArray;
/** The number of items in @c hotCitiesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger hotCitiesArray_Count;

/** 其他地区 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<PBLocation*> *othersArray;
/** The number of items in @c othersArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger othersArray_Count;

@end

#pragma mark - PBSystemParaConfig

typedef GPB_ENUM(PBSystemParaConfig_FieldNumber) {
  PBSystemParaConfig_FieldNumber_Key = 1,
  PBSystemParaConfig_FieldNumber_Value = 2,
  PBSystemParaConfig_FieldNumber_Desc = 3,
  PBSystemParaConfig_FieldNumber_CreateTime = 4,
  PBSystemParaConfig_FieldNumber_ModifyTime = 5,
};

@interface PBSystemParaConfig : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *key;

@property(nonatomic, readwrite, copy, null_resettable) NSString *value;

@property(nonatomic, readwrite, copy, null_resettable) NSString *desc;

@property(nonatomic, readwrite) uint64_t createTime;

@property(nonatomic, readwrite) uint64_t modifyTime;

@end

#pragma mark - PBSystemParaConfigList

typedef GPB_ENUM(PBSystemParaConfigList_FieldNumber) {
  PBSystemParaConfigList_FieldNumber_ConfigsArray = 1,
};

@interface PBSystemParaConfigList : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<PBSystemParaConfig*> *configsArray;
/** The number of items in @c configsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger configsArray_Count;

@end

#pragma mark - PBSystemParaReq

typedef GPB_ENUM(PBSystemParaReq_FieldNumber) {
  PBSystemParaReq_FieldNumber_Key = 1,
  PBSystemParaReq_FieldNumber_DefaultValue = 2,
};

@interface PBSystemParaReq : GPBMessage

/** 参数的键 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *key;

/** 如果系统参数不存在，则取默认值 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *defaultValue;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)