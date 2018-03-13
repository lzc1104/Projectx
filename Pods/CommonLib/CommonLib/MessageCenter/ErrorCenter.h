//
//  ErrorCenter.h
//  WinTour
//
//  Created by ChenGuangchuan on 16/6/5.
//  Copyright © 2016年 huaying. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPDebug.h"
#import "MessageCenter.h"
#import "SynthesizeSingleton.h"

#define ERRORCENTER_POST_CUSTOM_ERROR(x)     [[ErrorCenter sharedInstance] postcustomErrorWithCode:x]

#define ERRORCENTER_POST_ERROR(x)      [[ErrorCenter sharedInstance] postError:x]

#define ERRORCENTER_ERROR(x, m)      [[ErrorCenter sharedInstance] errorWithCode:x message:m]


@interface ErrorCenter : NSObject
DEF_SINGLETON_FOR_CLASS(ErrorCenter)

- (NSError *)customErrorWithCode:(NSInteger)code;
- (NSError *)errorWithCode:(NSInteger)code
                   message:(NSString*)message;

- (void)postError:(NSError *)error;
- (void)postcustomErrorWithCode:(NSInteger) code;

@end
