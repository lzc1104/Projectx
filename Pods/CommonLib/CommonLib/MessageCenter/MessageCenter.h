//
//  MessageCenter.h
//  BarrageClient
//
//  Created by pipi on 15/1/26.
//  Copyright (c) 2015年 PIPICHENG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface MessageCenter : NSObject

DEF_SINGLETON_FOR_CLASS(MessageCenter)

- (void)postSuccessMessage:(NSString*)message duration:(CGFloat)duration;
- (void)postErrorMessage:(NSString*)message duration:(CGFloat)duration;
- (void)postInfoMessage:(NSString*)message duration:(CGFloat)duration;
-(void)postLongMessage:(NSString *) message withTitle:(NSString *)title duration:(CGFloat )duration;
- (MBProgressHUD*)showProgress:(NSString*)text inView:(UIView*)view;
- (MBProgressHUD*)showLoading:(NSString*)text inView:(UIView*)view;
- (MBProgressHUD*)showLoadingInView:(UIView*)view;
- (void)hideLoadingView:(UIView*)view;

@end

#define POSTMSG(msg)                        ([[MessageCenter sharedInstance] postSuccessMessage:msg duration:1.5])
#define POSTMSG2(msg, seconds)              ([[MessageCenter sharedInstance] postSuccessMessage:msg duration:seconds])

#define POST_SUCCESS_MSG(msg)               ([[MessageCenter sharedInstance] postSuccessMessage:msg duration:1.5])
#define POST_SUCCESS_MSG2(msg, seconds)     ([[MessageCenter sharedInstance] postSuccessMessage:msg duration:seconds])

#define POST_ERROR(msg)                     ([[MessageCenter sharedInstance] postSuccessMessage:msg duration:3])
#define POST_TV_ERROR(error)                ([[MessageCenter sharedInstance] postSuccessMessage:error.localizedDescription duration:3])



//#define SHOW_LOADING(text, view)            ([[MessageCenter sharedInstance] showLoading:text inView:view])
//#define LOADING(view)                       ([[MessageCenter sharedInstance] showLoadingInView:view])
//#define HIDE_LOADING(view)                  ([[MessageCenter sharedInstance] hideLoadingView:view])



//#define SENDING_TEXT                        @"奋力请求中..."
//#define LOADING_TEXT                        @"奋力加载中..."

