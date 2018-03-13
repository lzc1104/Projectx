//
//  TimeUtil.m
//  01-工具类的封装
//
//  Created by frank on 16/1/13.
//  Copyright © 2016年 frank. All rights reserved.
//

#import "TimeUtil.h"

@implementation TimeUtil

+ (NSString*)displayTimeWithTime:(long long)time
                        byFormat:(NSString*)format
{
    time = time /1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:format];
    NSString *ret = [dateFormatter stringFromDate:date];
    return ret;
}

+ (NSString*)getTimeStr:(long) createdAt
{
    // Calculate distance time string
    
    NSString *timestamp;
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now, createdAt);
    if (distance < 0) distance = 0;
    
    if (distance < 60) {
        timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "second ago" : "seconds ago"];
    }
    else if (distance < 60 * 60) {
        distance = distance / 60;
        timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "minute ago" : "minutes ago"];
    }
    else if (distance < 60 * 60 * 24) {
        distance = distance / 60 / 60;
        timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "hour ago" : "hours ago"];
    }
    else if (distance < 60 * 60 * 24 * 7) {
        distance = distance / 60 / 60 / 24;
        timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "day ago" : "days ago"];
    }
    else if (distance < 60 * 60 * 24 * 7 * 4) {
        distance = distance / 60 / 60 / 24 / 7;
        timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "week ago" : "weeks ago"];
    }
    else {
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterShortStyle];
            [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        }
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt];
        timestamp = [dateFormatter stringFromDate:date];
    }
    return timestamp;
}
+ (NSString*)completeTimeDash:(long long)time {
    return [TimeUtil displayTimeWithTime:time
                                byFormat:@"YYYY-MM-dd"];
}
+ (NSString*)completeTime:(long long)time
{
    return [TimeUtil displayTimeWithTime:time
                                byFormat:@"YYYY-MM-dd HH:mm"];
}

+ (NSString*)completeTimeToSecond:(long long)time {
   return [TimeUtil displayTimeWithTime:time
                               byFormat:@"YYYY-MM-dd HH:mm:ss"];
}

+ (NSString*)completeMonthTime:(long long)time {
    return [TimeUtil displayTimeWithTime:time
                                byFormat:@"MM/dd HH:mm"];
}
+ (NSString*)completeTimeWithBash:(long long)time {
    
    return [TimeUtil displayTimeWithTime:time
                                byFormat:@"YYYY/MM/dd HH:mm"];
}
+ (NSString*)completeDate:(long long)time
{
    return [TimeUtil displayTimeWithTime:time
                                byFormat:@"YYYY-MM-dd"];
}
+ (NSString*)completeTimeWithDot:(long long)time {
    return [TimeUtil displayTimeWithTime:time byFormat:@"YYYY.MM.dd"];
}
+ (NSString*)monthAndDay:(long long)time
{
    return [TimeUtil displayTimeWithTime:time byFormat:@"MM月dd日"];
}

+ (NSDateComponents*)getComponentByDate:(NSDate*)date
{
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |   NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekOfYear | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    return component;
}


