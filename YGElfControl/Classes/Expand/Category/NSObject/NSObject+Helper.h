//
//  NSObject+Helper.h
//
//  Created by Ray on 2017/4/6.
//  Copyright © 2017年 Huashen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Helper)

/** 字典转json格式字符串 */
- (id)yg_toString;

/**
 *  判断对象是否为空
 *
 *  @return YES 为空  NO 为实例对象
 */
BOOL obj_isNull(id obj);

@end
