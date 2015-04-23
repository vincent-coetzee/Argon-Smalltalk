//
//  BBDAbstractModel.m
//  ExtensionsBuilder
//
//  Created by Vincent Coetzee on 2011/07/07.
//  Copyright 2011 BBD. All rights reserved.
//

#import "VACAbstractModel.h"
#import "VACDependentsSet.h"

@implementation VACAbstractModel
    {
    __strong VACDependentsSet* _dependents;
    }
/*
**
** Initialize the receiver
**
*/
- (id) init
    {
    self = [super init];
    if (self)
        {
        _dependents = [[VACDependentsSet alloc] init];
        }
    return(self);
    }

- (id) initWithCoder: (NSCoder*) coder
    {
    self = [super init];
    if (self)
        {
        _dependents = [[VACDependentsSet alloc] init];
        }
    return(self);
    }

- (void) encodeWithCoder: (NSCoder*) coder
    {
    }
/*
**
** The receiver has changed in some way, propagate the change
** to it's dependents by means of an update message.
**
*/
- (void) changed: (VACSymbol) aspect with: (id) object from: (id) sender
    {
    [_dependents update: aspect with: object from: sender];
    }
/*
**
** Add a dependent to the receiver's dependents
**
*/
- (void) addDependent: (VACDependent*) dependent
    {
    [_dependents addDependent: dependent];
    }
/*
**
** Remove the dependent as a dependent of the receiver
**
*/
- (void) removeDependent: (VACDependent*) dependent
    {
    [_dependents removeDependent: dependent];
    }
/*
**
** Remove the specified dependent as a dependent of the receiver during
** the execution of the specified block. Trap any exceptions that occur
** during the execution of the block to ensure that the dependent object
** is restored as a dependent of the receiver.
**
*/
- (void) retractInterestOf: (VACDependent*) dependent during: (VACValueModelsDuringBlock) block
    {
    [_dependents removeDependent: dependent];
    @try
        {
        block();
        }
    @catch(NSException* exception)
        {
        NSLog(@"%@>>%@ line %d",[self class],NSStringFromSelector(_cmd),__LINE__);
        NSLog(@"%@",exception);
        NSLog(@"%@", block);
        NSLog(@"Class of dependent: %@",NSStringFromClass([dependent class]));
        }
    [_dependents addDependent: dependent];
    }

@end
