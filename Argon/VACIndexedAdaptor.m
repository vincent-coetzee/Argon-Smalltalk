//
//  BBDIndexedAdaptor.m
//  DiscoveryInsure
//
//  Created by Vincent Coetzee on 2012/05/12.
//  Copyright (c) 2012 Discovery (Pty) Ltd. All rights reserved.
//

#import "VACIndexedAdaptor.h"
#import "VACValueHolder.h"
#import "NSObject+VACExtensions.h"

@interface VACIndexedAdaptor()

- (NSInteger) _indexValue;
- (NSMutableArray*) _subjectValue;

@property(readwrite,weak) VACValueModel* subject;
@property(readwrite,strong) VACValueModel* indexHolder;

@end

@implementation VACIndexedAdaptor
    {
    __weak VACValueModel* subject;
    __strong VACValueModel* indexHolder;
    }

@synthesize indexHolder;
@synthesize subject;

+ (id) newOnSubject: (VACValueModel*) model withIndexHolder: (VACValueModel*) anIndex
    {
    VACIndexedAdaptor* adaptor;

    adaptor = [VACIndexedAdaptor new];
    adaptor.subject = model;
    adaptor.indexHolder = anIndex;
    return(adaptor);
    }

+ (id) newOnSubject: (VACValueModel*) model withIntegerIndex: (int) anIndex
    {
    return([self newOnSubject: model withIndexHolder: [VACValueHolder on: [NSNumber numberWithInt: anIndex]]]);
    }

- (NSInteger) _indexValue
    {
    return([((NSNumber*)[((NSObject*)indexHolder) value]) intValue]);
    }

- (NSMutableArray*) _subjectValue
    {
    return((NSMutableArray*)[((NSObject*)subject) value]);
    }

- (void) setSubject: (VACValueModel*) model
    {
    [subject removeDependent: self];
    subject = model;
    [model addDependent: self];
    }

- (VACValueModel*) subject
    {
    return(subject);
    }

- (void) setIndexHolder: (VACValueModel*) aModel
    {
    [indexHolder removeDependent:self];
    indexHolder = aModel;
    [aModel addDependent: self];
    }

- (VACValueModel*) indexHolder
    {
    return(indexHolder);
    }

- (void) setValue: (id) anObject
    {
    NSMutableArray* subjectValue;
    NSInteger index;

    if (subject == nil)
        {
        return;
        }
    index = [self _indexValue];
    subjectValue = [self _subjectValue];
    if ([subjectValue count] < index)
        {
        [subjectValue addObject: anObject];
        }
    else
        {
        [subjectValue replaceObjectAtIndex: index withObject: anObject];
        }
    [self changed: VACSymbolValue with: anObject from: self];
    }

- (void) update: (VACSymbol) anAspect with: (id) anObject from: (id) sender
    {
    if (anAspect == VACSymbolValue && sender == subject)
        {
        [self changed: VACSymbolValue with: nil from: self];
        }
    else if (anAspect == VACSymbolValue && sender == indexHolder)
        {
        [self changed: VACSymbolValue with: nil from: self];
        }
    }

- (id) value
    {
    NSArray* array;
    NSInteger index;

    if (subject == nil)
        {
        return(nil);
        }
    array = [self _subjectValue];
    index = [self _indexValue];
    NSAssert(index < [array count],@"Index exceeds array size");
    return([array objectAtIndex: index]);
    }

@end
