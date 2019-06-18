//
//  ProgressHUD.h
//  YGElfControl
//
//  Created by wuyiguang on 2018/2/7.
//  Copyright © 2018年 YG. All rights reserved.
//

@interface ProgressHUD : NSObject

/**
 带旋转进度提示，加载时底部子控件不能被点击
 */
+ (void)showMaskBlack;

/**
 带旋转进度提示 + 描述
 */
+ (void)showStatusDelay:(NSTimeInterval)delay message:(NSString *)message;

/**
 带警告（!）的提示 + 描述
 */
+ (void)showInfoDelay:(NSTimeInterval)delay message:(NSString *)message;

/**
 带文本提示
 */
+ (void)showTextDelay:(NSTimeInterval)delay message:(NSString *)message;

/**
 成功时提示 + 描述
 */
+ (void)showSuccessDelay:(NSTimeInterval)delay message:(NSString *)message;

/**
 失败时提示 + 描述
 */
+ (void)showErrorDelay:(NSTimeInterval)delay message:(NSString *)message;

@end
