//
//  YGProduceQRCode.h
//  YGElfControl
//
//  Created by wuyiguang on 2018/3/5.
//  Copyright © 2018年 YG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGProduceQRCode : NSObject

/**
 文字生成二维码

 @param text 需要生成二维码的文字
 @param size 生成的大小
 */
+ (UIImage *)qrCodeText:(NSString *)text size:(CGFloat)size;

@end
