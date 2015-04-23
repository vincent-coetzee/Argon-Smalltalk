//
//  BBDException.m
//  DiscoveryInsure
//
//  Created by Vincent Coetzee on 2012/04/08.
//  Copyright (c) 2012 BBD (Pty) Ltd. All rights reserved.
//

#import "VACException.h"

@interface VACException()

+ (NSString*) exceptionName;

@end

@implementation VACException

+ (id) raiseWithFormat: (NSString*) format,...
    {
    va_list list;

    @try
        {
        va_start(list,format);
        [NSException raise: [self exceptionName] format: format arguments: list];
        }
    @finally
        {
        va_end(list);
        }
    }

+ (NSString*) exceptionName
    {
    return(NSStringFromClass(self));
    }

+ (id) raiseNotImplementedYet
    {
    [self raise: [self exceptionName] format: @"This method has not been implemented yet, but should be."];
    return(nil);
    }

+ (id) raiseShouldBeOverridden
    {
    [self raise: [self exceptionName] format: @"This method should have been overridden in a subclass."];
    return(nil);
    }

+ (id) raiseShouldNotBeInvoked
    {
    [self raise: [self exceptionName] format: @"This method should not have been invoked."];
    return(nil);
    }

+ (id) raiseMustNotBeImplemented
    {
    [self raise: [self exceptionName] format: @"This method should never be defined for this class of object and therefore you may not invoke it on this object"];
    return(nil);
    }

+ (id) raiseShouldNotHappen
    {
    [VACException raise: [self exceptionName] format: @"This should not have happened."];
    return(nil);
    }

+ (id) raiseInvalidDesignatedInitializerName: (NSString*) invalidName forClassNamed: (NSString*) className validName: (NSString*) validName
    {
    [self raiseWithFormat: @"%@ is not the designated initializer for class %@ use %@",invalidName,className,validName];
    return(nil);
    }

+ (id) raiseInvalidIndex: (NSUInteger) index upperBound: (NSUInteger) upperBound
    {
    [self raiseWithFormat: @"The index %d must be >= 0 and <= %d",index,upperBound];
    return(nil);
    }

+ (id) raiseInvalidValue: (id) aValue forPlace: (id) aPlace
    {
    [self raiseWithFormat: @"The value %@ is not valid for %@",aValue,aPlace];
    return(nil);
    }

@end
