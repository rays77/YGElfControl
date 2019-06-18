//
//  YGBanner.m
//  ScrollView循环滚到-2
//
//  Created by wuyiguang on 16/1/8.
//  Copyright (c) 2016年 YG. All rights reserved.
//

#import "YGBanner.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation YGBannerModel

+ (NSArray *)modelTransform:(NSArray *)models {
    NSMutableArray *list = [[NSMutableArray alloc] initWithCapacity:models.count];
//    for (ALClassModel *model in models) {
//        YGBannerModel *ygModel = [[YGBannerModel alloc] init];
//
//        CGFloat width = kScreenWidth * 3;
//        NSString *size = kCutNetImageSizeStirng(width, 0.304*kScreenHeight*3);
//
//        ygModel.imgUrl = [[model.src restructURLStrWithPicSize:size] absoluteString];
//        ygModel.title = model.title;
//        [list addObject:ygModel];
//    }
    return list;
}

@end

// ===========================================================

@interface YGBanner () <UIScrollViewDelegate>

@end

@implementation YGBanner
{
    UIScrollView *_sv;
    UIPageControl *_pgCtrl;
    UIImageView *_leftView; // 左边的图片
    UIImageView *_centerView; // 中间的图片
    UIImageView *_rightView; // 右边的图片;
    UILabel *_titleLbl; // 标题
    NSArray *_models; // 轮播显示的模型
    NSTimer *_timer;
    NSInteger _currIndex; // 当前下标
    CGSize _size; // scollView的宽高
}

- (instancetype)init
{
    if (self = [super init]) {
        [self instance];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self instance];
    }
    return self;
}

// 初始化
- (void)instance
{
    _pagePostionType = YGBannerPagePositionTypeCenter;
    _imageContentModel = UIViewContentModeScaleToFill;
    _autoTimer = YES;
    _timerInterval = 4;
    
    // 记录
    _currIndex = 0;
    
    // 实例化ScrollView
    _sv = [[UIScrollView alloc] init];
    _sv.pagingEnabled = YES;
    _sv.bounces = NO;
    _sv.showsHorizontalScrollIndicator = NO;
    _sv.showsVerticalScrollIndicator = NO;
    _sv.delegate = self;
    [self addSubview:_sv];
    
    // 添加tap手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle)];
    
    [_sv addGestureRecognizer:tap];
    
    
    // 标题
    //        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(_sv.frame.origin.x, CGRectGetMaxY(_sv.frame)-30, _sv.bounds.size.width, 30)];
    //        _titleLbl.font = [UIFont systemFontOfSize:14];
    //        _titleLbl.textColor = [UIColor whiteColor];
    //        _titleLbl.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    //        [self addSubview:_titleLbl];
    
    // 实例化PageControl
    _pgCtrl = [[UIPageControl alloc] init];
    _pgCtrl.enabled = NO;
    [self addSubview:_pgCtrl];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_models.count == 0) {
        return;
    }
    
    _size = self.bounds.size;
    _sv.frame = CGRectMake(0, 0, _size.width, _size.height);
    
    // 通过 numberOfPages 获取控件 size
    CGSize pgSize = [_pgCtrl sizeForNumberOfPages:_pgCtrl.numberOfPages];
    
    switch (_pagePostionType) {
        case YGBannerPagePositionTypeLeft:
            _pgCtrl.frame = CGRectMake(12, _size.height-30, pgSize.width, 30);
            break;
            
        case YGBannerPagePositionTypeCenter:
            _pgCtrl.frame = CGRectMake(12, _size.height-30, _size.width-24, 30);
            break;
            
        case YGBannerPagePositionTypeRight:
            _pgCtrl.frame = CGRectMake(_size.width-pgSize.width-12, _size.height-30, pgSize.width, 30);
            break;
            
        default:
            break;
    }
    
    UIView *singView = [self viewWithTag:5555];
    if (singView) singView.frame = CGRectMake(0, 0, _size.width, _size.height);
    if (_leftView) _leftView.frame = CGRectMake(0, 0, _size.width, _size.height);
    if (_centerView) _centerView.frame = CGRectMake(_size.width, 0, _size.width, _size.height);
    if (_rightView) _rightView.frame = CGRectMake(_size.width * 2, 0, _size.width, _size.height);
    
    if (_models.count == 1) {
        // 一屏
        _sv.contentSize = _sv.bounds.size;
        
    } else {
        // 三屏循环滚到
        _sv.contentSize = CGSizeMake(_sv.bounds.size.width * 3, _sv.bounds.size.height);
        [_sv setContentOffset:CGPointMake(_size.width, 0) animated:NO];
    }
    
    if (_selPageColor) {
        _pgCtrl.currentPageIndicatorTintColor = _selPageColor;
    }
    
    if (_norPageColor) {
        _pgCtrl.pageIndicatorTintColor = _norPageColor;
    }
}

