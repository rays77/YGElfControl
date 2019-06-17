//
//  YGFileManager.m
//  YGElfControl
//
//  Created by wuyiguang on 2018/3/8.
//  Copyright © 2018年 YG. All rights reserved.
//

#import "YGFileManager.h"

@implementation YGFileManager

+ (BOOL)hasFolder:(NSString *)path {
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if (isDir == YES && existed == YES) {
        return true;
    }
    return false;
}

+ (BOOL)hasFile:(NSString *)path {
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if (isDir == NO && existed == YES) {
        return true;
    }
    return false;
}

+ (NSString *)folderPath:(NSString *)floder {
    NSString *path = [kYGDocumentPath stringByAppendingPathComponent:floder];
    if (![self hasFolder:path]) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

+ (void)removeFolder:(NSString *)floder {
    NSString *path = [kYGDocumentPath stringByAppendingPathComponent:floder];
    if ([self hasFolder:path]) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:path error:nil];
    }
}

+ (NSString *)plistPath:(NSString *)plist {
    NSString *path = [kYGDocumentPath stringByAppendingPathComponent:plist];
    if (![self hasFile:path]) {
        [self createPlist:plist];
    }
    return path;
}

+ (void)createPlist:(NSString *)plist {
    NSString *path = [kYGDocumentPath stringByAppendingPathComponent:plist];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createFileAtPath:path contents:nil attributes:nil];
    NSDictionary *dic = @{kYGFilePath: kYGFilePath};
    [dic writeToFile:path atomically:YES];
}

/** NSUserDefaults 存储 */
+ (void)yg_setObject:(id)obj forKey:(NSString *)key syn:(BOOL)syn
{
    if (obj == nil || obj == (id)(kCFNull)) {
        return;
    }
    
    if (key == nil || key == (id)(kCFNull)) {
        return;
    }
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:obj forKey:key];
    if (syn) {
        [userDefault synchronize];
    }
}

/** 取出 NSUserDefaults 的值 */
+ (id)yg_objectForKey:(NSString *)key
{
    if (key == nil || key == (id)(kCFNull)) {
        return nil;
    }
    
     NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
     return [userDefault objectForKey:key];
}

@end
