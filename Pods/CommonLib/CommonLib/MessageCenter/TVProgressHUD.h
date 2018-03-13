//
//  TVProgressHUD.h
//  WinTV
//
//  Created by HuangCharlie on 2/24/16.
//  Copyright © 2016 huaying. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>
#import "SynthesizeSingleton.h"


#define LOADING_TEXT(text)       [[TVProgressHUD sharedInstance] showProgress:text]
#define HIDE_LOADING()           [[TVProgressHUD sharedInstance] hideProgress]

#define LOADING()                 [[TVProgressHUD sharedInstance] showDefaultLodingHUD]

#define LOADING_DATA()            [[TVProgressHUD sharedInstance] showDefaultLodingHUD]

#define LOADING_REQUEST()         [[TVProgressHUD sharedInstance] showDefaultLodingHUD]

@interface TVProgressHUD : NSObject

DEF_SINGLETON_FOR_CLASS(TVProgressHUD)

// show progress in current view
- (void)showProgress:(NSString*)loadingText;
- (void)showDefaultLodingHUD;
// hide progress of current view
- (void)hideProgress;

- (void)showProgress:(NSString *)loadingText
        inController:(UIViewController *)controller;
- (void)hideProgressInController:(UIViewController *)controller;

- (void)showProgress:(NSString*)text withInterval:(NSTimeInterval)delay;

@end
