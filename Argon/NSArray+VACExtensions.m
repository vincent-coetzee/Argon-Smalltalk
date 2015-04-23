//
//  NSArray+BBDExtensions.m
//  IOSCharts
//
//  Created by Vincent Coetzee on 2012/08/12.
//  Copyright (c) 2012 BBD. All rights reserved.
//

#import "NSArray+VACExtensions.h"

@implementation NSArray (VACExtensions)

- (NSArray*) arrayByReversingArray
    {
    NSMutableArray* array;
    NSUInteger size;
    NSInteger index;

    size = [self count];
    array = [NSMutableArray arrayWithCapacity: size];
    for (index=size-1; index>=0; index--)
        {
        [array addObject: self[index]];
        }
    return(array);
    }

- (NSArray*) asArrayOfJSONObjects
    {
    NSMutableArray* newArray;

    newArray = [NSMutableArray array];
    for (id object in self)
        {
        [newArray addObject: [object performSelector: @selector(asDictionary)]];
        }
    return(newArray);
    }

- (NSArray*) allObjects
    {
    return(self);
    }

@end
