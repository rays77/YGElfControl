//
//  YGApp.m
//  YGElfControl
//
//  Created by wuyiguang on 2018/1/30.
//  Copyright © 2018年 YG. All rights reserved.
//

#import "YGApp.h"
//#import <AdSupport/AdSupport.h>

@implementation YGApp

+ (NSDictionary *)appInfo
{
    return [[NSBundle mainBundle] infoDictionary];
}

/**
 app名称
 
 @return app名称
 */
+ (NSString *)appName
{
    return [[YGApp appInfo] objectForKey:@"CFBundleDisplayName"];
}

/**
 app版本 比如：1.0.1
 
 @return app版本
 */
+ (NSString *)appVersion
{
    return [[YGApp appInfo] objectForKey:@"CFBundleShortVersionString"];
}

/**
 app build 版本
 
 @return app build 版本
 */
+ (NSString *)appBuildVersion
{
    return [[YGApp appInfo] objectForKey:@"CFBundleVersion"];
}

/**
 手机IDFA(广告标识)
 
 @return 手机IDFA
 */
    /*
+ (NSString *)systemIDFA
{
    // ios10 之后最好加一个判断 [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]  返回值是BOOL值   如果返回的YES说明没有 “开启限制广告跟踪”，可以获取到正确的idfa  如果返回的是NO，说明等待你的就是一串00000000000
    //    if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    if (obj_isNull(idfa)) {
        idfa = @"";
    }
    return idfa;
}
*/
    
/**
 手机别名：用户定义的名称
 
 @return 手机别名：用户定义的名称
 */
+ (NSString *)systemUserName
{
    return [[UIDevice currentDevice] name];
}

/**
 设备名称
 
 @return 设备名称
 */
+ (NSString *)systemName
{
    return [[UIDevice currentDevice] systemName];
}

/**
 手机系统版本
 
 @return 手机系统版本
 */
+ (NSString *)systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

/**
 手机型号
 
 @return 手机型号
 */
+ (NSString *)systemModel
{
    return [[UIDevice currentDevice] model];
}

/**
 手机地方型号（国际化区域名称）
 
 @return 手机地方型号（国际化区域名称）
 */
+ (NSString *)systemLocalizedModel
{
    return [[UIDevice currentDevice] localizedModel];
}

@end
