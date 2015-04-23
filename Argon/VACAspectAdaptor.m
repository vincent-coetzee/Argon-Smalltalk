//
//  BBDAspectAdaptor.m
//  DiscoveryInsure
//
//  Created by Vincent Coetzee on 2012/04/08.
//  Copyright (c) 2012 BBD (Pty) Ltd. All rights reserved.
//

#import "VACAspectAdaptor.h"
#import "VACException.h"
#import "NSString+VACExtensions.h"
#import "NSObject+VACExtensions.h"
#import "VACValueHolder.h"

@interface VACAspectAdaptor()

- (void) buildAccessors;

@end

@implementation VACAspectAdaptor
    {
    VACSymbol aspect;
    SEL setter;
    SEL getter;
    __strong VACModel* model;
    }

@synthesize aspect;


+ (id) newWithAspect: (VACSymbol) anAspect model: (VACModel*) aModel
    {
    return([[self alloc] initWithAspect: anAspect model: aModel]);
    }

- (id) init
    {
    [VACException raiseInvalidDesignatedInitializerName: @"init" forClassNamed: @"VACAspectAdaptor" validName: @"initWithAspect:model:"];
    return(nil);
    }

- (id) initWithAspect: (VACSymbol) anAspect model: (VACModel*) aModel
    {
    self = [super init];
    if (self)
        {
        aspect = anAspect;
        model = ([aModel respondsToSelector:@selector(addDependent:)] ? aModel:[VACValueHolder on:aModel]);
        [self buildAccessors];
        [model addDependent: (VACDependent*)self];
        }
    return(self);
    }

- (void) buildAccessors
    {
    NSAssert(aspect!=NULL,@"aspect can not be nil");
    NSAssert(model!=nil,@",model can not be nil");
    setter = NSSelectorFromString([NSStringFromVACSymbol(aspect) setMethodNameString]);
    getter = NSSelectorFromString(NSStringFromVACSymbol(aspect));
    }

- (void) update: (VACSymbol) anAspect with: (id) object from: (id) sender
    {
//    if ((sender == model) && (aspect == anAspect))
    if (sender == model && anAspect == VACSymbolValue)
        {
        [self changed: VACSymbolValue with: object from: sender];
        }
    }

- (BOOL) validateValue: (id*) aValue error: (NSError**) error
    {
    if ([model respondsToSelector: @selector(validateValue:forKeyPath:error:)])
        {
        return([[model value] validateValue: aValue forKeyPath: NSStringFromVACSymbol(aspect) error: error]);
        }
    return(NO);
    }

- (void) setValue: (id) value
    {
    [[model value] performSelector: setter withObject: value];
    [self changed:VACSymbolValue with:value from:self];
    }

- (id) value
    {
    return([[model value] performSelector: getter]);
    }

- (void) setSetterName: (NSString*) aName
    {
    setter = NSSelectorFromString(aName);
    }

- (void) setGetterName: (NSString*) aName
    {
    getter = NSSelectorFromString(aName);
    }

- (void) setModel:(NSObject<VACModeling> *)aModel
    {
    [model removeDependent:(VACDependent*)self];
    model = ([aModel respondsToSelector:@selector(addDependent:)] ? aModel:[VACValueHolder on:aModel]);
    [model addDependent:(VACDependent*)self];
    }

- (VACModel*) model
    {
    return model;
    }

@end
