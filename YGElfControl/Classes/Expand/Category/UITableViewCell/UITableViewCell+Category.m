//
//  UITableViewCell+Category.m
//  YGElfControl
//
//  Created by wuyiguang on 2018/1/14.
//  Copyright © 2018年 YG. All rights reserved.
//

#import "UITableViewCell+Category.h"

@implementation UITableViewCell (Category)

+ (NSString *)cellId {
    return NSStringFromClass([self class]);
}

+ (void)registerClass:(UITableView *)tableView {
    [tableView registerClass:[self class] forCellReuseIdentifier:[self cellId]];
}

+ (void)registerNib:(UITableView *)tableView {
    UINib *nib = [UINib nibWithNibName:[self cellId] bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:[self cellId]];
}

+ (instancetype)dequeue:(UITableView *)tableView
              indexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:[self cellId] forIndexPath:indexPath];
}

@end
