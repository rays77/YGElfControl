//
//  YGRequest.m
//  YGElfControl
//
//  Created by wuyiguang on 2018/1/2.
//  Copyright © 2018年 YG. All rights reserved.
//

#import "YGRequest.h"
#import "NSObject+Helper.h"
#import "YGAFManager.h"
#import "YGCommonUse.h"

@interface YGRequest ()
@end

@implementation YGRequest

+ (void)method:(YGRequstMethod)method
           url:(NSString *)url
        params:(NSDictionary *)params
       success:(YGRequestSuccess)success
       failure:(YGRequestFailure)failure {
    
    // 拼装基础参数
    NSMutableDictionary *pm = [[NSMutableDictionary alloc] init];
    
    if (params) {
        [pm setValuesForKeysWithDictionary:params];
    }
    
    NSDictionary *baseParams = [kYGAFManager baseParams];
    
    if (baseParams) {
        [pm setValuesForKeysWithDictionary:baseParams];
    }
    
    NSString *urlStr = url;
    
    if (kYGAFManager.baseUrl) {
        urlStr = [NSString stringWithFormat:@"%@%@", kYGAFManager.baseUrl, url];
    }
    
    if (kYGAFManager.openLog) {
        YGLog(@"请求url: --%@", urlStr);
        YGLog(@"请求参数: --%@", [pm yg_toString]);
    }
    
    if (method == GET) {
        [YGRequest GET:urlStr params:pm success:success failure:failure];
    } else if (method == POST) {
        [YGRequest POST:urlStr params:pm success:success failure:failure];
    }
}

+ (void)specialWithMethod:(YGRequstMethod)method
                      url:(NSString *)url
                   params:(NSDictionary *)params
                  success:(YGRequestSuccess)success
                  failure:(YGRequestFailure)failure {
    
    NSString *urlStr = url;
    
    if (kYGAFManager.baseUrl) {
        urlStr = [NSString stringWithFormat:@"%@%@", kYGAFManager.baseUrl, url];
    }
    
    if (kYGAFManager.openLog) {
        YGLog(@"特殊-请求url: --%@", urlStr);
        YGLog(@"特殊-请求参数: --%@", [params yg_toString]);
    }
    if (method == GET)
    {
        [kAFHTTPSessionManager GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (kYGAFManager.openLog) {
                YGLog(@"成功-返回值: --%@", [responseObject yg_toString]);
            }
            
            if (success) {
                success(responseObject, nil);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [YGRequest jsonAnalysisFailure:failure task:task error:error];
        }];
    }
    else if (method == POST)
    {
        [kAFHTTPSessionManager POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (kYGAFManager.openLog) {
                YGLog(@"成功-返回值: --%@", [responseObject yg_toString]);
            }
                
            if (success) {
                success(responseObject, nil);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [YGRequest jsonAnalysisFailure:failure task:task error:error];
        }];
    }
}

+ (void)GET:(NSString *)url params:(NSDictionary *)params success:(YGRequestSuccess)success failure:(YGRequestFailure)failure {
    
    [kAFHTTPSessionManager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [YGRequest jsonAnalysisSuccess:success failure:failure task:task responseObject:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [YGRequest jsonAnalysisFailure:failure task:task error:error];
    }];
}

+ (void)POST:(NSString *)url params:(NSDictionary *)params success:(YGRequestSuccess)success failure:(YGRequestFailure)failure {
    [kAFHTTPSessionManager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [YGRequest jsonAnalysisSuccess:success failure:failure task:task responseObject:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [YGRequest jsonAnalysisFailure:failure task:task error:error];
    }];
}

+ (void)jsonAnalysisSuccess:(YGRequestSuccess)success failure:(YGRequestFailure)failure task:(NSURLSessionDataTask *)task responseObject:(id)responseObject {
    
    if (kYGAFManager.openLog) {
        YGLog(@"成功-返回值: --%@", [responseObject yg_toString]);
    }
    
    if (responseObject) {
        id obj = responseObject;
        NSString *msg = nil;
        NSString *errCode = @"-1"; // -1：NSURLErrorUnknown
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            obj = kYGAFManager.root ? responseObject[kYGAFManager.root] : responseObject;
            msg = kYGAFManager.message ? responseObject[kYGAFManager.message] : nil;
            errCode = kYGAFManager.errCode ? responseObject[kYGAFManager.errCode] : errCode;
            
            NSString *successStr = kYGAFManager.success;
            
            if (successStr) {
                if (![responseObject[successStr] boolValue]) {
                    
                    NSError *error = nil;
                    if (msg) {
                        error = [[NSError alloc] initWithDomain:msg code:[errCode integerValue]
                                                       userInfo:@{NSLocalizedDescriptionKey:msg}];
                    }
                    [YGRequest jsonAnalysisFailure:failure task:task error:error];
                    return;
                }
            }
        }
        
        if (success) {
            success(obj, msg);
        }
    } else {
        [YGRequest jsonAnalysisFailure:failure task:task error:nil];
    }
}

+ (void)jsonAnalysisFailure:(YGRequestFailure)failure task:(NSURLSessionDataTask *)task error:(NSError *)error {
    if (failure) {
        if (kYGAFManager.openLog) {
            YGLog(@"失败-返回值:%@", [error debugDescription]);
        }
        failure(error);
    }
}

@end
