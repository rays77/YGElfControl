//
//  NSObject+YGKVO.h
//  Mula
//
//  Created by Ray on 2017/8/23.
//  Copyright © 2017年 lc4y. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YGKVO)

- (void)yg_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;
- (void)yg_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;
/**
 * 检查某个key是否存在
 */
- (BOOL)observerKeyPath:(NSString *)key;

@end
