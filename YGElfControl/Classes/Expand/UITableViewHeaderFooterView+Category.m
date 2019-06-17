//
//  UITableViewHeaderFooterView+Category.m
//  YGElfControl
//
//  Created by wuyiguang on 2018/1/16.
//  Copyright © 2018年 YG. All rights reserved.
//

#import "UITableViewHeaderFooterView+Category.h"

@implementation UITableViewHeaderFooterView (Category)

+ (NSString *)cellId {
    return NSStringFromClass([self class]);
}

+ (void)registerClass:(UITableView *)tableView {
    [tableView registerClass:[self class] forHeaderFooterViewReuseIdentifier:[self cellId]];
}

+ (void)registerNib:(UITableView *)tableView {
    UINib *nib = [UINib nibWithNibName:[self cellId] bundle:nil];
    [tableView registerNib:nib forHeaderFooterViewReuseIdentifier:[self cellId]];
}

+ (instancetype)dequeue:(UITableView *)tableView {
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:[self cellId]];
}

@end
