//
//  YGAFManager.h
//  YGElfControl
//
//  Created by wuyiguang on 2017/12/31.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

#define kFManagerTimeoutInterval     60.0

#define kYGAFManager ([YGAFManager share])
#define kAFHTTPSessionManager ([kYGAFManager manager])

@interface YGAFManager : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, assign) NSTimeInterval timeoutInterval;
/**
 是否打开json日志，默认YES
 */
@property (nonatomic, assign) BOOL openLog;

@property (nonatomic, copy)   NSString *baseUrl;

/**
 全局配置json解析的根目录的key，如解析data中的字段
 {
    "data": {
        "name": "李"
    },
    "success": true,
    "message": "成功"
 }
 */
@property (nonatomic, copy)   NSString *root;

/**
 全局配置json解析的根提示的key，如解析message中的字段
 {
    "data": {
        "name": "李"
    },
    "success": true,
    "message": "成功"
 }
 */
@property (nonatomic, copy)   NSString *message;

/**
 全局配置json解析的成功字段的key，如解析errCode中的字段
 {
    "data": {
        "name": "李"
    },
    "success": true,
    "message": "成功"
 }
 */
@property (nonatomic, copy)   NSString *success;

/**
 全局配置json解析的成功字段，如解析success中的字段
 {
    "data": {
        "name": "李"
    },
    "success": false,
    "message": "失败",
    "errCode": 404
 }
 */
@property (nonatomic, copy)   NSString *errCode;

+ (instancetype)share;

/**
 基础参数

 @return 词典
 */
- (NSDictionary *)baseParams;

- (NSString *)urlPath:(NSString *)path;

@end
