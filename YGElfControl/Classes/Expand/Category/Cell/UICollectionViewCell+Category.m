//
//  UICollectionViewCell+Category.m
//  YGElfControl
//
//  Created by wuyiguang on 2018/1/16.
//  Copyright © 2018年 YG. All rights reserved.
//

#import "UICollectionViewCell+Category.h"

@implementation UICollectionViewCell (Category)

+ (NSString *)cellId {
    return NSStringFromClass([self class]);
}

+ (void)registerClass:(UICollectionView *)collectionView {
    [collectionView registerClass:[self class] forCellWithReuseIdentifier:[self cellId]];
}

+ (void)registerNib:(UICollectionView *)collectionView {
    UINib *nib = [UINib nibWithNibName:[self cellId] bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:[self cellId]];
}

+ (instancetype)dequeue:(UICollectionView *)collectionView
              indexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:[self cellId] forIndexPath:indexPath];
}

@end
