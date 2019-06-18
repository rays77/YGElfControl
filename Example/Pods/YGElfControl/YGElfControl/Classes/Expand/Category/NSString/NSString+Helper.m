//
//  HttpRequest.h
//
//
//  Created by Zhang on 14-6-4.
//  Copyright (c) 2014年 ShengYuan. All rights reserved.
//

#import "NSString+Helper.h"
#import <CommonCrypto/CommonDigest.h>
#import <CoreText/CoreText.h>

@implementation NSString (Helper)

- (BOOL)yg_isNillText
{
    if ([self isEqualToString:@""] ||
        [self isEqualToString:@"NIL"] ||
        [self isEqualToString:@"Nil"] ||
        [self isEqualToString:@"nil"] ||
        [self isEqualToString:@"NULL"] ||
        [self isEqualToString:@"Null"] ||
        [self isEqualToString:@"null"] ||
        [self isEqualToString:@"(NULL)"] ||
        [self isEqualToString:@"(Null)"] ||
        [self isEqualToString:@"(null)"] ||
        [self isEqualToString:@"<NULL>"] ||
        [self isEqualToString:@"<Null>"] ||
        [self isEqualToString:@"<null>"]) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)yg_isEmpty
{
    if (!self)
    {
        return YES;
    }
    else
    {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [self stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] <= 0)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
}

- (NSString *)trimString
{
    // 截断字符串中的所有空白字符（空格,\t,\n,\r）
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)appendToDocumentDir
{
    NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    return [docDir stringByAppendingPathComponent:self];
}

- (NSURL *)appendToDocumentURL
{
    return [NSURL fileURLWithPath:[self appendToDocumentDir]];
}

- (NSString *)base64EncodedString_al
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)base64DecodeString_al
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *)appendDateTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    
    return [NSString stringWithFormat:@"%@%@", self, str];
}

- (NSString *)MD5Hash
{
	const char *cStr = [self UTF8String];
	unsigned char result[16];
	CC_MD5(cStr, strlen(cStr), result);
	return [NSString stringWithFormat:
			@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
			result[0], result[1], result[2], result[3],
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]];
}

//+ (NSString*)encryptMD5String:(NSString*)string
//{
//    
//    const char *cStr = [string UTF8String];
//    
//    unsigned char result[32];
//    
//    CC_MD5( cStr, strlen(cStr),result);
//    
//    NSMutableString *hash =[NSMutableString string];
//    
//    for (int i = 0; i < 16; i++)
//        
//        [hash appendFormat:@"%02X", result[i]];
//    
//    return [hash uppercaseString];//此方法输出的是大写，若想要以小写的方式输出，则只需要将最后一行代码改为return [hash lowercaseString];
//    
//}


- (NSString *) URLEncodedString
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                            NULL,
                                            kCFStringEncodingUTF8));
    return encodedString;
}
- (NSString*)URLDecodedString
{
    NSString *result = ( NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                             (CFStringRef)self,
                                                                                                             CFSTR(""),
                                                                                                             kCFStringEncodingUTF8));
    return result;
}
/*! 过滤有表情的字符串 */
- (instancetype)removedEmojiString
{
    NSMutableString* __block buffer = [NSMutableString stringWithCapacity:[self length]];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              [buffer appendString:([substring isEmoji])? @"": substring];
                          }];
    
    return buffer;  
}
- (BOOL)isEmoji {
    const unichar high = [self characterAtIndex: 0];
    
    // Surrogate pair (U+1D000-1F77F)
    if (0xd800 <= high && high <= 0xdbff) {
        const unichar low = [self characterAtIndex: 1];
        const int codepoint = ((high - 0xd800) * 0x400) + (low - 0xdc00) + 0x10000;
        
        return (0x1d000 <= codepoint && codepoint <= 0x1f77f);
        
        // Not surrogate pair (U+2100-27BF)
    } else {
        return (0x2100 <= high && high <= 0x27bf);
    }
}
#pragma mark - 图文转字符串（utf8转Unicode）
+(NSString *) utf8ToUnicode:(NSString *)string
{
    NSUInteger length = [string length];
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    for (int i = 0;i < length; i++) {
        unichar _char = [string characterAtIndex:i];
        //判断是否为英文和数字
        if (_char <= '9' && _char >= '0') {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i, 1)]];
        }else if(_char >= 'a' && _char <= 'z')
        {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i, 1)]];
        }else if(_char >= 'A' && _char <= 'Z')
        {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i, 1)]];
        }else
        {
            [s appendFormat:@"\\u%x",[string characterAtIndex:i]];
        }
        
    }
    return s;
}
#pragma mark - 图文转字符串（Unicode转utf8）
-(NSString *) unicodeToUtf8:(NSString *)string
{
    NSString *tempStr1 = [string stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"" withString:@"\\"];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    
    //NSLog(@"Output = %@", returnStr);
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
    
}

