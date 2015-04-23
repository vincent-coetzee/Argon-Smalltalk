//
//  NSObject+Extensions.m
//  SoD
//
//  Created by Vincent Coetzee on 2011/12/27.
//  Copyright (c) 2011 BBD (Pty) Ltd. All rights reserved.
//

#import "NSObject+VACExtensions.h"

@implementation NSObject(NullExtensions)

- (BOOL) isView
    {
    return(NO);
    }

- (BOOL) isPanel
    {
    return(NO);
    }

- (BOOL) isViewController
    {
    return(NO);
    }

- (BOOL) isDecimalNumber
    {
    return(NO);
    }

- (BOOL) isNull
    {
    return(NO);
    }

- (BOOL) isNotNull
    {
    return(YES);
    }

- (BOOL) isKeyValueAssociation
    {
    return(NO);
    }

- (BOOL) isDictionary
    {
    return(NO);
    }

- (BOOL) isValue
    {
    return(NO);
    }

- (BOOL) isArray
    {
    return(NO);
    }

- (BOOL) isString
    {
    return(NO);
    }

- (BOOL) isNumber
    {
    return(NO);
    }

- (BOOL) isDate
    {
    return(NO);
    }

- (id) value
    {
    return(self);
    }

- (void) setValue: (id) value
    {
    [NSException raise: @"DSI" format: @"You can not set the value of an object of class %@",[self class]];
    }

- (BOOL) validateValue: (id) aValue error: (NSError**) anError
    {
    *anError = nil;
    return(YES);
    }

- (NSString*) printString
    {
    return([NSString stringWithFormat: @"%@",self]);
    }

- (BOOL) isError
    {
    return (NO);
    }

@end

@implementation NSNull(BBDExtensions)

- (BOOL) isNull
    {
    return(YES);
    }

- (BOOL) isNotNull
    {
    return(NO);
    }

- (NSString*) printString
    {
    return(@"NSNull");
    }

- (BOOL) isError
    {
    return (NO);
    }

@end
