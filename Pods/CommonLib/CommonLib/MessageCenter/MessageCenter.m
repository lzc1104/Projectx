//
//  MessageCenter.m
//  BarrageClient
//
//  Created by pipi on 15/1/26.
//  Copyright (c) 2015年 PIPICHENG. All rights reserved.
//

#import "MessageCenter.h"
#import "PPDebug.h"
#import "UIView+Utils.h"


@implementation MessageCenter

IMPL_SINGLETON_FOR_CLASS(MessageCenter)

- (id)init
{
    self = [super init];
    return self;
}


- (void)postSuccessMessage:(NSString*)message duration:(CGFloat)duration
{
    [[UIApplication sharedApplication].delegate.window enumSubviewsWithClass:[MBProgressHUD class] handler:^(MBProgressHUD *view) {
        if ([view respondsToSelector:@selector(hide:)]) {
            [view hide:false];
        }
    }];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [UILabel labelinProgressWithString:message blankWidth:0 fontsize:13];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    hud.margin = 10.0f;
    hud.opacity = 0.7;
    hud.cornerRadius = 3;
    hud.labelFont = [UIFont systemFontOfSize:13];
    hud.minSize = CGSizeMake(26, 44);
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = NO;
    [hud hide:YES afterDelay:duration];

}
-(void)postLongMessage:(NSString *) message withTitle:(NSString *)title duration:(CGFloat )duration {
    [[UIApplication sharedApplication].delegate.window enumSubviewsWithClass:[MBProgressHUD class] handler:^(MBProgressHUD *view) {
        if ([view respondsToSelector:@selector(hide:)]) {
            [view hide:false];
        }
    }];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = message;
    hud.detailsLabelFont = [UIFont systemFontOfSize:13];
    hud.detailsLabelColor = [UIColor whiteColor];
    hud.labelText = title;
    hud.labelFont = [UIFont systemFontOfSize:13];
    hud.labelColor = [UIColor whiteColor];
//    UILabel *label = [[UILabel alloc] init];
//    label.numberOfLines = 0;
//    label.text = message;
//    label.preferredMaxLayoutWidth = 100;
//    label.font = [UIFont systemFontOfSize:13];
//    label.textColor = [UIColor whiteColor];
//    [label sizeToFit];
    
//    hud.customView = label;
    hud.margin = 0.0f;
    hud.opacity = 0.7;
    hud.cornerRadius = 3;
    hud.labelFont = [UIFont systemFontOfSize:13];
    hud.minSize = CGSizeMake(26, 44 + 15);
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = NO;
    [hud hide:YES afterDelay:duration];
}

- (void)postErrorMessage:(NSString*)message duration:(CGFloat)duration
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 7.0f;
//    hud.color = [[UIColor alloc] initWithHex:0x66666];
    CGFloat value = (CGFloat)(0x66) / (CGFloat)(255.0);
    hud.color = [UIColor colorWithRed:value green:value blue:value alpha:1];
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = NO;
    
    [hud hide:YES afterDelay:duration];
}

- (void)postInfoMessage:(NSString*)message duration:(CGFloat)duration
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 7.0f;
    hud.labelFont = [UIFont systemFontOfSize:13];
    CGFloat value = (CGFloat)(0x66) / (CGFloat)(255.0);
    hud.color = [UIColor colorWithRed:value green:value blue:value alpha:1];
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = NO;

    [hud hide:YES afterDelay:duration];
    
}

#define LOADING_VIEW_TAG        2015012601

- (MBProgressHUD*)showProgress:(NSString*)text inView:(UIView*)view
{
    MBProgressHUD* hud = (MBProgressHUD*)[view viewWithTag:LOADING_VIEW_TAG];;
    if ([hud isKindOfClass:[MBProgressHUD class]] == NO){
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = MBProgressHUDModeDeterminate;
        hud.labelText = text;
        hud.tag = LOADING_VIEW_TAG;
    }
    else{
        hud.labelText = text;
        [hud show:YES];
    }
    
    return hud;
}


- (MBProgressHUD*)showLoading:(NSString*)text inView:(UIView*)view
{
    MBProgressHUD* hud = (MBProgressHUD*)[view viewWithTag:LOADING_VIEW_TAG];;
    if ([hud isKindOfClass:[MBProgressHUD class]] == NO){
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        
        hud.tag = LOADING_VIEW_TAG;
        hud.labelText = text;
    }
    else{
        hud.labelText = text;
        [hud show:YES];
    }
    
    return hud;
}

- (MBProgressHUD*)showLoadingInView:(UIView*)view
{
    MBProgressHUD* hud = (MBProgressHUD*)[view viewWithTag:LOADING_VIEW_TAG];;
    if ([hud isKindOfClass:[MBProgressHUD class]] == NO){
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.tag = LOADING_VIEW_TAG;
    }
    else{
        [hud show:YES];
    }

    return hud;
}

- (void)hideLoadingView:(UIView*)view
{
    MBProgressHUD* hud = (MBProgressHUD*)[view viewWithTag:LOADING_VIEW_TAG];
    if ([hud isKindOfClass:[MBProgressHUD class]]){
        [hud hide:YES];
    }
    else{
        PPDebug(@"<hideLoadingView> but view is NOT loading view");
    }
}

@end
                 
                 

                 
                 

