//
//  BBDSortingFilter.m
//  ESKOMWorkplanner
//
//  Created by Vincent Coetzee on 2013/03/23.
//  Copyright (c) 2013 ESKOM (Pty) Ltd. All rights reserved.
//

#import "VACSortingFilter.h"
#import "NSArray+VACExtensions.h"

@implementation VACSortingFilter
    {
    __strong NSArray* _sortedValues;
    __weak VACValueModel* _list;
    }

+ (id) sortingFilterOnList: (VACValueModel*) listModel withKey: (NSString*) key ascending: (BOOL) ascending
    {
    VACSortingFilter* filter;

    filter = [self new];
    filter.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey: key ascending: ascending]];
    filter.list = listModel;
    return(filter);
    }

- (void) setList: (id) aValue
    {
    [_list removeDependent: self];
    _list = aValue;
    [_list addDependent: self];
    [self changed];
    }

- (VACValueModel*) list
    {
    return(_list);
    }

- (void) update: (VACSymbol) aspect with: (id) object from: (id) sender
    {
    if (sender == _list && aspect == VACSymbolValue)
        {
        [self changed];
        }
    }

- (id) value
    {
    if (_sortedValues != nil)
        {
        return(_sortedValues);
        }
    _sortedValues = [[_list.value allObjects] sortedArrayUsingDescriptors: self.sortDescriptors];
    return(_sortedValues);
    }

- (void) setValue: (id) aValue
    {
    }

@end

