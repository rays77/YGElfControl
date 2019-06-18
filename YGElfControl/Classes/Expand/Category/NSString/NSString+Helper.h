///
//  HttpRequest.h
//  AutoHome
//
//  Created by Zhang on 14-6-4.
//  Copyright (c) 2014年 ShengYuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helper)

- (BOOL)yg_isNillText;

/**
 *  判断是否全是空格
 *
 *  @return Bool
 */
- (BOOL)yg_isEmpty;

/**
 *  截断收尾空白字符
 *
 *  @return 截断结果
 */
- (NSString *)trimString;

/**
 *  为指定文件名添加沙盒文档路径
 *
 *  @return 添加沙盒文档路径的完整路径字符串
 */
- (NSString *)appendToDocumentDir;

/**
 *  为指定文件名添加沙盒文档路径
 *
 *  @return 添加沙盒文档路径的完整路径字符串
 */
- (NSURL *)appendToDocumentURL;

/**
 *  对指定字符串进行BASE64编码
 *
 *  @return BASE64编码后的字符串
 */
- (NSString *)base64EncodedString_al;

/**
 *  对指定BASE64编码的字符串进行解码
 *
 *  @return 解码后的字符串
 */
- (NSString *)base64DecodeString_al;

/**
 *  在字符串末尾添加日期及时间
 *
 *  @return 添加日期及时间之后的字符串
 */
- (NSString *)appendDateTime;

- (NSString *)MD5Hash;

- (NSString *) URLEncodedString;
- (NSString *) URLDecodedString;
- (NSString *) unicodeToUtf8:(NSString *)string;
/*! 过滤有表情的字符串 */
- (instancetype)removedEmojiString;
/**
 *  用于AppStore更新，比较两个版本大小
 *
 *  @param currentVersion 当前版本（project的版本）
 *  @param lastVersion    最新版本（app store的版本）
 *
 *  @return YES 最新版本 > 当前版本 需更新;NO 是最新版本 <= 当前版本 不用跟新
 */
+ (BOOL)compareVersionWithCurrentV:(NSString *)currentVersion lastV:(NSString *)lastVersion;

/**
 *  字符串是否包含表情
 *
 *  @param string 要检查的字符串
 *
 *  @return YES 包含表情 NO 是不包含
 */
+ (BOOL)isContainsEmoji:(NSString *)string;

/**
 *  修改字符串中某一段字符串的颜色字体
 *
 *  @param partStr   需要修改的某一段字符串
 *  @param textColor 修改后的颜色
 *  @param font      修改后的字体样式
 *
 *  @return  修改后的值，一定要赋值给self.textLabel.attributedText，如果未找到指定修改的字符串则返回nil值
 */
- (NSMutableAttributedString *)changePartString:(NSString *)partStr textColor:(UIColor *)textColor font:(UIFont *)font;

/**
 单段不同文字样式显示

 @param string 不同的文字
 @param atriDic attributed 属性
 @return NSMutableAttributedString
 */
- (NSMutableAttributedString *)differentString:(NSString *)string attributedDic:(NSDictionary *)atriDic;

/**
 多段不同文字样式显示

 @param mores 不同的文字集合
 @param attriDicMores attributed 属性集合
 @return NSMutableAttributedString
 */
- (NSMutableAttributedString *)differentMores:(NSArray<NSString *> *)mores attributedDicMores:(NSArray<NSDictionary *> *)attriDicMores;

/**
 *  设置行距和字间距
 *
 *  @param lineSpacing       行距
 *  @param characterSpaceing 字间距
 *  @param  attributedString  之前的属性 防止被覆盖
 *
 *  @return AttributedString  返回富文本
 */
- (NSMutableAttributedString *)setAttributedWithLineSpacing:(CGFloat)lineSpacing andCharacterSpaceing:(CGFloat)characterSpaceing attributedString:(NSMutableAttributedString *) attributedString;

/**
 * 计算文字的宽高
 */
- (CGSize)yg_boundingFont:(UIFont *)font maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight;

@end
