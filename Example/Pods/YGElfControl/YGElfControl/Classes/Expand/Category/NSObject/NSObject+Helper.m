//
//  NSObject+Helper.m
//
//  Created by Ray on 2017/4/6.
//  Copyright © 2017年 Huashen. All rights reserved.
//

#import "NSObject+Helper.h"

@implementation NSObject (Helper)

// 字典转json格式字符串
- (id)yg_toString
{
    if ([self isKindOfClass:[NSDictionary class]]) {
        NSError *parseError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
        
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return self;
}

BOOL obj_isNull(id obj)
{
    if (obj == nil || obj == (id)(kCFNull)) {
        return YES;
    } else {
        return NO;
    }
}

@end
