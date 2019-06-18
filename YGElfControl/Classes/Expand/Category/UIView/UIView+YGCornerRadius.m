//
//  UIView+YGCornerRadius.h
//  YGElfControl
//
//  Created by wuyiguang on 2018/1/7.
//  Copyright © 2018年 YG. All rights reserved.
//

#import "UIView+YGCornerRadius.h"
#import <objc/runtime.h>

@implementation NSObject (_YGAddRuntime)

+ (void)yg_swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel {
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    if (!originalMethod || !newMethod) return;
    method_exchangeImplementations(originalMethod, newMethod);
}

- (void)yg_setAssociateValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)yg_getAssociatedValueForKey:(void *)key {
    return objc_getAssociatedObject(self, key);
}

- (void)yg_removeAssociateWithKey:(void *)key {
    objc_setAssociatedObject(self, key, nil, OBJC_ASSOCIATION_ASSIGN);
}

@end

@implementation UIImage (YGCornerRadius)

+ (UIImage *)yg_imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock {
    if (!drawBlock) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) return nil;
    drawBlock(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)yg_maskRoundCornerRadiusImageWithColor:(UIColor *)color cornerRadii:(CGSize)cornerRadii size:(CGSize)size corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    return [UIImage yg_imageWithSize:size drawBlock:^(CGContextRef  _Nonnull context) {
        CGContextSetLineWidth(context, 0);
        [color set];
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:CGRectInset(rect, -0.3, -0.3)];
        UIBezierPath *roundPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 0.3, 0.3) byRoundingCorners:corners cornerRadii:cornerRadii];
        [rectPath appendPath:roundPath];
        CGContextAddPath(context, rectPath.CGPath);
        CGContextEOFillPath(context);
        if (!borderColor || !borderWidth) return;
        [borderColor set];
        UIBezierPath *borderOutterPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:cornerRadii];
        UIBezierPath *borderInnerPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) byRoundingCorners:corners cornerRadii:cornerRadii];
        [borderOutterPath appendPath:borderInnerPath];
        CGContextAddPath(context, borderOutterPath.CGPath);
        CGContextEOFillPath(context);
    }];
}

@end


static void *const _YGMaskCornerRadiusLayerKey = "_YGMaskCornerRadiusLayerKey";
static NSMutableSet<UIImage *> *maskCornerRaidusImageSet;

@implementation CALayer (CornerRadius)

+ (void)load {
    [CALayer yg_swizzleInstanceMethod:@selector(layoutSublayers) with:@selector(_yg_layoutSublayers)];
}

- (UIImage *)contentImage{
    return [UIImage imageWithCGImage:(__bridge CGImageRef)self.contents];
}

- (void)setContentImage:(UIImage *)contentImage{
    self.contents = (__bridge id)contentImage.CGImage;
}

- (void)yg_cornerRadius:(CGFloat)radius cornerColor:(UIColor *)color{
    [self yg_cornerRadius:radius cornerColor:color corners:UIRectCornerAllCorners];
}

- (void)yg_cornerRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners{
    [self yg_cornerRadiusWithCornerRadii:CGSizeMake(radius, radius) cornerColor:color corners:corners borderColor:nil borderWidth:0];
}

- (void)yg_cornerRadiusWithCornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    if (!color) return;
    CALayer *cornerRadiusLayer = [self yg_getAssociatedValueForKey:_YGMaskCornerRadiusLayerKey];
    if (!cornerRadiusLayer) {
        cornerRadiusLayer = [CALayer new];
        cornerRadiusLayer.opaque = YES;
        [self yg_setAssociateValue:cornerRadiusLayer withKey:_YGMaskCornerRadiusLayerKey];
    }
    if (color) {
        [cornerRadiusLayer yg_setAssociateValue:color withKey:"_yg_cornerRadiusImageColor"];
    }else{
        [cornerRadiusLayer yg_removeAssociateWithKey:"_yg_cornerRadiusImageColor"];
    }
    [cornerRadiusLayer yg_setAssociateValue:[NSValue valueWithCGSize:cornerRadii] withKey:"_yg_cornerRadiusImageRadius"];
    [cornerRadiusLayer yg_setAssociateValue:@(corners) withKey:"_yg_cornerRadiusImageCorners"];
    if (borderColor) {
        [cornerRadiusLayer yg_setAssociateValue:borderColor withKey:"_yg_cornerRadiusImageBorderColor"];
    }else{
        [cornerRadiusLayer yg_removeAssociateWithKey:"_yg_cornerRadiusImageBorderColor"];
    }
    [cornerRadiusLayer yg_setAssociateValue:@(borderWidth) withKey:"_yg_cornerRadiusImageBorderWidth"];
    UIImage *image = [self _yg_getCornerRadiusImageFromSet];
    if (image) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        cornerRadiusLayer.contentImage = image;
        [CATransaction commit];
    }
    
}

