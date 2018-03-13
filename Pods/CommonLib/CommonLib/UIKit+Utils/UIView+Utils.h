//
//  UIView+Utils.h
//  WinTour
//
//  Created by Garen on 27/5/16.
//  Copyright © 2016年 huaying. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Utils)

- (void)enumSubviewsWithClass:(Class)viewClass handler:(void (^)(id view))handler;

+ (UILabel *)labelinProgressWithString:(NSString *) message blankWidth:(CGFloat)width fontsize:(CGFloat) fontsize;

- (void)drawDashedfrom:(CGPoint)startPoint to:(CGPoint)endPoint color:(UIColor *)color;

@end