+ (NSString*)pastTimeStyle:(long long)time
{
    time = time /1000;
    
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateComponents* component=[TimeUtil getComponentByDate:date];
    NSInteger year=[component year];
    NSInteger month=[component month];
    NSInteger day=[component day];
    NSInteger hour=[component hour];
    NSInteger minute=[component minute];
    
    NSDate * today=[NSDate date];
    NSDateComponents* t_component=[TimeUtil getComponentByDate:today];
    NSInteger t_year=[t_component year];
    
    NSString*string=nil;
    
    long long now=[today timeIntervalSince1970];
    long long distance=now-time;
    
    if(distance<60)
        string=@"刚刚";
    else if(distance<60*60)
        string=[NSString stringWithFormat:@"%lld分钟前",distance/60];
    else if(distance<60*60*24)
        string=[NSString stringWithFormat:@"%lld小时前",distance/60/60];
    else if(distance<60*60*24*7)
        string=[NSString stringWithFormat:@"%lld天前",distance/60/60/24];
    else if(year==t_year)
        string=[NSString stringWithFormat:@"%02ld-%02ld %ld:%02ld",month,day,hour,minute];
    else
        string=[NSString stringWithFormat:@"%ld/%ld/%ld",year,month,day];
    
    return string;
    
}
+ (NSString*)pastTimeStyleWithoutDetail:(long long)time
{
    time = time /1000;
    
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateComponents* component=[TimeUtil getComponentByDate:date];
    NSInteger year=[component year];
    NSInteger month=[component month];
    NSInteger day=[component day];
    
    NSDate * today=[NSDate date];
    NSDateComponents* t_component=[TimeUtil getComponentByDate:today];
    NSInteger t_year=[t_component year];
    
    NSString*string=nil;
    
    long long now=[today timeIntervalSince1970];
    long long distance=now-time;
    
    if(distance<60)
        string=@"刚刚";
    else if(distance<60*60)
        string=[NSString stringWithFormat:@"%lld分钟前",distance/60];
    else if(distance<60*60*24)
        string=[NSString stringWithFormat:@"%lld小时前",distance/60/60];
    else if(distance<60*60*24*7)
        string=[NSString stringWithFormat:@"%lld天前",distance/60/60/24];
    else if(year==t_year)
        string=[NSString stringWithFormat:@"%02ld-%02ld",month,day];
    else
        string=[NSString stringWithFormat:@"%ld/%ld/%ld",year,month,day];
    
    return string;
    
}
+ (NSString*)pastTimeStyleWithoutDay:(long long)time
{
    time = time /1000;
    
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateComponents* component=[TimeUtil getComponentByDate:date];
    NSInteger year=[component year];
    NSInteger month=[component month];
    NSInteger day=[component day];
    
    NSDate * today=[NSDate date];
    NSDateComponents* t_component=[TimeUtil getComponentByDate:today];
    NSInteger __attribute((unused)) t_year=[t_component year];
    
    NSString*string=nil;
    
    long long now=[today timeIntervalSince1970];
    long long distance=now-time;
    
    if(distance<60)
        string=@"刚刚";
    else if(distance<60*60)
        string=[NSString stringWithFormat:@"%lld分钟前",distance/60];
    else if(distance<60*60*24)
        string=[NSString stringWithFormat:@"%lld小时前",distance/60/60];
    else
        string=[NSString stringWithFormat:@"%ld-%ld-%ld",year,month,day];
    
    return string;
    
}
+(NSString*) timeWithSectionStyle:(long long)time
{
    time = time/1000;
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateComponents* component=[TimeUtil getComponentByDate:date];
    NSInteger year=[component year];
    NSInteger month=[component month];
    NSInteger day=[component day];
    NSInteger hour=[component hour];
    NSInteger minute=[component minute];
    NSInteger week=[component weekOfYear];
    NSInteger weekday=[component weekday];
    
    NSDate * today=[NSDate date];
    NSDateComponents* t_component=[TimeUtil getComponentByDate:today];
    NSInteger t_year=[t_component year];
    NSInteger t_month=[t_component month];
    NSInteger t_day=[t_component day];
    NSInteger t_week=[t_component weekOfYear];
    
    NSString*string=nil;
    if(year==t_year && month==t_month && day==t_day)
    {
        if(hour<6&&hour>=0)
            string=[NSString stringWithFormat:@"凌晨 %ld:%02ld",hour,minute];
        else if(hour>=6&&hour<12)
            string=[NSString stringWithFormat:@"上午 %ld:%02ld",hour,minute];
        else if(hour>=12&&hour<18)
            string=[NSString stringWithFormat:@"下午 %ld:%02ld",hour,minute];
        else
            string=[NSString stringWithFormat:@"晚上 %ld:%02ld",hour,minute];
    }
    else if(year==t_year && week==t_week)
    {
        NSString * daystr=nil;
        switch (weekday) {
            case 1:
                daystr=@"日";
                break;
            case 2:
                daystr=@"一";
                break;
            case 3:
                daystr=@"二";
                break;
            case 4:
                daystr=@"三";
                break;
            case 5:
                daystr=@"四";
                break;
            case 6:
                daystr=@"五";
                break;
            case 7:
                daystr=@"六";
                break;
            default:
                break;
        }
        string=[NSString stringWithFormat:@"周%@ %ld:%02ld",daystr,hour,minute];
    }
    else if(year==t_year)
        string=[NSString stringWithFormat:@"%ld月%ld日",month,day];
    else
        string=[NSString stringWithFormat:@"%ld年%ld月%ld日",year,month,day];
    
    return string;
}


