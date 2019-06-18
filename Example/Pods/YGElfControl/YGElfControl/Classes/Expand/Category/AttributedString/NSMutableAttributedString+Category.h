//
//  NSMutableAttributedString+Category.h
//  YGElfControl
//
//  Created by wuyiguang on 2018/1/17.
//  Copyright © 2018年 YG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (Category)

+ (NSMutableAttributedString *)yg_logo:(NSString *)logo
                              logoRect:(CGRect)rect
                                  text:(NSString *)text;

@end
