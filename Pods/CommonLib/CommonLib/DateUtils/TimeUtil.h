//
//  TimeUtil.h
//  01-工具类的封装
//
//  Created by frank on 16/1/13.
//  Copyright © 2016年 frank. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "TimeUtils.h"

@interface TimeUtil : NSObject

// Notice
// time: 时间戳（毫秒级，一般由服务器生成）

+ (NSString*)displayTimeWithTime:(long long)time
                        byFormat:(NSString*)format;
/*
 “创建于 xx/xx/xx”
 */
+(NSString*)groupCreateTime:(long long)time;

/*
 "YYYY/mm/dd"
 */
+(NSString*)userCreateTime:(long long)time;

/*
 "HH:mm"
 */
+(NSString*)feedCreateTime:(long long)time;
/*
 “YYYY-MM-dd ”
 */
+ (NSString*)completeTimeDash:(long long)time;
/*
 “YYYY-MM-dd hh:mm”
 */
+ (NSString*)completeTime:(long long)time;

/*
 “MM/dd hh:mm”
 */
+ (NSString*)completeMonthTime:(long long)time;

/*
 “YYYY-MM-dd hh:mm:ss”
 */
+ (NSString*)completeTimeToSecond:(long long)time;

/*
 “YYYY/MM/dd hh:mm”
 */
+ (NSString*)completeTimeWithBash:(long long)time;

/*
 “YYYY/MM/dd hh:mm”
 */
+ (NSString*)completeTimeWithDot:(long long)time;
/*
 “YYYY-MM-dd”
 */
+(NSString*)completeDate:(long long)time;

/*
 “刚刚,xx分钟前,xx小时前”
 */
+(NSString*)pastTimeStyle:(long long)time;
/**
 * “刚刚,xx分钟前,xx小时前,月:日”
 */
+ (NSString*)pastTimeStyleWithoutDay:(long long)time;
/**
 * “刚刚,xx分钟前,xx小时前,:天前, 月:日”
 */
+ (NSString*)pastTimeStyleWithoutDetail:(long long)time;
/*
 微信和qq的聊天里面的时间显示
 */
+(NSString*)twentyFourStyleDisplayTime:(long long)time;
// 与twentyFourStyleDisplayTime 相比, 这方法区别在当时间超出一周, 不再显示时间, 只显示日期
+(NSString*)twentyFourStyleTime:(long long)time;


/**
 今天HH:mm , 昨天 HH:mm , MM-DD ，YYYY-MM-DD

 @param time ms
 @return display str
 */
+ (NSString *)dayAndYesterdayDisplay:(long long)time;
/*
 “xx月xx日”
 */
+ (NSString*)monthAndDay:(long long)time;



/*
 “凌晨 xx, 晚上xx”
 */
+(NSString*) timeWithSectionStyle:(long long)time;

+(int)dayCountForMonth:(int)month andYear:(int)year;

+(BOOL)isLeapYear:(int)year;

+(long long)getTimeStampWithDateString:(NSString *)dateString;

@end
