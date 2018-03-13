//
//  TVProgressHUD.m
//  WinTV
//
//  Created by HuangCharlie on 2/24/16.
//  Copyright © 2016 huaying. All rights reserved.
//

#import "TVProgressHUD.h"
//#import "AppDelegate.h"
#import "PPDebug.h"


@interface UIViewController(ancestor)

-(UIViewController *)objcTopVcOfHierachy;

@end

@implementation UIViewController(ancestor)

-(UIViewController *)objcTopVcOfHierachy {
    if ([self isKindOfClass:[UITabBarController class]]) {
        UIViewController *selectedVc = ((UITabBarController *)self).selectedViewController;
        if (selectedVc) { return selectedVc; }
        return self;
    }
    
    if ([self isKindOfClass:[UINavigationController class]]) {
        UIViewController *topNavvc = ((UINavigationController *) self).topViewController;
        if (topNavvc) return topNavvc;
        return self;
    }
    
    if ([self presentedViewController]) {
        return self.presentedViewController;
    }
    return self;
}

@end


@interface TVProgressHUD ()

@property (nonatomic,assign) BOOL isShowingHUD;
@property (nonatomic,weak) UIViewController* currentShowingController;

@end

@implementation TVProgressHUD

IMPL_SINGLETON_FOR_CLASS(TVProgressHUD)

- (instancetype)init{
    self = [super init];
    if(self){
        self.isShowingHUD = NO;
    }
    return self;
}
- (void)showDefaultLodingHUD {
    if (self.isShowingHUD) {
        return;
    }
    UIViewController* controller = [UIApplication sharedApplication].keyWindow.rootViewController.objcTopVcOfHierachy;
    UIViewController *deepestVc = [self findDeepestController:controller];
    self.currentShowingController = deepestVc;
    UIView* superView = deepestVc.view;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView animated:true];
    hud.mode = MBProgressHUDModeCustomView;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    hud.cornerRadius = 3;
    hud.opacity = 0.7;
    hud.margin = 0;
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
    hud.minSize = CGSizeMake(60.0, 60.0);
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = false;
    UIActivityIndicatorView *custom = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    custom.transform = CGAffineTransformMakeScale(0.8, 0.8);
    hud.customView = custom;
    [custom startAnimating];
    [superView addSubview:hud];
    [hud show:YES];
    
    self.isShowingHUD = YES;
    
    
}

- (UIViewController *)findDeepestController:(UIViewController *)current {
    
    if ([current presentedViewController]) {
        return [self findDeepestController:current.presentedViewController];
    }
    
    if ([current isKindOfClass:[UINavigationController class]]) {
        return ((UINavigationController *)current).topViewController;
    }
    
    return current;
    
    
    
}


- (void)showProgress:(NSString*)loadingText
{
    if (self.isShowingHUD) {
        return;
    }
    
    UIViewController* controller = [UIApplication sharedApplication].keyWindow.rootViewController.objcTopVcOfHierachy;

    self.currentShowingController = controller;
    UIView* superView = controller.view;

    // init HUD
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:superView];
    hud.removeFromSuperViewOnHide = YES;
    hud.labelText = loadingText;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.userInteractionEnabled = false;
    // show HUD
    [superView addSubview:hud];
    [hud show:YES];
    
    self.isShowingHUD = YES;
    
    PPDebug(@"show hud %@ on %@", loadingText, controller);
}

- (void)hideProgress
{
    if(!self.isShowingHUD){
        return;
    }
    
    BOOL hideSuccess = [MBProgressHUD hideHUDForView:self.currentShowingController.view animated:YES];;
    self.isShowingHUD = !hideSuccess;

    PPDebug(@"hide hud on %@, isSuccess %@",self.currentShowingController,@(hideSuccess));

}

- (void)showProgress:(NSString *)loadingText
        inController:(UIViewController *)controller
{
    
    // init HUD
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:controller.view];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeCustomView;
    hud.cornerRadius = 3;
    hud.opacity = 0.7;
    hud.margin = 0;
    hud.minSize = CGSizeMake(60.0, 60.0);
    UIActivityIndicatorView *custom = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    custom.transform = CGAffineTransformMakeScale(0.8, 0.8);
    hud.customView = custom;
    [custom startAnimating];
    hud.userInteractionEnabled = false;
    // show HUD
    [controller.view addSubview:hud];
    [hud show:YES];
    
    self.isShowingHUD = YES;

}

- (void)hideProgressInController:(UIViewController *)controller
{
    BOOL hideSuccess = [MBProgressHUD hideHUDForView:controller.view animated:YES];;
    self.isShowingHUD = !hideSuccess;
}

- (void)showProgress:(NSString*)text withInterval:(NSTimeInterval)delay {
    
    if (self.isShowingHUD) {
        return;
    }
    
    UIViewController* controller = [UIApplication sharedApplication].keyWindow.rootViewController.objcTopVcOfHierachy;
    
    self.currentShowingController = controller;
    UIView* superView = controller.view;
    
    // init HUD
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:superView];
    hud.removeFromSuperViewOnHide = YES;
    hud.labelText = text;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.userInteractionEnabled = false;
    // show HUD
    [superView addSubview:hud];
    [hud show:YES];
    
    [hud hide:YES afterDelay:delay];
    
}

@end












