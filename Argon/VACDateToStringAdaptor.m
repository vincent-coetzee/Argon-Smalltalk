//
//  BBDDateToStringAdaptor.m
//  MomentumWealth
//
//  Created by Elad Tchetchik on 2012/10/03.
//  Copyright (c) 2012 Momentum Wealth (Pty) Ltd. All rights reserved.
//

#import "VACDateToStringAdaptor.h"

static NSDateFormatter* dateFormatter;

@implementation VACDateToStringAdaptor
    {
    __strong VACValueModel* model;
    __strong NSString* value;
    }

+(void) initialize
    {
    if (self == [VACDateToStringAdaptor class])
            {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy/MM/dd"];
            }
    }

+ (id) newWithDateModel:(NSObject<VACValueModeling> *)dateModel
    {
    VACDateToStringAdaptor* adaptor;

    adaptor = [[VACDateToStringAdaptor alloc] init];
    adaptor.model = dateModel;
    return(adaptor);
    }

- (void) setModel:(VACValueModel*)aModel
    {
    [model removeDependent:self];
    model = aModel;
    value = [dateFormatter stringFromDate:aModel.value];
    [self changed:VACSymbolValue with:value from:self];
    [model addDependent:self];
    }

- (VACValueModel*) model
    {
    return (model);
    }

- (void) update:(VACSymbol)aspect with:(id)object from:(id)sender
    {
    if (aspect == VACSymbolValue && object != self)
        {
        value = [dateFormatter stringFromDate:model.value];
        [self changed:aspect with:value from:self];
        }
    }

- (void) setValue: (NSString*) aValue
    {
    value = aValue;
    [self changed: VACSymbolValue with: aValue from: self];
    model.value =[NSNumber numberWithFloat:[value floatValue]];
    }

- (id) value
    {
    return(value);
    }

- (void) dealloc
    {
    [model removeDependent:self];
    model = nil;
    }

- (BOOL) validateValue: (id*) aValue error: (NSError**) anError
    {
    return YES;
    }

@end

