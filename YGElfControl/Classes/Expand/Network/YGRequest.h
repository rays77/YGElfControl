//
//  YGRequest.h
//  YGElfControl
//
//  Created by wuyiguang on 2018/1/2.
//  Copyright © 2018年 YG. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 请求方式

 - GET: GET
 - POST: POST
 */
typedef NS_ENUM(NSInteger, YGRequstMethod) {
    GET,
    POST,
};

/**
 请求成功之后的回调

 @param response 后台返回的数据类型json
 */
typedef void(^YGRequestSuccess)(id response, id message);

/**
 请求失败之后的回调

 @param error 错误信息
 */
typedef void(^YGRequestFailure)(NSError *error);


@interface YGRequest : NSObject

/**
 发送一个请求

 @param method 请求方式
 @param url url
 @param params 请求参数
 @param success 请求成功回调
 @param failure 请求失败回调
 */
+ (void)method:(YGRequstMethod)method
           url:(NSString *)url
        params:(NSDictionary *)params
       success:(YGRequestSuccess)success
       failure:(YGRequestFailure)failure;

/**
 发送一个特殊接口请求，不受配置参数影响params,[data、message、errCode等]
 
 @param method 请求方式
 @param url url
 @param params 请求参数
 @param success 请求成功回调
 @param failure 请求失败回调
 */
+ (void)specialWithMethod:(YGRequstMethod)method
                      url:(NSString *)url
                   params:(NSDictionary *)params
                  success:(YGRequestSuccess)success
                  failure:(YGRequestFailure)failure;

@end
