//
//  BBDValueHolder.m
//  ExtensionsBuilder
//
//  Created by Vincent Coetzee on 2011/07/07.
//  Copyright 2011 BBD. All rights reserved.
//

#import "VACValueHolder.h"

@implementation VACValueHolder

/*
**
** Create a new ValueHolder on the specified object
**
*/
+ (id) on: (id) anObject
    {
    VACValueHolder*     holder;

    holder = [[VACValueHolder alloc] init];
    holder.value = anObject;
    return(holder);
    }
/*
**
** Initialize the receiver, init is the designated initializer
**
*/
- (id)init
    {
    self = [super init];
    if (self)
        {
        }
    return(self);
    }
/*
**
** Set the value that the receiver holds, update the dependents
** if there are any.
**
*/
- (void) setValue: (id) aValue
    {
    _value = aValue;
    [self changed: VACSymbolValue with: aValue from: self];
    }
/*
**
** Return the value that the receiver holds
**
*/
- (id) value
    {
    return(_value);
    }

- (BOOL) validateValue: (id*) aValue error: (NSError**) anError
    {
    *anError = nil;
    return(YES);
    }

@end
