//
//  YGBanner.h
//  ScrollView循环滚到-2
//
//  Created by wuyiguang on 16/1/8.
//  Copyright (c) 2016年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGBannerModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imgUrl;

/*! 普通模型转换成YGBannerModel */
+ (NSArray *)modelTransform:(NSArray *)models;

@end


// ===========================================================


typedef void(^imageHandle)(NSInteger index);

typedef NS_ENUM(NSInteger, YGBannerPagePositionType) {
    YGBannerPagePositionTypeCenter,
    YGBannerPagePositionTypeLeft,
    YGBannerPagePositionTypeRight,
};

@interface YGBanner : UIView

/*! 自动滚屏，默认自动 */
@property (nonatomic, assign) BOOL autoTimer;
/*! 每个多久滚动一次， 默认4秒 */
@property (nonatomic, assign) NSTimeInterval timerInterval;
/*! UIPageControl位置，默认居中 */
@property (nonatomic, assign) YGBannerPagePositionType pagePostionType;
/*! 图片显示模式 */
@property (nonatomic, assign) UIViewContentMode imageContentModel;
/*! 默认显示的图片 */
@property (nonatomic, strong) UIImage *placeholderImage;
/*! UIPageControl选择颜色 */
@property (nonatomic, strong) UIColor *selPageColor;
/*! UIPageControl未选择颜色 */
@property (nonatomic, strong) UIColor *norPageColor;
/*! 图片点击事件回调 */
@property (nonatomic, copy) imageHandle bannerHandle;

/**
 *  YGBanner实例方法
 */
- (instancetype)init;

/**
 *  刷新轮播上的UI显示
 *
 *  @param models 传入YGBannerModel模型数组
 */
- (void)reloadYGBanner:(NSArray *)models;

@end
