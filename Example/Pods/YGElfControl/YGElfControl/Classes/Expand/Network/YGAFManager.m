//
//  YGAFManager.m
//  YGElfControl
//
//  Created by wuyiguang on 2017/12/31.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGAFManager.h"
#import <AFNetworking/AFNetworking.h>

@interface YGAFManager ()

@end

@implementation YGAFManager

+ (instancetype)share {
    static YGAFManager *ygManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ygManager = [[self alloc] init];
    });
    return ygManager;
}

+ (NSSet *)acceptableContentTypes {
    return [NSSet setWithObjects:@"image/gif", @"text/html", @"text/json", @"application/json", @"text/javascript", nil];
}

- (instancetype)init {
    if (self = [super init]) {
        self.openLog = YES;
        AFHTTPSessionManager *mng = [AFHTTPSessionManager manager];
        mng.requestSerializer.timeoutInterval = kFManagerTimeoutInterval;
        mng.requestSerializer = [AFJSONRequestSerializer serializer];
        mng.responseSerializer.acceptableContentTypes = [YGAFManager acceptableContentTypes];
        mng.requestSerializer.timeoutInterval = kFManagerTimeoutInterval;
        self.manager = mng;
    }
    return self;
}

- (void)setTimeoutInterval:(NSTimeInterval)timeoutInterval {
    _timeoutInterval = timeoutInterval;
    ((AFHTTPSessionManager *)self.manager).requestSerializer.timeoutInterval = timeoutInterval;
}

- (NSDictionary *)baseParams {
    /**
     添加基础参数
     api_token：用户api_token
     user_id：用户id
     version_name：服务器api版本号
     */
    
//    NSMutableDictionary *usePrams = [[NSMutableDictionary alloc] init];
    
    return nil;
}

- (void)setOpenLog:(BOOL)openLog {
    _openLog = openLog;
}

- (NSString *)urlPath:(NSString *)path {
    // 判断 path 的第一个字符是否包含"/"
    if (path.length >= 1) {
        NSString *fristStr = [path substringToIndex:1];
        if ([fristStr containsString:@"/"]) {
            return [NSString stringWithFormat:@"%@%@", _baseUrl, path];
        } else {
            return [NSString stringWithFormat:@"%@/%@", _baseUrl, path];
        }
    } else {
        return _baseUrl;
    }
}

@end
