//
//  UIButton+IntervalTime.m
//  YGElfControl
//
//  Created by wuyiguang on 2018/2/11.
//  Copyright © 2018年 YG. All rights reserved.
//

#import "UIButton+IntervalTime.h"
#import <objc/runtime.h>

@implementation UIButton (IntervalTime)

static const char *UIButton_acceptEventInterval = "UIButton_acceptEventInterval";
static const char *UIButton_acceptEventTime     = "UIButton_acceptEventTime";

- (NSTimeInterval )yg_acceptEventInterval{
    return [objc_getAssociatedObject(self, UIButton_acceptEventInterval) doubleValue];
}

- (void)setYg_acceptEventInterval:(NSTimeInterval)yg_acceptEventInterval{
    objc_setAssociatedObject(self, UIButton_acceptEventInterval, @(yg_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval )yg_acceptEventTime{
    return [objc_getAssociatedObject(self, UIButton_acceptEventTime) doubleValue];
}

- (void)setYg_acceptEventTime:(NSTimeInterval)yg_acceptEventTime{
    objc_setAssociatedObject(self, UIButton_acceptEventTime, @(yg_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load {
    // 获取这两个方法
    Method systemMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    SEL sysSEL = @selector(sendAction:to:forEvent:);
    
    Method myMethod = class_getInstanceMethod(self, @selector(yg_sendAction:to:forEvent:));
    SEL mySEL = @selector(yg_sendAction:to:forEvent:);
    
    // 添加方法进去
    BOOL didAddMethod = class_addMethod(self, sysSEL, method_getImplementation(myMethod), method_getTypeEncoding(myMethod));
    
    // 如果方法已经存在
    if (didAddMethod) {
        class_replaceMethod(self, mySEL, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    }else{
        method_exchangeImplementations(systemMethod, myMethod);
        
    }
    
    /*--以上主要是实现两个方法的互换,load是gcd的只shareinstance，保证执行一次--*/
}

- (void)yg_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    
    if (NSDate.date.timeIntervalSince1970 - self.yg_acceptEventTime < self.yg_acceptEventInterval) {
        return;
    }
    
    if (self.yg_acceptEventInterval > 0) {
        self.yg_acceptEventTime = NSDate.date.timeIntervalSince1970;
    }
    
    [self yg_sendAction:action to:target forEvent:event];
}

@end
