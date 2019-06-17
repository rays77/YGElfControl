//
//  UIView+YGCornerRadius.h
//  YGElfControl
//
//  Created by wuyiguang on 2018/1/7.
//  Copyright © 2018年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YGCornerRadius)

/**
 设置一个四角圆角

 @param radius 圆角半径
 @param color  圆角背景色
 */
- (void)yg_cornerRadius:(CGFloat)radius cornerColor:(UIColor *)color;

/**
 设置一个普通圆角

 @param radius  圆角半径
 @param color   圆角背景色
 @param corners 圆角位置
 */
- (void)yg_cornerRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners;

/**
 设置一个带边框的圆角

 @param cornerRadii 圆角半径cornerRadii
 @param color       圆角背景色
 @param corners     圆角位置
 @param borderColor 边框颜色
 @param borderWidth 边框线宽
 */
- (void)yg_cornerRadiusWithCornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

@end


@interface CALayer (YGCornerRadius)

/** contents的便捷设置 */
@property (nonatomic, strong) UIImage *contentImage;

/** 如下分别对应UIView的相应API */

- (void)yg_cornerRadius:(CGFloat)radius cornerColor:(UIColor *)color;

- (void)yg_cornerRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners;

- (void)yg_cornerRadiusWithCornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

@end
