//
//  ErrorCenter.m
//  WinTour
//
//  Created by ChenGuangchuan on 16/6/5.
//  Copyright © 2016年 huaying. All rights reserved.
//

#import "ErrorCenter.h"

@interface ErrorCenter ()
@property(nonatomic,strong) NSDictionary *errorMessageDict;
@end

@implementation ErrorCenter
IMPL_SINGLETON_FOR_CLASS(ErrorCenter)


//自定义需要显示的错误信息,通过错误码PBMessageCode查找
- (NSString *)customErrorMessageForCode:(NSInteger)code
{

    NSString *errorMessage = self.errorMessageDict[@(code)];
    if (errorMessage == nil){
        errorMessage = @"未知错误";
    }
    return errorMessage;
}

//通过错误码构件自定义信息的错误对象
- (NSError *)customErrorWithCode:(NSInteger) code
{
    if (code == 0) {
        return nil;
    }
    NSString *errorMessage = [self customErrorMessageForCode:code];
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey: errorMessage};
    return [NSError errorWithDomain:@"[Service Error]" code:code userInfo:userInfo];
}


//通过服务器返回的错误码和错误信息构建错误对象
- (NSError *)errorWithCode:(NSInteger)code message:(NSString*)message
{
    if (code == 0) {
        return nil;
    }
    
    NSString *errorMessage = message;
    if (errorMessage == nil){
        errorMessage = @"未知错误";
    }
    
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey: errorMessage};
    return [NSError errorWithDomain:@"[Service Error]" code:code userInfo:userInfo];
}

- (void)postError:(NSError *)error
{
    POSTMSG([error localizedDescription]);
}

- (void)postcustomErrorWithCode:(NSInteger) code
{
    NSError* error = [self customErrorWithCode:code];
    [self postError:error];
}

@end