// 刷新模型
- (void)reloadYGBanner:(NSArray *)models
{
    if (models.count == 0) {
        NSLog(@"YGBannerModel模型数组不能为空");
        return;
    }
    
//    NSArray *tmpModels = [YGBannerModel modelTransform:models];
    NSArray *tmpModels = models;
    
    if (tmpModels.count == 0) {
        return;
    }
    
    _models = tmpModels;
    
    [self layoutSubviews];
    
    _currIndex = 0;
    
    YGBannerModel *model = _models[_currIndex];
    
    _titleLbl.text = [NSString stringWithFormat:@"  %@", model.title];
    
    // 点的个数为数组的count
    _pgCtrl.numberOfPages = _models.count;
    _pgCtrl.currentPage = 0;
    _pgCtrl.hidesForSinglePage = NO;
    
    // 移除之前的banner
    for (int i = 0; i < 3; i++) {
        UIView *tmpV = [_sv viewWithTag:5555+i];
        [tmpV removeFromSuperview];
        tmpV = nil;
    }
    
    [self createView];
    
    // 开启定时器
    [_timer invalidate];
    _timer = nil;
    [self startTimer];
}

- (void)createView
{
    if (_models.count == 1) {
        // 一屏
        _sv.contentSize = _sv.bounds.size;
        [self instanceSingleImageView];
        
        // 一屏时默认不自动滚屏
        _autoTimer = NO;
        
    } else {
        // 三屏循环滚到
        _sv.contentSize = CGSizeMake(_sv.bounds.size.width * 3, _sv.bounds.size.height);
        [self instanceImageView];
    }
}

// tap手势
- (void)tapHandle
{
    if (self.bannerHandle) {
        self.bannerHandle(_currIndex);
    }
}

- (void)instanceSingleImageView
{
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _size.width, _size.height)];
    imageV.contentMode = _imageContentModel;
    imageV.tag = 5555;
    [_sv addSubview:imageV];
    
    YGBannerModel *model = [_models lastObject];
    NSURL *url = [NSURL URLWithString:model.imgUrl];
    [imageV sd_setImageWithURL:url placeholderImage:_placeholderImage];
}

/**
 *  实例化三个图片
 */
- (void)instanceImageView
{
    // 只有三屏
    for (int i = 0; i < 3; i++) {
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(_size.width * i, 0, _size.width, _size.height)];
        imageV.contentMode = _imageContentModel;
        imageV.tag = 5555+i;
        [_sv addSubview:imageV];
        
        YGBannerModel *model = nil;
        
        // 最后一张图
        if (i == 0) {
            
            model = [_models lastObject];
            _leftView = imageV;
            
        } else if (i == 1) {
            
            // 中间的图片，第一张图
            model = [_models firstObject];
            _centerView = imageV;
            
        } else {
            
            // 右边的图片，第二张
            model = _models[1];
            _rightView = imageV;
        }
        
        NSURL *url = [NSURL URLWithString:model.imgUrl];
        [imageV sd_setImageWithURL:url placeholderImage:_placeholderImage];
    }
    
    // 滚动到中间这张图
    [_sv setContentOffset:CGPointMake(_size.width, 0) animated:NO];
}

/**
 *  开启定时器
 */
- (void)startTimer
{
    if (_autoTimer == NO) {
        return;
    }
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:_timerInterval target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

/**
 *  自动滚屏
 */
- (void)autoScroll
{
    // 滚动到下一屏
    [_sv setContentOffset:CGPointMake(_size.width * 2, 0) animated:YES];
    
    // 重新设置图片
    [self reloadImageView];
}

/**
 重新设置图片
 */
- (void)reloadImageView
{
    // 获取x的偏移量
    CGFloat offsetX = _sv.contentOffset.x;
    
    // 向左滑动
    if (offsetX > _size.width) {
        _currIndex = (_currIndex + 1) % _models.count;
    } else if (offsetX < _size.width) {
        // 向右滑动
        _currIndex = (_currIndex - 1 + _models.count) % _models.count;
    }
    
    NSInteger leftIndex = (_currIndex - 1 + _models.count) % _models.count;
    NSInteger rightIndex = (_currIndex + 1) % _models.count;
    
    // 重新设置图片
    YGBannerModel *model = _models[leftIndex];
    NSURL *url = [NSURL URLWithString:model.imgUrl];
    [_leftView sd_setImageWithURL:url placeholderImage:_placeholderImage];
    
    model = _models[_currIndex];
    url = [NSURL URLWithString:model.imgUrl];
    [_centerView sd_setImageWithURL:url placeholderImage:_placeholderImage];
    
    model = _models[rightIndex];
    url = [NSURL URLWithString:model.imgUrl];
    [_rightView sd_setImageWithURL:url placeholderImage:_placeholderImage];
}

- (void)positionView
{
    [self reloadImageView];
    
    _pgCtrl.currentPage = _currIndex;
    
    YGBannerModel *model = _models[_currIndex];
    
    _titleLbl.text = [NSString stringWithFormat:@"  %@", model.title];
    
    // 滚动到中间
    [_sv setContentOffset:CGPointMake(_size.width, 0) animated:NO];
}

#pragma mark - UIScrollViewDelegate

// 拖动时，停止减速会被调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self positionView];
    
    [self startTimer];
}

// 当设置setContentOffset且为YES时被调用，手势拖动不会调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (_models.count>0) {
        [self positionView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
    _timer = nil;
}

@end