- (UIImage *)_yg_getCornerRadiusImageFromSet{
    if (!self.bounds.size.width || !self.bounds.size.height) return nil;
    CALayer *cornerRadiusLayer = [self yg_getAssociatedValueForKey:_YGMaskCornerRadiusLayerKey];
    UIColor *color = [cornerRadiusLayer yg_getAssociatedValueForKey:"_yg_cornerRadiusImageColor"];
    if (!color) return nil;
    CGSize radius = [[cornerRadiusLayer yg_getAssociatedValueForKey:"_yg_cornerRadiusImageRadius"] CGSizeValue];
    NSUInteger corners = [[cornerRadiusLayer yg_getAssociatedValueForKey:"_yg_cornerRadiusImageCorners"] unsignedIntegerValue];
    CGFloat borderWidth = [[cornerRadiusLayer yg_getAssociatedValueForKey:"_yg_cornerRadiusImageBorderWidth"] floatValue];
    UIColor *borderColor = [cornerRadiusLayer yg_getAssociatedValueForKey:"_yg_cornerRadiusImageBorderColor"];
    if (!maskCornerRaidusImageSet) {
        maskCornerRaidusImageSet = [NSMutableSet new];
    }
    __block UIImage *image = nil;
    [maskCornerRaidusImageSet enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, BOOL * _Nonnull stop) {
        CGSize imageSize = [[obj yg_getAssociatedValueForKey:"_yg_cornerRadiusImageSize"] CGSizeValue];
        UIColor *imageColor = [obj yg_getAssociatedValueForKey:"_yg_cornerRadiusImageColor"];
        CGSize imageRadius = [[obj yg_getAssociatedValueForKey:"_yg_cornerRadiusImageRadius"] CGSizeValue];
        NSUInteger imageCorners = [[obj yg_getAssociatedValueForKey:"_yg_cornerRadiusImageCorners"] unsignedIntegerValue];
        CGFloat imageBorderWidth = [[obj yg_getAssociatedValueForKey:"_yg_cornerRadiusImageBorderWidth"] floatValue];
        UIColor *imageBorderColor = [obj yg_getAssociatedValueForKey:"_yg_cornerRadiusImageBorderColor"];
        BOOL isBorderSame = (CGColorEqualToColor(borderColor.CGColor, imageBorderColor.CGColor) && borderWidth == imageBorderWidth) || (!borderColor && !imageBorderColor) || (!borderWidth && !imageBorderWidth);
        BOOL canReuse = CGSizeEqualToSize(self.bounds.size, imageSize) && CGColorEqualToColor(imageColor.CGColor, color.CGColor) && imageCorners == corners && CGSizeEqualToSize(radius, imageRadius) && isBorderSame;
        if (canReuse) {
            image = obj;
            *stop = YES;
        }
    }];
    if (!image) {
        image = [UIImage yg_maskRoundCornerRadiusImageWithColor:color cornerRadii:radius size:self.bounds.size corners:corners borderColor:borderColor borderWidth:borderWidth];
        [image yg_setAssociateValue:[NSValue valueWithCGSize:self.bounds.size] withKey:"_yg_cornerRadiusImageSize"];
        [image yg_setAssociateValue:color withKey:"_yg_cornerRadiusImageColor"];
        [image yg_setAssociateValue:[NSValue valueWithCGSize:radius] withKey:"_yg_cornerRadiusImageRadius"];
        [image yg_setAssociateValue:@(corners) withKey:"_yg_cornerRadiusImageCorners"];
        if (borderColor) {
            [image yg_setAssociateValue:color withKey:"_yg_cornerRadiusImageBorderColor"];
        }
        [image yg_setAssociateValue:@(borderWidth) withKey:"_yg_cornerRadiusImageBorderWidth"];
        [maskCornerRaidusImageSet addObject:image];
    }
    return image;
}

#pragma mark - exchage Methods

- (void)_yg_layoutSublayers{
    [self _yg_layoutSublayers];
    CALayer *cornerRadiusLayer = [self yg_getAssociatedValueForKey:_YGMaskCornerRadiusLayerKey];
    if (cornerRadiusLayer) {
        UIImage *aImage = [self _yg_getCornerRadiusImageFromSet];
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        cornerRadiusLayer.contentImage = aImage;
        cornerRadiusLayer.frame = self.bounds;
        [CATransaction commit];
        [self addSublayer:cornerRadiusLayer];
    }
}

@end

@implementation UIView (YGAddForRoundedCorner)

- (void)yg_cornerRadius:(CGFloat)radius cornerColor:(UIColor *)color{
    [self.layer yg_cornerRadius:radius cornerColor:color];
}

- (void)yg_cornerRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners{
    [self.layer yg_cornerRadius:radius cornerColor:color corners:corners];
}

- (void)yg_cornerRadiusWithCornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    [self.layer yg_cornerRadiusWithCornerRadii:cornerRadii cornerColor:color corners:corners borderColor:borderColor borderWidth:borderWidth];
}

@end
