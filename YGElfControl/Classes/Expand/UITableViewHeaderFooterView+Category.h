//
//  UITableViewHeaderFooterView+Category.h
//  YGElfControl
//
//  Created by wuyiguang on 2018/1/16.
//  Copyright © 2018年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewHeaderFooterView (Category)

+ (NSString *)cellId;

+ (void)registerClass:(UITableView *)tableView;

+ (void)registerNib:(UITableView *)tableView;

+ (instancetype)dequeue:(UITableView *)tableView;

@end
