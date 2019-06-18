//
//  YGNoDataView.m
//  NewLeGo
//
//  Created by wuyiguang on 2018/3/7.
//  Copyright © 2018年 YG. All rights reserved.
//

#import "YGNoDataView.h"
#import <Masonry/Masonry.h>

typedef NS_ENUM(NSInteger, YGNoDataViewType) {
    NullImage, /**< 空图片提示，default */
    Title, /**< 只显示标题 */
    TopTitleAndNullImage, /**< 上面标题 + 空图片提示 */
    BottomTitleAndNullImage, /**< 空图片提示 + 下面标题 */
    TopAndBottomTitleAndNullImage, /**< 上面标题 + 空图片提示 + 下面标题 */
};


@interface YGNoDataView ()
@property (nonatomic,   weak)   UIView *toView;

/** 顶部显示的标题 */
@property (nonatomic, strong) UILabel *topAlertLbl;

/** 底部显示的标题 */
@property (nonatomic, strong) UILabel *bottomAlertLbl;

/** 无数据提示的图片 */
@property (nonatomic, strong) UIImageView *nullImageView;

/** view的展示样式 */
@property (nonatomic, assign) YGNoDataViewType noDataViewType;

/** 上下偏移，默认中间 */
@property (nonatomic, assign) CGFloat offsetY;

/** 左右偏移，默认中间 */
@property (nonatomic, assign) CGFloat offsetX;

@property (nonatomic, assign) CGSize noDataSize;

@property (nonatomic,   copy) YGNoDataViewTapBlock tapBlock;
@end

@implementation YGNoDataView

- (instancetype)init {
    if (self = [super init]) {
        [self initUI];
        [self initData];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initUI];
        [self initData];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

+ (instancetype)showOnlyTitle:(NSString *)title toView:(UIView *)toView offsetY:(CGFloat)offsetY size:(CGSize)size tapBlock:(YGNoDataViewTapBlock)tapBlock {
    return [self type:Title topTitle:nil bottomTitle:title nullImage:nil offsetY:offsetY size:size toView:toView tapBlock:tapBlock];
}

+ (instancetype)showOnlyNullImage:(NSString *)nullImage toView:(UIView *)toView offsetY:(CGFloat)offsetY size:(CGSize)size tapBlock:(YGNoDataViewTapBlock)tapBlock {
    return [self type:NullImage topTitle:nil bottomTitle:nil nullImage:nullImage offsetY:offsetY size:size toView:toView tapBlock:tapBlock];
}

+ (instancetype)showNullImage:(NSString *)nullImage topTitle:(NSString *)topTitle toView:(UIView *)toView offsetY:(CGFloat)offsetY size:(CGSize)size tapBlock:(YGNoDataViewTapBlock)tapBlock {
    return [self type:TopTitleAndNullImage topTitle:topTitle bottomTitle:nil nullImage:nullImage offsetY:offsetY size:size toView:toView tapBlock:tapBlock];
}

+ (instancetype)showNullImage:(NSString *)nullImage bottomTitle:(NSString *)bottomTitle toView:(UIView *)toView offsetY:(CGFloat)offsetY size:(CGSize)size tapBlock:(YGNoDataViewTapBlock)tapBlock {
    return [self type:BottomTitleAndNullImage topTitle:nil bottomTitle:bottomTitle nullImage:nullImage offsetY:offsetY size:size toView:toView tapBlock:tapBlock];
}

+ (instancetype)showNullImage:(NSString *)nullImage topTitle:(NSString *)topTitle bottomTitle:(NSString *)bottomTitle toView:(UIView *)toView offsetY:(CGFloat)offsetY size:(CGSize)size tapBlock:(YGNoDataViewTapBlock)tapBlock {
    return [self type:TopAndBottomTitleAndNullImage topTitle:topTitle bottomTitle:bottomTitle nullImage:nullImage offsetY:offsetY size:size toView:toView tapBlock:tapBlock];
}

/**
 统一创建
 */
+ (instancetype)type:(YGNoDataViewType)type topTitle:(NSString *)topTitle bottomTitle:(NSString *)bottomTitle nullImage:(NSString *)nullImage offsetY:(CGFloat)offsetY size:(CGSize)size toView:(UIView *)toView tapBlock:(YGNoDataViewTapBlock)tapBlock {
    YGNoDataView *noView = [[YGNoDataView alloc] init];
    noView.noDataSize = size;
    noView.noDataViewType = type;
    noView.topAlertLbl.text = topTitle;
    noView.bottomAlertLbl.text = bottomTitle;
    noView.nullImageView.image = [UIImage imageNamed:nullImage];
    noView.offsetY = offsetY;
    noView.toView = toView;
    noView.tapBlock = tapBlock;
    [toView addSubview:noView];
    
    [noView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(size.width);
        make.height.mas_equalTo(size.height);
        if (offsetY) {
            make.centerX.mas_equalTo(toView);
            make.centerY.mas_equalTo(offsetY);
        } else {
            make.center.mas_equalTo(toView);
        }
    }];
    
    return noView;
}

