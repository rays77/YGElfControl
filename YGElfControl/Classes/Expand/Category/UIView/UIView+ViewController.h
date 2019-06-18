//
//  UIView+ViewController.h
//  YGElfControl
//
//  Created by wuyiguang on 2018/1/7.
//  Copyright © 2018年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ViewController)

- (UIViewController *)yg_viewController;

/**
 获取Window当前显示的ViewController
 */
+ (UIViewController *)yg_topViewController;

@end
