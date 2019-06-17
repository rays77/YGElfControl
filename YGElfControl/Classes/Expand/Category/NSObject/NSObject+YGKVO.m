//
//  NSObject+YGKVO.m
//  Mula
//
//  Created by Ray on 2017/8/23.
//  Copyright © 2017年 lc4y. All rights reserved.
//

#import "NSObject+YGKVO.h"
#import <objc/runtime.h>

@implementation NSObject (YGKVO)

/*
+ (void)load
{
    [self runtimeMethod];
}
*/
 
+ (void)runtimeMethod
{
    SEL removeSel = @selector(removeObserver:forKeyPath:);
    SEL ygRemoveSel = @selector(yg_removeObserver:forKeyPath:);
    SEL addSel = @selector(addObserver:forKeyPath:options:context:);
    SEL ygAddSel = @selector(yg_addObserver:forKeyPath:options:context:);
    
    Method removeMethod = class_getClassMethod([self class], removeSel);
    Method ygRemoveMethod = class_getClassMethod([self class], ygRemoveSel);
    Method addMethod = class_getClassMethod([self class], addSel);
    Method ygAddMethod = class_getClassMethod([self class], ygAddSel);
    
    // 交换两个方法的实现
    method_exchangeImplementations(removeMethod, ygRemoveMethod);
    method_exchangeImplementations(addMethod, ygAddMethod);
}

// 检查某个key是否存在
- (BOOL)observerKeyPath:(NSString *)key
{
    id info = self.observationInfo;
    NSArray *array = [info valueForKey:@"_observances"];
    for (id objc in array) {
        id properyies = [objc valueForKeyPath:@"_property"];
        NSString *keyPath = [properyies valueForKeyPath:@"_keyPath"];
        if ([key isEqualToString:keyPath]) {
            return YES;
        }
    }
    return NO;
}

- (void)yg_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath
{
    if ([self observerKeyPath:keyPath]) {
        [self removeObserver:observer forKeyPath:keyPath context:NULL];
    }
}

- (void)yg_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    if (![self observerKeyPath:keyPath]) {
        [self addObserver:observer forKeyPath:keyPath options:options context:context];
    }
}

@end
