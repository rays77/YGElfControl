//
//  SVProgressHUD+HUD.m
//  YGElfControl
//
//  Created by wuyiguang on 2018/2/7.
//  Copyright © 2018年 YG. All rights reserved.
//

#import "SVProgressHUD+HUD.h"

@implementation SVProgressHUD (HUD)

+ (void)showMaskBlack
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
}

+ (void)showStatusDelay:(NSTimeInterval)delay message:(NSString *)message
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showWithStatus:message];
    
    if (delay > 0.0) {
        [SVProgressHUD dismissWithDelay:delay];
    }
}

+ (void)showInfoDelay:(NSTimeInterval)delay message:(NSString *)message
{
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showInfoWithStatus:message];
    if (delay > 0.0) {
        [SVProgressHUD dismissWithDelay:delay];
    }
}

+ (void)showTextDelay:(NSTimeInterval)delay message:(NSString *)message
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setInfoImage:[UIImage imageNamed:@"   "]];
    [SVProgressHUD showInfoWithStatus:message];
    if (delay > 0.0) {
        [SVProgressHUD dismissWithDelay:delay];
    }
}

+ (void)showSuccessDelay:(NSTimeInterval)delay message:(NSString *)message
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showSuccessWithStatus:message];
    
    if (delay > 0.0) {
        [SVProgressHUD dismissWithDelay:delay];
    }
}

+ (void)showErrorDelay:(NSTimeInterval)delay message:(NSString *)message
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showErrorWithStatus:message];
    
    if (delay > 0.0) {
        [SVProgressHUD dismissWithDelay:delay];
    }
}

@end
