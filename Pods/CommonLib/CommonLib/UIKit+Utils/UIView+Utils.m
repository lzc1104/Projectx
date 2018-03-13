//
//  UIView+Utils.m
//  WinTour
//
//  Created by Garen on 27/5/16.
//  Copyright © 2016年 huaying. All rights reserved.
//

#import "UIView+Utils.h"

@implementation UIView (Utils)

- (void)enumSubviewsWithClass:(Class)viewClass handler:(void (^)(id view))handler
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:viewClass]) {
            if (handler) {
                handler(view);
            }
        }
    }
}

+ (UILabel *)labelinProgressWithString:(NSString *) message blankWidth:(CGFloat)width fontsize:(CGFloat) fontsize {
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width * 0.8;
    label.font = [UIFont systemFontOfSize:fontsize];
    label.textColor = [UIColor whiteColor];
    
    NSAttributedString *str = [[NSAttributedString alloc] initWithString: message ?: @" "];
    
    NSMutableAttributedString *mulStr = [[NSMutableAttributedString alloc] init];
    NSTextAttachment *blank = [[NSTextAttachment alloc] init];
    blank.bounds = CGRectMake(0, 0, width, fontsize);
    NSAttributedString *blankStr = [NSAttributedString attributedStringWithAttachment:blank];
    [mulStr appendAttributedString:blankStr];
    [mulStr appendAttributedString:str];
    [mulStr appendAttributedString:blankStr];
    label.attributedText = mulStr;
    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 0.8, CGFLOAT_MAX);
    CGSize fitSize = [label sizeThatFits:maxSize];
    label.bounds = CGRectMake(0, 0, fitSize.width, fitSize.height + 5);
    return label;
}

- (void)drawDashedfrom:(CGPoint)startPoint to:(CGPoint)endPoint color:(UIColor *)color {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:self.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    
    // 设置虚线颜色
    if (color != nil) {
        [shapeLayer setStrokeColor:[color CGColor]];
    } else {
        [shapeLayer setStrokeColor:[[UIColor lightGrayColor] CGColor]];
    }
    
    //设置虚线的宽度
    [shapeLayer setLineWidth:1.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    // lineWidth=线的宽度 space=每条线的间距
    int lineWidth = 1;
    int space = 1;
    
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:lineWidth],
      [NSNumber numberWithInt:space],nil]];

    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
    CGPathAddLineToPoint(path, NULL, endPoint.x, endPoint.y);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);

    [[self layer] addSublayer:shapeLayer];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
