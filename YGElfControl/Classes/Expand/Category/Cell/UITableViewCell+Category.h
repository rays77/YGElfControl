//
//  UITableViewCell+Category.h
//  YGElfControl
//
//  Created by wuyiguang on 2018/1/14.
//  Copyright © 2018年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (Category)

+ (NSString *)cellId;

+ (void)registerClass:(UITableView *)tableView;

+ (void)registerNib:(UITableView *)tableView;

+ (instancetype)dequeue:(UITableView *)tableView
              indexPath:(NSIndexPath *)indexPath;

@end
