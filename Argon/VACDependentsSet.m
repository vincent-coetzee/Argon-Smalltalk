//
//  BBDDependentsSet.m
//
//  Created by Vincent Coetzee on 2011/07/07.
//  Copyright 2011 BBD (Pty) Ltd. All rights reserved.
//

#import "VACDependentsSet.h"

@interface BBDPrivateHolder : NSObject

@property(readwrite,weak) VACDependent* dependent;

+ (id) newWithDependent: (VACDependent*) dependent;

@end

@implementation BBDPrivateHolder

@synthesize dependent;

+ (id) newWithDependent: (VACDependent*) dependent
    {
    BBDPrivateHolder* holder;

    holder = [[self alloc] init];
    holder.dependent = dependent;
    return(holder);
    }

@end


@implementation VACDependentsSet
    {
    __strong NSMutableArray* objects;
    }
/*
**
** Initialize the receiver to hold some dependents.
**
*/
- (id)init
    {
    self = [super init];
    if (self)
        {
        objects = [NSMutableArray array];
        }
    return(self);
    }

- (id) initWithCoder: (NSCoder*) coder
    {
    self = [super init];
    if (self)
        {
        objects = [NSMutableArray array];
        }
    return(self);
    }

/*
**
** Dependent sets are weak collections and therefore they do
** NOT save references to dependents when they are saved.
**
*/
- (void) encodeWithCoder: (NSCoder*) coder
    {
    }
/*
**
** Add a dependent to the receiver
**
*/
- (void) addDependent: (VACDependent*) dependent
    {
    NSAssert(dependent != nil,@"dependent can not be nil");
    @synchronized(self)
        {
        if (![self containsDependent: dependent])
            {
            [objects addObject: [BBDPrivateHolder newWithDependent: dependent]];
            }
        }
    }

- (BOOL) containsDependent: (VACDependent*) dependent
    {
    NSMutableArray* defunctHolders;

    NSAssert(dependent != nil,@"dependent can not be nil");
    defunctHolders = [NSMutableArray array];
    @try
        {
        for (BBDPrivateHolder* holder in objects)
            {
            if (holder.dependent == nil)
                {
                [defunctHolders addObject: holder];
                }
            else
                {
                if (holder.dependent == dependent)
                    {
                    return(YES);
                    }
                }
            }
        return(NO);
        }
    @finally
        {
        @synchronized(self)
            {
            [objects removeObjectsInArray: defunctHolders];
            }
        }
    }
/*
**
** Return the size of the receiver
**
*/
- (NSUInteger) count
    {
    return([objects count]);
    }
/*
**
** Remove a dependent from the collection that the receiver holds
**
*/
- (void) removeDependent: (VACDependent*) dependent
    {
    NSMutableArray* defunctHolders;

    NSAssert(dependent != nil,@"dependent can not be nil");
    defunctHolders = [NSMutableArray array];
    @try
        {
        for (BBDPrivateHolder* holder in objects)
            {
            if (holder.dependent == nil)
                {
                [defunctHolders addObject: holder];
                }
            else
                {
                if (holder.dependent == dependent)
                    {
                    [defunctHolders addObject: holder];
                    }
                }
            }
        }
    @finally
        {
        @synchronized(self)
            {
            [objects removeObjectsInArray: defunctHolders];
            }
        }
    }
/*
**
** Propagate an update to each of the dependents that the receiver holds,
** trap any exceptions that occur at the individual message send level
** to ensure that as many updates get correctly delivered as possible.
**
*/
- (void) update: (VACSymbol) aspect with: (id) object from: (id) sender
    {
    NSMutableArray* defunctHolders;
    NSArray* dependentsCopy;

    defunctHolders = [NSMutableArray array];
    @try
        {
        for (BBDPrivateHolder* holder in objects)
            {
            if (holder.dependent == nil)
                {
                [defunctHolders addObject: holder];
                }
//            else
//                {
//                @try
//                    {
////                    NSLog(@"The class of the dependent is %@", NSStringFromClass([holder.dependent class]));
//                    [holder.dependent update: aspect with: object from: sender];
//                    }
//                @catch(NSException* exception)
//                    {
//                    for (NSString* string in [exception callStackSymbols])
//                        {
//                        NSLog(@"%@",string);
//                        }
//                    NSLog(@"dependent(%@,%llX) caused an exception - removing from dependents",[holder.dependent class],holder.dependent);
//                    [defunctHolders addObject: holder];
//                    }
//                }
            }
        dependentsCopy = [objects copy];
        for (BBDPrivateHolder* holder in dependentsCopy)
            {
            if (holder.dependent != nil)
                {
                @try
                    {
                    [holder.dependent update: aspect with: object from: sender];
                    }
                @catch(NSException* exception)
                    {
                    for (NSString* string in [exception callStackSymbols])
                        {
                        NSLog(@"%@",string);
                        }
                    NSLog(@"dependent(%@,%llX) caused an exception - removing from dependents",[holder.dependent class],holder.dependent);
                    [defunctHolders addObject: holder];
                    }
                }
            }
        }
    @finally
        {
        @synchronized(self)
            {
            [objects removeObjectsInArray: defunctHolders];
            }
        }
    }

@end
