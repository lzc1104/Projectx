//
//  StringUtil.m
//  WhereTimeGoes
//
//  Created by qqn_pipi on 09-10-10.
//  Copyright 2009 QQN-PIPI.com. All rights reserved.
//

#import "StringUtil.h"

#import "pinyin.h"
//#import "NSArray+BlocksKit.h"
//#import "privateLib.h"
#import "zlib.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
NSString* pinyinStringFirstLetter(unsigned short hanzi)
{
	char c = pinyinFirstLetter(hanzi);
	return [NSString stringWithFormat:@"%c", c];
}

BOOL NSStringIsValidEmail(NSString *checkString)
{
	BOOL sticterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
	
	NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
	NSString *emailRegex = sticterFilter ? stricterFilterString : laxString;
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	return [emailTest evaluateWithObject:checkString];
}
 //  判断手机号码是否正确，只是判断是否是数字
BOOL NSStringIsValidPhone(NSString *checkString)
{
	NSString *regex = @"[\\+0-9]+";
	NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
	return [test evaluateWithObject:checkString];
}
//  使用正则表达式判断手机号码是否正确
BOOL NSStringIsValidMobile(NSString *checkString)
{
    /**
     * 手机号码
     * 移动：134,135,136,137,138,139,150,151,152,157,158,159,182,187,188
     * 联通：130,131,132,155,156,185,186
     * 电信：133,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    if (([regextestmobile evaluateWithObject:checkString] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

NSString *NSStringFormFloat64Value(Float64 value) {
    return [NSString stringWithFormat:@"%lf",value];
}

NSString *NSStringZeroFormatFromFloat64(Float64 origin,Float64 pricise) {
    
    double delta = origin - (NSInteger )origin;
    if (pricise == 0 || pricise > 0.1) pricise = 0.00001;
    if (delta < pricise && delta > -pricise) {
        origin = (NSInteger)origin;
        return NSStringFromNSInteger((NSInteger )origin);
    } else {
        return [NSString stringWithFormat:@"%.2f",origin];
    }
}




BOOL NSStringIsValidChinese(NSString *checkString)
{
	NSString* regex = @"[\u4e00-\u9fa5]+";
	NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
	return [test evaluateWithObject:checkString];
}


BOOL NSStringISValidEnglish(NSString* checkString)
{
    NSString* regex = @"[[A-Za-z]]+";
	NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
	return [test evaluateWithObject:checkString];
}


@implementation NSString (NSStringUtil)

- (NSString *)stringByRepeateTime:(int)count{
    if (self == nil || count < 1) {
        return nil;
    }
    
    NSString *temp = self;
    NSString *ret = self;
    for (int i = 0; i < count - 1; i++) {
        ret = [ret stringByAppendingString:temp];
    }
    
    return ret;
}

- (NSString *)pinyinFirstLetter
{
	if ([self length] > 0){
		return pinyinStringFirstLetter([self characterAtIndex:0]);
	}
	else {
		return @"";
	}
}

+ (NSString *)stringWithInt:(int)value
{
	return [NSString stringWithFormat:@"%d", value];
}

+ (NSString *)GetUUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    NSString* retStr = (__bridge_transfer NSString *)string;
    return [[retStr stringByReplacingOccurrencesOfString:@"-" withString:@""] lowercaseString];
}


+(NSString *)getCurrentTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

// filter " ", "+", "(", ")", "-"
- (NSString *)phoneNumberFilter
{
	NSString* str = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
	str = [str stringByReplacingOccurrencesOfString:@"+" withString:@""];
	str = [str stringByReplacingOccurrencesOfString:@"(" withString:@""];
	str = [str stringByReplacingOccurrencesOfString:@")" withString:@""];
	str = [str stringByReplacingOccurrencesOfString:@"-" withString:@""];	
	return str;
}

- (NSString *)phoneNumberFilter2
{
	// performance can be improved later
	NSString* str = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
	str = [str stringByReplacingOccurrencesOfString:@"(" withString:@""];
	str = [str stringByReplacingOccurrencesOfString:@")" withString:@""];
	str = [str stringByReplacingOccurrencesOfString:@"-" withString:@""];	
	return str;
}

- (NSNumber *)toNumber
{
	return [NSNumber numberWithInt:[self intValue]];
}



- (NSArray *)emailStringToArray
{	
	NSString* str = [NSString stringWithString:self];
	
	// remove space and line break
	str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
	str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
		   
	// return by ; or , or space
	NSCharacterSet* charSet = [NSCharacterSet characterSetWithCharactersInString:@",; "];
	NSArray* emailArray = [str componentsSeparatedByCharactersInSet:charSet];
	
	NSMutableArray* retArray = [[NSMutableArray alloc] init];
	for (NSString* str in emailArray){
		NSString* email = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		if (email && [email length] > 0){
			[retArray addObject:email];
		}
	}
	
	return retArray;
}

- (NSString *)stringByURLEncode
{
	NSMutableString* escaped = [NSMutableString stringWithString:[self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];       
	[escaped replaceOccurrencesOfString:@"+" withString:@"%2B" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//	[escaped replaceOccurrencesOfString:@"&" withString:@"%26" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//	[escaped replaceOccurrencesOfString:@"," withString:@"%2C" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//	[escaped replaceOccurrencesOfString:@"/" withString:@"%2F" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//	[escaped replaceOccurrencesOfString:@":" withString:@"%3A" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//	[escaped replaceOccurrencesOfString:@";" withString:@"%3B" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//	[escaped replaceOccurrencesOfString:@"=" withString:@"%3D" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//	[escaped replaceOccurrencesOfString:@"?" withString:@"%3F" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//	[escaped replaceOccurrencesOfString:@"@" withString:@"%40" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//	[escaped replaceOccurrencesOfString:@" " withString:@"%20" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//	[escaped replaceOccurrencesOfString:@"\t" withString:@"%09" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//	[escaped replaceOccurrencesOfString:@"#" withString:@"%23" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//	[escaped replaceOccurrencesOfString:@"<" withString:@"%3C" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//	[escaped replaceOccurrencesOfString:@">" withString:@"%3E" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//	[escaped replaceOccurrencesOfString:@"\"" withString:@"%22" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//	[escaped replaceOccurrencesOfString:@"\n" withString:@"%0A" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
	
	return escaped;
}

- (NSString *)encodedURLParameterString 
{
    NSString*result = (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (CFStringRef)self,
                                                                           NULL,
                                                                           CFSTR(":/=,!$&'()*+;[]@#?"),
                                                                           kCFStringEncodingUTF8);
	return result;
}

- (NSString*) decodeURLString
{
    NSString* result = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                         ( CFStringRef) self,
                                                                                         CFSTR(":/=,!$&'()*+;[]@#?"),
                                                                                         kCFStringEncodingUTF8);
    
    NSString *result1 = [result stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    return result1;
}


- (NSString *)stringByAddQueryParameter:(NSString*)parameter value:(NSString*)value
{
	NSString* p = parameter;
	NSString* v = [value encodedURLParameterString];
	if (p == nil)
		p = @"";
	if (v == nil)
		v = @"";
	
	return [self stringByAppendingFormat:@"&%@=%@", p, v];
}

- (NSString *)stringByAddQueryParameterWithoutEncode:(NSString*)parameter
                                               value:(NSString*)value
{
	NSString* p = parameter;    
	NSString* v = value;
	if (p == nil)
		p = @"";
	if (v == nil)
		v = @"";
	
	return [self stringByAppendingFormat:@"&%@=%@", p, v];
}



- (NSString *)stringByAddQueryParameter:(NSString*)parameter boolValue:(BOOL)value
{
	NSString* p = parameter;
	if (p == nil)
		p = @"";
	
	return [self stringByAppendingFormat:@"&%@=%d", p, value];
}

- (BOOL)isBlank{
    NSString *trimedString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([trimedString length] == 0) {
        return true;
    } else {
        return false;
    }
}

- (NSString *)stringByTrimmingBlankCharactersAtBothEnds{
    NSString *trimedString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimedString;
}



#define CTSLS(X) NSLocalizedStringFromTable(X, @"TraditionalChineseWord", nil)


- (NSString *)toTraditionalChinese;
{
    NSString *ret = nil;
    for (int i = 0; i < self.length; ++ i) {
        NSString *sub = [self substringWithRange:NSMakeRange(i, 1)];
        sub = CTSLS(sub);
        ret = [NSString stringWithFormat:@"%@%@",ret,sub];
    }
    return ret;
}

- (NSString *)stringByAddQueryParameter:(NSString*)parameter intValue:(int)value
{
	NSString* p = parameter;
	if (p == nil)
		p = @"";
	
	return [self stringByAppendingFormat:@"&%@=%d", p, value];
}

- (NSString *)stringByAddQueryParameter:(NSString*)parameter longValue:(int)value
{
	NSString* p = parameter;
	if (p == nil)
		p = @"";
	
	return [self stringByAppendingFormat:@"&%@=%d", p, value];
}


- (NSString *)stringByAddQueryParameter:(NSString*)parameter doubleValue:(double)value
{
	NSString* p = parameter;
	if (p == nil)
		p = @"";
	
	return [self stringByAppendingFormat:@"&%@=%f", p, value];
}

+ (NSString*)formatPhone:(NSString*)phone countryTelPrefix:(NSString*)countryTelPrefix
{
	NSString* retPhone = [NSString stringWithString:phone];
	
	retPhone = [retPhone stringByReplacingOccurrencesOfString:@"(" withString:@""];
	retPhone = [retPhone stringByReplacingOccurrencesOfString:@")" withString:@""];
	retPhone = [retPhone stringByReplacingOccurrencesOfString:@"-" withString:@""];
	retPhone = [retPhone stringByReplacingOccurrencesOfString:@" " withString:@""];
	
	if ([retPhone hasPrefix:countryTelPrefix])
		return retPhone;
	
	if ([retPhone hasPrefix:@"+"])
		return retPhone;
	
	NSString* retPhonePlus = [NSString stringWithFormat:@"+%@", retPhone];
	if ([retPhonePlus hasPrefix:countryTelPrefix])
		return retPhonePlus;
	
	return [NSString stringWithFormat:@"%@%@", countryTelPrefix, retPhone];
}

- (NSString*)insertHappyFace
{
	return [kHappyFace stringByAppendingFormat:@" %@", self];
}

- (NSString*)insertUnhappyFace
{
	return [kUnhappyFace stringByAppendingFormat:@" %@", self];
}

- (NSString*)encode3DESBase64:(NSString*)key
{
	return [NSString TripleDES:self encryptOrDecrypt:kCCEncrypt key:key];
}

//- (NSString*)decodeBase643DES:(NSString*)key
//{
//	return [NSString TripleDES:self encryptOrDecrypt:kCCDecrypt key:key];	
//}


- (BOOL)isMobileInChina
{
	if ([self length] != 11)
		return NO;
	else if ([self hasPrefix:@"13"] ||
			 [self hasPrefix:@"15"] ||
			 [self hasPrefix:@"16"] ||
			 [self hasPrefix:@"18"])
		return YES;
	else {
		return NO;
	}
}

- (NSMutableDictionary *)URLQueryStringToDictionary
{
    NSArray *pairs = [self componentsSeparatedByString:@"&"];
    if (pairs == nil || [pairs count] == 0)
        return nil;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for(NSString *pair in pairs) {
        NSArray *keyValue = [pair componentsSeparatedByString:@"="];
        if([keyValue count] == 2) {
            NSString *key = [keyValue objectAtIndex:0];
            NSString *value = [keyValue objectAtIndex:1];
            [dict setObject:value forKey:key];
        }
    }    
    
    return dict;
}

+ (NSString*)floatToStringWithoutZeroTail:(float)floatValue
{
    NSString* stringFloat = [NSString stringWithFormat:@"%f",floatValue];
    const char* floatChars = [stringFloat UTF8String];
    NSUInteger length = [stringFloat length];
    NSUInteger zeroLength  = 0;
    NSInteger i = length-1;
    
    for(; i >= 0; i--)
    {
        if(floatChars[i] == '0')
            zeroLength++;
        else
        {
            if(floatChars[i] =='.')
                i--;
            break;
        }  
    }
    
    NSString* returnString;
    
    if(i == -1)
        returnString  = @"0";  
    else 
        returnString = [stringFloat substringToIndex:i+1]; 
    return returnString;
}

- (NSString*)UTF8_To_GB2312
{
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* gb2312data = [self dataUsingEncoding:encoding];
    return [[NSString alloc] initWithData:gb2312data encoding:encoding];
}

- (BOOL)isEqualToString:(NSString *)aString ignoreCapital:(BOOL)ignoreCapital
{
    if (ignoreCapital) {
        return [[self uppercaseString] isEqualToString:[aString uppercaseString]];
    }
    return [self isEqualToString:aString];
}

- (BOOL)isOnlyNumberAndLetter
{
    NSCharacterSet *disallowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789QWERTYUIOPLKJHGFDSAZXCVBNMqwertyuioplkjhgfdsazxcvbnm"] invertedSet];
    NSRange foundRange = [self rangeOfCharacterFromSet:disallowedCharacters];
    if (foundRange.location != NSNotFound) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)isValidFloat
{
    NSCharacterSet *disallowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSRange foundRange = [self rangeOfCharacterFromSet:disallowedCharacters];
    if (foundRange.location == NSNotFound) {
        return YES;
    }
    else{
        return NO;
    }
}

// malloc a string and return it, you need to call free to dealloc it directly
- (char*)copyToCString
{
    const char* cstring = [self UTF8String];
    if (cstring != NULL){
        NSInteger len = strlen(cstring);
        char* destCString = malloc(len+1);
        memset(destCString, 0, len+1);
        strncpy(destCString, cstring, len);
        return destCString;
    }
    else{
        return NULL;
    }
}

extern NSString *NSStringFromCGFloat(CGFloat value)
{
    return [NSString stringWithFormat:@"%f", value];
}

extern NSString *NSStringFromNSInteger(NSInteger value)
{
    return [NSString stringWithFormat:@"%ld", value];
}

- (NSString*)formatNumber
{
    int minLen = 3;
    if ([self length] < minLen){
        return self;
    }
    
    NSString* first3 = [self substringToIndex:minLen];
    NSString* left = [self substringFromIndex:minLen];
    
    return [NSString stringWithFormat:@"%@ %@", first3, left];
}

#define IS_EN_SYMBOL(chr) ((chr<='z')&&(chr>='a') || (chr<='Z')&&(chr>='A'))
- (BOOL)isEnglishString{

    for (int index = 0; index < [self length]; index ++) {
        unichar ch = [self characterAtIndex:index];        
        if (!IS_EN_SYMBOL(ch)) {
            return NO;
        }
    }
    
    return YES;
}

- (CGSize)sizeWithMyFont:(UIFont*)fontToUse
{
    if ([self respondsToSelector:@selector(sizeWithAttributes:)])
    {
        NSDictionary* attribs = @{NSFontAttributeName:fontToUse};
        CGSize size = [self sizeWithAttributes:attribs];
        return CGSizeMake(ceilf(size.width), ceilf(size.height));
    }
    else{
        return CGSizeZero;
//        return ([self sizeWithFont:fontToUse]);
    }
}

- (CGSize)sizeWithMyFont:(UIFont*)font
       constrainedToSize:(CGSize)constrainedSize
           lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    CGSize size = CGSizeZero;
    
    if ([self respondsToSelector: @selector(boundingRectWithSize:options:attributes:context:)] == YES) {
        size = [self boundingRectWithSize: constrainedSize
                                  options: (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                               attributes: @{ NSFontAttributeName: font }
                                  context: nil].size;
        
        if (size.height > constrainedSize.height){
            size.height = constrainedSize.height;
        }
        
        return CGSizeMake(ceilf(size.width), ceilf(size.height));
    } else {
        
        return CGSizeZero;
        
//        size = [self sizeWithFont:font
//                constrainedToSize:constrainedSize
//                    lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    return size;
}

// 中文占两个字符, 其他占一个字符
- (NSUInteger)countOfCharacter
{
    NSUInteger character = 0;
    for(int i = 0; i < [self length]; i++) {
        int ch = [self characterAtIndex:i];
        // 判断是否为中文, 中文为两个字符
        if(ch > 0x4e00 && ch < 0x9fff) {
            character +=2;
        }
        else {
            character +=1;
        }
    }
    return character;
}

- (BOOL)validIDCardNumber:(NSString *)value {
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([value length] != 18) {
        return NO;
    }
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:value]) {
        return NO;
    }
    int summary = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7
    + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9
    + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10
    + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5
    + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8
    + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4
    + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2
    + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6
    + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    return [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}




//给手机,名字，身份证，银行卡加***隐藏
- (NSString *)hideMobleWithStar {
    return [self hideStringWithStarInRange:NSMakeRange(4, 3)];
}

- (NSString *)hideNameWithStar {
    
    NSRange range;
    if (self.length == 3 || self.length == 2) {
        range = NSMakeRange(1, 1);
    } else if (self.length > 3) {
        range = NSMakeRange(2, 1);
    } else {
        return self;
    }
    return [self hideStringWithStarInRange:range];
}

- (NSString *)hideIDNumberWithStar {
    return [self hideStringWithStarInRange:NSMakeRange(4, 8)];
}

- (NSString *)hideBankNumberWithStar {
    NSInteger loc = 6;
    NSInteger len = self.length - 10;
    
    return [self stringByReplacingCharactersInRange:NSMakeRange(loc, len) withString:@"******"];
}

- (NSString *)hideStringWithStarInRange:(NSRange)range {
    return [self stringByReplacingCharactersInRange:range withString:@"***"];
}

//金额字段加千位分隔符
- (NSString *)partitionThousandsDigitString {
    if (self.length <= 3) {
        
        return self;
        
    } else {
        
        NSMutableString *processString = [NSMutableString stringWithString:self];
        
        NSInteger location = processString.length - 3;
        
        NSMutableArray *processArray = [NSMutableArray array];
        
        while (location >= 0) {
            
            NSString *temp = [processString substringWithRange:NSMakeRange(location, 3)];
            
            [processArray addObject:temp];
            
            if (location < 3 && location > 0)
                
            {
                
                NSString *t = [processString substringWithRange:NSMakeRange(0, location)];
                
                [processArray addObject:t];
                
            }
            
            location -= 3;
            
        }
        
        NSMutableArray *resultsArray = [NSMutableArray array];
        
        int k = 0;
        
        for (NSString *str in processArray)
            
        {
            
            k++;
            
            NSMutableString *tmp = [NSMutableString stringWithString:str];
            
            if (str.length > 2 && k < processArray.count )
                
            {
                
                [tmp insertString:@"," atIndex:0];
                
                [resultsArray addObject:tmp];
                
            } else {
                
                [resultsArray addObject:tmp];
                
            }
            
        }
        
        NSMutableString *resultString = [NSMutableString string];
        
        for (NSInteger i = resultsArray.count - 1 ; i >= 0; i--)
            
        {
            
            NSString *tmp = [resultsArray objectAtIndex:i];
            
            [resultString appendString:tmp];
            
        }
        
        return resultString;
        
    }
    
}
//- (NSString *)thousandsRepresentation {
//    NSMutableString *str = [NSMutableString string];
//    __block NSInteger index = 0;
//    NSArray *numArr = [self componentsSeparatedByString:@"."];
//    NSString *integerStr = numArr.firstObject;
//
//    str = [[integerStr stringToArray] bk_reduce:str withBlock:^NSMutableString *(NSMutableString *sum, NSString *obj) {
//        if (index == 2 && self.length != 3) {
//            [str appendString:obj];
//            [str appendString:@","];
//            index = 0;
//            return str;
//        } else {
//            [str appendString:obj];
//            index += 1;
//            return str;
//        }
//        
//    }];
//    if (integerStr.length % 3 == 0 ) {
//        [str deleteCharactersInRange:NSMakeRange(str.length - 1, 1)];
//    }
//    if (numArr.count != 1) {
//        [str appendString:@"."];
//        [str appendString:numArr.lastObject];
//    }
//    
//    return str;
//
//}




-(NSArray *) stringToArray {
    NSMutableArray *arr = [NSMutableArray array];
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
                              [arr addObject:substring];
    }];
    return [NSArray arrayWithArray:arr];
}
/********************************************************************************************/

//检测是否为纯数字
- (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
//在UITextField的代理方法中
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    //检测是否为纯数字
    if ([self isPureInt:string]) {
        //添加空格，每4位之后，4组之后不加空格，格式为xxxx xxxx xxxx xxxx xxxxxxxxxxxxxx
        if (textField.text.length % 5 == 4 && textField.text.length < 22) {
            textField.text = [NSString stringWithFormat:@"%@ ", textField.text];
        }
        //只要30位数字
        if ([toBeString length] >= 19+4+11)
        {
            toBeString = [toBeString substringToIndex:19+4+11];
            textField.text = toBeString;
            [textField resignFirstResponder];
            return NO;
        }
    }
    else if ([string isEqualToString:@""]) { // 删除字符
        if ((textField.text.length - 2) % 5 == 4 && textField.text.length < 22) {
            textField.text = [textField.text substringToIndex:textField.text.length - 1];
        }
        return YES;
    }
    else{
        return NO;
    }
    return YES;
}

- (BOOL)stringContainsEmoji
{
    // 过滤所有表情。returnValue为NO表示不含有表情，YES表示含有表情
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue = YES;
                }
            }
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                returnValue = YES;
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff) {
                returnValue = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                returnValue = YES;
            }
        }
    }];
    return returnValue;
}

@end

