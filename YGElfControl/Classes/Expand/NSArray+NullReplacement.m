//
//  NSArray+NullReplacement.m
//  iPadOutLetShopping
//
//  Created by Huashen on 6/27/15.
//  Copyright (c) 2015 aolaigo. All rights reserved.
//

#import "NSArray+NullReplacement.h"
#import "NSDictionary+NullReplacement.h"

@implementation NSArray (NullReplacement)
- (NSArray *)arrayByReplacingNullsWithBlanks  {
    NSMutableArray *replaced = [self mutableCopy];
    const id nul = [NSNull null];
    const NSString *blank = @"";
    for (int idx = 0; idx < [replaced count]; idx++) {
        id object = [replaced objectAtIndex:idx];
        if (object == nul) [replaced replaceObjectAtIndex:idx withObject:blank];
        else if ([object isKindOfClass:[NSDictionary class]]) [replaced replaceObjectAtIndex:idx withObject:[object dictionaryByReplacingNullsWithBlanks]];
        else if ([object isKindOfClass:[NSArray class]]) [replaced replaceObjectAtIndex:idx withObject:[object arrayByReplacingNullsWithBlanks]];
    }
    return [replaced copy];
}

-(void)sortSize
{
    NSArray *sizes = @[@"XXS", @"XS", @"S", @"M", @"L", @"XL", @"XXL", @"XXXL",@"3XL"];
    
    [self sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        
        NSUInteger index1 = [sizes indexOfObject:obj1];
        NSUInteger index2 = [sizes indexOfObject:obj2];
        if (index1 == NSNotFound && index2 == NSNotFound) {
            return [@([obj1 intValue]) compare:@([obj2 intValue])];
        }
        else if (index1 == NSNotFound)
        {
            return NSOrderedAscending;
        }
        else if (index2 == NSNotFound)
        {
            return NSOrderedDescending;
        }
        return [@(index1) compare:@(index2)];
    }];
}
@end
