//
//  UIFont+Fit.m
//  YGElfControl
//
//  Created by wuyiguang on 2018/1/14.
//  Copyright © 2018年 YG. All rights reserved.
//

#import "UIFont+Fit.h"

@implementation UIFont (Fit)

+ (UIFont *)yg_systemOfSize:(CGFloat)size {
    CGFloat fontSize = size;
    if (yg_iPhone4 || yg_iPhone4s || yg_iPhone5) {
        fontSize = size;
    } else if (yg_iPhone6) {
        fontSize = size + 1.0;
    } else {
        fontSize = size + 2.0;
    }
    return [UIFont systemFontOfSize:fontSize];
}

+ (UIFont *)yg_boldSystemOfSize:(CGFloat)size {
    CGFloat fontSize = size;
    if (yg_iPhone4 || yg_iPhone4s || yg_iPhone5) {
        fontSize = size;
    } else if (yg_iPhone6) {
        fontSize = size + 1.0;
    } else {
        fontSize = size + 2.0;
    }
    return [UIFont boldSystemFontOfSize:fontSize];
}

@end