+ (BOOL)compareVersionWithCurrentV:(NSString *)currentVersion lastV:(NSString *)lastVersion
{
    NSString *str = @"V";
    BOOL flag = NO; //current < last
    NSMutableString *currentV = [NSMutableString stringWithString:currentVersion];
    if ([currentV rangeOfString:str].length) {
        [currentV replaceOccurrencesOfString:str withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange([currentV rangeOfString:str].location, [currentV rangeOfString:str].length)];
    }
    [currentV replaceOccurrencesOfString:@"." withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, currentV.length)];
    NSMutableString *lastV = [NSMutableString stringWithString:lastVersion];
    if ([lastV rangeOfString:str].length) {
        [lastV replaceOccurrencesOfString:str withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange([lastV rangeOfString:str].location, [lastV rangeOfString:str].length)];
    }
    [lastV replaceOccurrencesOfString:@"." withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, lastV.length)];
    if ([lastV intValue] > [currentV intValue]) {
        flag = YES;
    }
    return flag;
}

+ (BOOL)isContainsEmoji:(NSString *)string {
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    isEomji = YES;
                }
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                isEomji = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                isEomji = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                isEomji = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                isEomji = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                isEomji = YES;
            }
            if (!isEomji && substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    isEomji = YES;
                }
            }
        }
    }];
    return isEomji;
}

-(NSMutableAttributedString *)changePartString:(NSString *)partStr textColor:(UIColor *)textColor font:(UIFont *)font
{
    NSString *string = self;
    NSString *changeStr = partStr ? partStr:@"";
    NSRange range = [self rangeOfString:changeStr];

    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];

    if (range.length > 0) {
        NSMutableDictionary *attributeDic = [NSMutableDictionary dictionary];
        if (textColor != nil) {
            [attributeDic setObject:textColor forKey:NSForegroundColorAttributeName];
        }
        if (font != nil) {
            [attributeDic setObject:font forKey:NSFontAttributeName];
        }
        [str addAttributes:attributeDic range:NSMakeRange(range.location,changeStr.length)];
    }
    return str;
}

- (NSMutableAttributedString *)differentString:(NSString *)string attributedDic:(NSDictionary *)atriDic
{
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:self];
    
    NSRange range = [self rangeOfString:string];
    
    if (range.location != NSNotFound) {
        [attri addAttributes:atriDic range:range];
    }
    
    return attri;
}

- (NSMutableAttributedString *)differentMores:(NSArray<NSString *> *)mores attributedDicMores:(NSArray<NSDictionary *> *)attriDicMores
{
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:self];
    
    if (mores.count == attriDicMores.count) {
        for (int i = 0; i < mores.count; i++) {
            NSRange range = [self rangeOfString:mores[i]];
            
            if (range.location != NSNotFound) {
                [attri addAttributes:attriDicMores[i] range:range];
            }
        }
    }
    
    return attri;
}

/**
 *  设置行距和字间距
 *
 *  @param lineSpacing       行距
 *  @param characterSpaceing 字间距
 *  @param attributedString  之前的属性 防止被覆盖
 *
 *  @return AttributedString  返回富文本
 */
- (NSMutableAttributedString *)setAttributedWithLineSpacing:(CGFloat)lineSpacing andCharacterSpaceing:(CGFloat)characterSpaceing attributedString:(NSMutableAttributedString *) attributedString
{
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //设置行距
    [paragraphStyle setLineSpacing:lineSpacing];
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self length])];
    //设置字间距
    long   number = characterSpaceing;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt64Type,&number);
    [attributedString addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[attributedString length])];
    CFRelease(num);
    
    return attributedString;
}

/**
 * 计算文字的宽高
 */
- (CGSize)yg_boundingFont:(UIFont *)font maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight
{
    NSDictionary *attrs = @{NSFontAttributeName: font};
    CGSize size = [self boundingRectWithSize:CGSizeMake(maxWidth, maxHeight) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:attrs context:nil].size;
    return size;
    //    return ceil(itemWidth);
}

@end
