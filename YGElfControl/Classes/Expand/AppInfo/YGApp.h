//
//  YGApp.h
//  YGElfControl
//
//  Created by wuyiguang on 2018/1/30.
//  Copyright © 2018年 YG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGApp : NSObject

+ (NSDictionary *)appInfo;

/**
 app名称

 @return app名称
 */
+ (NSString *)appName;

/**
 app版本 比如：1.0.1
 
 @return app版本
 */
+ (NSString *)appVersion;

/**
 app build 版本
 
 @return app build 版本
 */
+ (NSString *)appBuildVersion;

/**
 手机IDFA(广告标识)，可用作imei等，用户没允许时，10.0以上会返回一串0
 
 @return 手机IDFA
 */
//+ (NSString *)systemIDFA;

/**
 手机别名：用户定义的名称
 
 @return 手机别名：用户定义的名称
 */
+ (NSString *)systemUserName;

/**
 设备名称
 
 @return 设备名称
 */
+ (NSString *)systemName;

/**
 手机系统版本
 
 @return 手机系统版本
 */
+ (NSString *)systemVersion;

/**
 手机型号
 
 @return 手机型号
 */
+ (NSString *)systemModel;

/**
 手机地方型号（国际化区域名称）
 
 @return 手机地方型号（国际化区域名称）
 */
+ (NSString *)systemLocalizedModel;

@end
