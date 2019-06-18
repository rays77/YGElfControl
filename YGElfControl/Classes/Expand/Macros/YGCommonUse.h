//
//  YGCommonUse.h
//  YGElfControl
//
//  Created by wuyiguang on 2018/1/7.
//  Copyright © 2018年 YG. All rights reserved.
//

#ifndef YGCommonUse_h
#define YGCommonUse_h


// ************** main screen bounds **************
#define kScreenBounds  [UIScreen mainScreen].bounds
#define kScreenWidth   kScreenBounds.size.width
#define kScreenHeight  kScreenBounds.size.height


// ************** storyboard **************
#define kStoryboard(name)                   ([UIStoryboard storyboardWithName:name bundle:[NSBundle mainBundle]])
#define kStoryboardBundle(name, bundle)     ([UIStoryboard storyboardWithName:name bundle:bundle])
#define kStroyboardVC(name, identifier)     ([kStoryboard(name) instantiateViewControllerWithIdentifier:identifier])


// ************** load nib **************
#define kNibView(nibNamed, obj)           ([[[NSBundle mainBundle] loadNibNamed:nibNamed owner:obj options:nil] lastObject])


// ************** 获取网络压缩后的图片 200x200 **************
#define kCutNetImageSizeStirng(width, height)  ([NSString stringWithFormat:@"%.0fx%.0f", width, height])


// ************** 系统版本 **************
#define iOS6_Before ([[UIDevice currentDevice].systemVersion doubleValue] < 7.0)
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0 && [[UIDevice currentDevice].systemVersion doubleValue] < 8)
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0 && [[UIDevice currentDevice].systemVersion doubleValue] < 9)
#define iOS9 ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0&& [[UIDevice currentDevice].systemVersion doubleValue] < 10)
#define iOS10 ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0)


// ************** 判断设备 **************
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 640), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake((kScreenWidth * 3), (kScreenHeight * 3)), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


// ************** 获取APP信息 **************
//取app的版本号
#define kAppVersion [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]


// ************** 跳转到app store地址 **************
#define kAppStoreUrl @"https://itunes.apple.com/cn/app/id1358696902?mt=8"


// ************** 自定义Log **************
#ifdef DEBUG
#define YGInfoLog(FORMAT, ...) fprintf(stderr, "%s:%zd\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);
#else
#define YGInfoLog(FORMAT, ...) nil
#endif


#ifdef DEBUG
#define YGLog(format, ...) fprintf(stderr, "%s\n", [[NSString stringWithFormat: format, ## __VA_ARGS__] UTF8String]);
#else
#define YGLog(format, ...)
#endif


//#ifdef DEBUG
//# define YGInfoLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
//#else
//# define YGInfoLog(...);
//#endif


// ************** 消除警告 **************
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#endif /* YGCommonUse_h */