- (void)initUI
{
    self.nullImageView = [[UIImageView alloc] init];
    self.nullImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.nullImageView];
    
    self.topAlertLbl = [[UILabel alloc] init];
    self.topAlertLbl.text = @"温馨提示";
    self.topAlertLbl.font = [UIFont systemFontOfSize:15];
    self.topAlertLbl.textAlignment = NSTextAlignmentCenter;
    self.topAlertLbl.textColor = [UIColor blackColor];
    [self addSubview:self.topAlertLbl];
    
    self.bottomAlertLbl = [[UILabel alloc] init];
    self.bottomAlertLbl.text = @"亲，没有数据哦！";
    self.bottomAlertLbl.font = [UIFont systemFontOfSize:15];
    self.bottomAlertLbl.textAlignment = NSTextAlignmentCenter;
    self.bottomAlertLbl.textColor = [UIColor blackColor];
    [self addSubview:self.bottomAlertLbl];
    
    [self addTapToView:self];
}

- (void)initData
{
    _noDataViewType = NullImage;
    _offsetX = 0.0;
    _offsetY = 0.0;
}

- (void)topTitleFont:(UIFont *)font color:(UIColor *)color {
    self.topAlertLbl.font = font;
    self.topAlertLbl.textColor = color;
}

- (void)bottomTitleFont:(UIFont *)font color:(UIColor *)color {
    self.bottomAlertLbl.font = font;
    self.bottomAlertLbl.textColor = color;
}

- (void)setNoDataViewType:(YGNoDataViewType)noDataViewType
{
    _noDataViewType = noDataViewType;
    
    switch (self.noDataViewType) {
        case Title: // 只显示标题
        {
            [self.topAlertLbl removeFromSuperview];
            self.topAlertLbl = nil;
            
            [self.nullImageView removeFromSuperview];
            self.nullImageView = nil;
            
            [self.bottomAlertLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(self);
            }];
        }
            break;
            
        case TopTitleAndNullImage: // 上面标题 + 空图片提示
        {
            [self.bottomAlertLbl removeFromSuperview];
            self.bottomAlertLbl = nil;
            
            [self.nullImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(self);
                make.width.mas_equalTo(self.noDataSize.width);
                make.height.mas_equalTo(self.noDataSize.height-40);
            }];
            
            [self.topAlertLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self);
                make.bottom.mas_equalTo(self.nullImageView.mas_top).offset(-8);
            }];
        }
            break;
            
        case BottomTitleAndNullImage: // 空图片提示 + 下面标题
        {
            [self.topAlertLbl removeFromSuperview];
            self.topAlertLbl = nil;
            
            [self.nullImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(self);
                make.width.mas_equalTo(self.noDataSize.width);
                make.height.mas_equalTo(self.noDataSize.height-40);
            }];
            
            [self.bottomAlertLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self);
                make.top.mas_equalTo(self.nullImageView.mas_bottom).offset(8);
            }];
        }
            break;
            
        case TopAndBottomTitleAndNullImage: // 上面标题 + 空图片提示 + 下面标题
        {
            [self.nullImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(self);
                make.width.mas_equalTo(self.noDataSize.width);
                make.height.mas_equalTo(self.noDataSize.height-40);
            }];
            
            [self.topAlertLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self);
                make.bottom.mas_equalTo(self.nullImageView.mas_top).offset(-8);
            }];
            
            [self.bottomAlertLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self);
                make.top.mas_equalTo(self.nullImageView.mas_bottom).offset(8);
            }];
        }
            break;
            
        default: // 空图片提示，default
        {
            [self.topAlertLbl removeFromSuperview];
            self.topAlertLbl = nil;
            
            [self.bottomAlertLbl removeFromSuperview];
            self.bottomAlertLbl = nil;
            
            [self.nullImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(self);
                make.width.mas_equalTo(self.noDataSize.width);
                make.height.mas_equalTo(self.noDataSize.height-40);
            }];
        }
            break;
    }
}

- (void)addTapToView:(UIView *)toView
{
    toView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle)];
    [toView addGestureRecognizer:tap];
}

- (void)tapHandle
{
    if (self.tapBlock) {
        self.tapBlock();
    }
}

@end
