//
//  YGNoDataView.h
//  NewLeGo
//
//  Created by wuyiguang on 2018/3/7.
//  Copyright © 2018年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YGNoDataViewTapBlock)(void);

@interface YGNoDataView : UIView

/**
 只显示标题提示语

 @param title 标题
 @param toView 展示的父视图
 @param offsetY y轴偏移，-往上，+往下
 @param size 提示框整体大小
 @param tapBlock 点击的回调
 @return YGNoDataView
 */
+ (instancetype)showOnlyTitle:(NSString *)title
                       toView:(UIView *)toView
                       offsetY:(CGFloat)offsetY
                         size:(CGSize)size
                     tapBlock:(YGNoDataViewTapBlock)tapBlock;

/**
 只显示图片提示语

 @param nullImage 图片名称
 @param toView 展示的父视图
 @param offsetY y轴偏移，-往上，+往下
 @param size 提示框整体大小
 @param tapBlock 点击的回调
 @return YGNoDataView
 */
+ (instancetype)showOnlyNullImage:(NSString *)nullImage
                           toView:(UIView *)toView
                          offsetY:(CGFloat)offsetY
                             size:(CGSize)size
                         tapBlock:(YGNoDataViewTapBlock)tapBlock;

/**
 上标题 + 空图片提示语

 @param nullImage 图片名称
 @param topTitle 上标题
 @param toView 展示的父视图
 @param offsetY y轴偏移，-往上，+往下
 @param size 提示框整体大小
 @param tapBlock 点击的回调
 @return YGNoDataView
 */
+ (instancetype)showNullImage:(NSString *)nullImage
                     topTitle:(NSString *)topTitle
                       toView:(UIView *)toView
                      offsetY:(CGFloat)offsetY
                         size:(CGSize)size
                     tapBlock:(YGNoDataViewTapBlock)tapBlock;

/**
 空图片 + 下标题提示语

 @param nullImage 图片名称
 @param bottomTitle 下标题
 @param toView 展示的父视图
 @param offsetY y轴偏移，-往上，+往下
 @param size 提示框整体大小
 @param tapBlock 点击的回调
 @return YGNoDataView
 */
+ (instancetype)showNullImage:(NSString *)nullImage
                  bottomTitle:(NSString *)bottomTitle
                       toView:(UIView *)toView
                      offsetY:(CGFloat)offsetY
                         size:(CGSize)size
                     tapBlock:(YGNoDataViewTapBlock)tapBlock;

/**
 上标题 + 空图片 + 下标题提示语

 @param nullImage 图片名称
 @param topTitle 上标题
 @param bottomTitle 下标题
 @param toView 展示的父视图
 @param offsetY y轴偏移，-往上，+往下
 @param size 提示框整体大小
 @param tapBlock 点击的回调
 @return YGNoDataView
 */
+ (instancetype)showNullImage:(NSString *)nullImage
                     topTitle:(NSString *)topTitle
                  bottomTitle:(NSString *)bottomTitle
                       toView:(UIView *)toView
                      offsetY:(CGFloat)offsetY
                         size:(CGSize)size
                     tapBlock:(YGNoDataViewTapBlock)tapBlock;

/**
 修改【上】面标题字体和颜色

 @param font UIFont
 @param color UIColor
 */
- (void)topTitleFont:(UIFont *)font
               color:(UIColor *)color;

/**
 修改【下】面标题字体和颜色

 @param font UIFont
 @param color UIColor
 */
- (void)bottomTitleFont:(UIFont *)font
                  color:(UIColor *)color;

@end
