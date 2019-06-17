//
//  YGFileManager.h
//  YGElfControl
//
//  Created by wuyiguang on 2018/3/8.
//  Copyright © 2018年 YG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 缓存文件
#define kYGFilePath     @"YGFilePath"

// document路径
#define kYGDocumentPath (NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0])

@interface YGFileManager : NSObject

/** 是否有该文件夹 */
+ (BOOL)hasFolder:(NSString *)path;

/** 是否有该文件 */
+ (BOOL)hasFile:(NSString *)path;

/** 获取某个文件夹的路径，如果没有文件夹则自动创建并返回路径 */
+ (NSString *)folderPath:(NSString *)floder;

/** 删除某个文件夹 */
+ (void)removeFolder:(NSString *)floder;

/**
 获取Plist文件路径，如果没有该plist则自动创建并返回路径
 [FileManager plistPath:YGFilePath.plist]
 */
+ (NSString *)plistPath:(NSString *)plist;

/** NSUserDefaults 存储 */
+ (void)yg_setObject:(id)obj forKey:(NSString *)key syn:(BOOL)syn;

/** 取出 NSUserDefaults 的值 */
+ (id)yg_objectForKey:(NSString *)key;

@end
