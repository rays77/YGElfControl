//
//  UIColor+Category.h
//  YGElfControl
//
//  Created by wuyiguang on 2018/1/7.
//  Copyright © 2018年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  功能:通过RGB创建颜色
 *
 *  @param red <CGFloat> <范围:0~255.0>
 *  @param green <CGFloat> <范围:0~255.0>
 *  @param blue <CGFloat> <范围:0~255.0>
 *
 *  @return UIColor
 *
 *  example: rgb(173.0,23.0,11.0)
 */
UIColor *rgb(CGFloat red, CGFloat green, CGFloat blue);

/**
 *  功能:通过RGB以及alpha创建颜色
 *
 *  @param red <CGFloat> <范围:0~255.0>
 *  @param green <CGFloat> <范围:0~255.0>
 *  @param blue <CGFloat> <范围:0~255.0>
 *  @param alpha <CGFloat> <范围:0~1.0>
 *s
 *  @return UIColor
 *
 *  example: rgbA(173.0,23.0,11.0,0.5)
 */
UIColor *rgba(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha);


@interface UIColor (Category)

/**
 *  Create a color from a HEX string.
 *  It supports the following type:
 *  - #RGB
 *  - #ARGB
 *  - #RRGGBB
 *  - #AARRGGBB
 *
 *  @param hexString NSString
 *
 *  @return Returns the UIColor instance
 */
+ (UIColor *)hex:(NSString *)hexString;

/**
 *  通过0xffffff的16进制数字创建颜色
 *
 *  @param rgb 0xffffff
 *
 *  @return UIColor
 */
+ (UIColor *)rgb:(NSUInteger)rgb;


/**
 调节颜色的明亮度
 @param color 颜色
 @param delta 明亮度
 @return UIColor
 */
+ (UIColor *)rgbOnvertToHSB:(UIColor*)color withBrighnessDelta:(CGFloat)delta;


/**
 调整颜色的透明度
 @param color 颜色
 @param delta 透明度
 @return UIColor
 */
+ (UIColor *)rgbOnvertToHSB:(UIColor*)color withAlphaDelta:(CGFloat)delta;

@end