+(NSString*)twentyFourStyleDisplayTime:(long long)time
{    
    time = time /1000;
    
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateComponents* component = [TimeUtil getComponentByDate:date];
    NSInteger year = [component year];
    NSInteger month = [component month];
    NSInteger week = [component weekOfYear];
    NSInteger weekday = [component weekday];
    NSInteger day = [component day];
    NSInteger hour = [component hour];
    NSInteger minute = [component minute];

    NSDate * today = [NSDate date];
    NSDateComponents* t_component = [TimeUtil getComponentByDate:today];
    NSInteger t_year = [t_component year];
    NSInteger t_week = [t_component weekOfYear];
    NSInteger t_weekDay = [t_component weekday];
    
    NSString* ret = nil;
    // 公共部分，小时和分钟
    if (minute<10) {
        ret = [NSString stringWithFormat:@"%d:0%d",(int)hour,(int)minute];
    } else {
        ret = [NSString stringWithFormat:@"%d:%d",(int)hour,(int)minute];
    }

    // (最短)当天的消息，没有前缀
    if(year == t_year && week == t_week && weekday == t_weekDay)
        ;// 当天
    else if ((year == t_year && week == t_week && t_weekDay - weekday == 1)/*同一周隔一天*/
             || (year == t_year && t_week - week == 1 && t_weekDay == 1) /*周日和上周六*/) {
        // 昨天
        ret = [NSString stringWithFormat:@"%@ %@",@"昨天",ret];
    } else if(year == t_year && week == t_week){
        // 日期相隔超过一天且一周内
        NSString* weekDayStr;
        switch (weekday) {
            case 1: weekDayStr = @"星期日";
                break;
            case 2: weekDayStr = @"星期一";
                break;
            case 3: weekDayStr = @"星期二";
                break;
            case 4: weekDayStr = @"星期三";
                break;
            case 5: weekDayStr = @"星期四";
                break;
            case 6: weekDayStr = @"星期五";
                break;
            case 7: weekDayStr = @"星期六";
                break;
            default:
                break;
        }
        ret = [NSString stringWithFormat:@"%@ %@",weekDayStr, ret];
    } else if(year == t_year && week != t_week){
        ret = [NSString stringWithFormat:@"%d月%d日 %@",(int)month,(int)day,ret];
    } else {
        // 其他年份，全部时间信息显示
        ret = [NSString stringWithFormat:@"%d年%d月%d日 %@",(int)year,(int)month,(int)day,ret];
    }
    
    return ret;
}

