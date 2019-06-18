//
//  NSMutableAttributedString+Category.m
//  YGElfControl
//
//  Created by wuyiguang on 2018/1/17.
//  Copyright © 2018年 YG. All rights reserved.
//

#import "NSMutableAttributedString+Category.h"

@implementation NSMutableAttributedString (Category)

+ (NSMutableAttributedString *)yg_logo:(NSString *)logo
                              logoRect:(CGRect)rect
                                  text:(NSString *)text {
    NSMutableAttributedString *mutaAttri = [[NSMutableAttributedString alloc] initWithString:text];
    
    // 添加图片
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = [UIImage imageNamed:logo];
    attch.bounds = rect;
    
    // 创建富文本添加图片
    NSAttributedString *attri = [NSAttributedString attributedStringWithAttachment:attch];
    // 在第0个位置插入图片
    [mutaAttri insertAttributedString:attri atIndex:0];
    
    return mutaAttri;
}

@end
