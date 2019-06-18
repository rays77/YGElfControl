//
//  UICollectionViewCell+Category.h
//  YGElfControl
//
//  Created by wuyiguang on 2018/1/16.
//  Copyright © 2018年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewCell (Category)

+ (NSString *)cellId;

+ (void)registerClass:(UICollectionView *)collectionView;

+ (void)registerNib:(UICollectionView *)collectionView;

+ (instancetype)dequeue:(UICollectionView *)collectionView
              indexPath:(NSIndexPath *)indexPath;

@end