// 与twentyFourStyleDisplayTime 相比, 这方法区别在当时间超出一周, 不再显示时间, 只显示日期
+(NSString*)twentyFourStyleTime:(long long)time
{
    time = time /1000;
    
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateComponents* component = [TimeUtil getComponentByDate:date];
    NSInteger year = [component year];
    NSInteger month = [component month];
    NSInteger week = [component weekOfYear];
    NSInteger weekday = [component weekday];
    NSInteger day = [component day];
    NSInteger hour = [component hour];
    NSInteger minute = [component minute];
    
    NSDate * today = [NSDate date];
    NSDateComponents* t_component = [TimeUtil getComponentByDate:today];
    NSInteger t_year = [t_component year];
    NSInteger t_week = [t_component weekOfYear];
    NSInteger t_weekDay = [t_component weekday];
    
    NSString* ret = nil;
    // 公共部分，小时和分钟
    if (minute<10) {
        ret = [NSString stringWithFormat:@"%d:0%d",(int)hour,(int)minute];
    } else {
        ret = [NSString stringWithFormat:@"%d:%d",(int)hour,(int)minute];
    }
    
    // (最短)当天的消息，没有前缀
    if(year == t_year && week == t_week && weekday == t_weekDay)
        ;// 当天
    else if ((year == t_year && week == t_week && t_weekDay - weekday == 1)/*同一周隔一天*/
             || (year == t_year && t_week - week == 1 && t_weekDay == 1) /*周日和上周六*/) {
        // 昨天
        ret = [NSString stringWithFormat:@"%@ %@",@"昨天",ret];
    } else if(year == t_year && week == t_week){
        // 日期相隔超过一天且一周内
        NSString* weekDayStr;
        switch (weekday) {
            case 1: weekDayStr = @"星期日";
                break;
            case 2: weekDayStr = @"星期一";
                break;
            case 3: weekDayStr = @"星期二";
                break;
            case 4: weekDayStr = @"星期三";
                break;
            case 5: weekDayStr = @"星期四";
                break;
            case 6: weekDayStr = @"星期五";
                break;
            case 7: weekDayStr = @"星期六";
                break;
            default:
                break;
        }
        ret = [NSString stringWithFormat:@"%@ %@",weekDayStr, ret];
    } else if(year == t_year && week != t_week){
        ret = [NSString stringWithFormat:@"%d月%d日",(int)month,(int)day];
    } else {
        // 其他年份，全部时间信息显示
        ret = [NSString stringWithFormat:@"%d年%d月%d日",(int)year,(int)month,(int)day];
    }
    
    return ret;
}

+ (NSString *)dayAndYesterdayDisplay:(long long)time {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    time = time / 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSCalendarUnit cUnit = NSCalendarUnitDay | NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *targeComp = [calendar components:cUnit   fromDate:date];
    
    BOOL isYesetday = [calendar isDateInYesterday:date];
    BOOL isToday = [calendar isDateInToday:date];
    BOOL isThisYear = [targeComp year] == [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    if (!isThisYear) {
        formatter.dateFormat = @"YYYY-MM-dd";
        return [formatter stringFromDate:date];
    }
    
    
    if (isYesetday) {
        formatter.dateFormat = @"昨天 HH:mm";
        return [formatter stringFromDate:date];
    }
    
    if (isToday) {
        formatter.dateFormat = @"今天 HH:mm";
        return [formatter stringFromDate:date];
    }
    
    //!isYesetday && !isToday
    formatter.dateFormat = @"MM-dd HH:mm";
    return [formatter stringFromDate:date];
    
    
}


+(int)dayCountForMonth:(int)month andYear:(int)year
{
    if (month==1||month==3||month==5||month==7||month==8||month==10||month==12) {
        return 31;
    }else if(month==4||month==6||month==9||month==11){
        return 30;
    }else if([self isLeapYear:year]){
        return 29;
    }else{
        return 28;
    }
}

+(BOOL)isLeapYear:(int)year
{
    if (year%400==0) {
        return YES;
    }else{
        if (year%4==0&&year%100!=0) {
            return YES;
        }else{
            return NO;
        }
    }
}


+(NSString*) groupCreateTime:(long long)time
{
    return [TimeUtil displayTimeWithTime:time
                                byFormat:@"创建于 YY/MM/dd"];
}

+(NSString*) userCreateTime:(long long)time
{
    return [TimeUtil displayTimeWithTime:time
                                byFormat:@"YYYY/MM/dd"];
}

+(NSString*)feedCreateTime:(long long)time
{
    return [TimeUtil displayTimeWithTime:time
                                byFormat:@"HH:mm"];
}

//dateString为 20160223164501 这种格式
+ (long long)getTimeStampWithDateString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return [date timeIntervalSince1970];
}


@end
