//
//  UIFont+Fit.h
//  YGElfControl
//
//  Created by wuyiguang on 2018/1/14.
//  Copyright © 2018年 YG. All rights reserved.
//

#define yg_iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 640), [[UIScreen mainScreen] currentMode].size) : NO)

#define yg_iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define yg_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define yg_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define yg_iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake((kScreenWidth * 3), (kScreenHeight * 3)), [[UIScreen mainScreen] currentMode].size) : NO)

#define yg_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#import <UIKit/UIKit.h>

@interface UIFont (Fit)

+ (UIFont *)yg_systemOfSize:(CGFloat)size;

+ (UIFont *)yg_boldSystemOfSize:(CGFloat)size;

@end
