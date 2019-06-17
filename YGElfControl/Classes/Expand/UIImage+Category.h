//
//  UIImage+Category.h
//  YGElfControl
//
//  Created by wuyiguang on 2018/1/7.
//  Copyright © 2018年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)

/**
 缩放图片都指定大小

 @param size CGSize
 @return UIImage
 */
- (UIImage *)scaleToSize:(CGSize)size;

@end
