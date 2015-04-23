//
//  BBDSelectionInList.m
//  ESKOMWorkplanner
//
//  Created by Vincent Coetzee on 2013/02/07.
//  Copyright (c) 2013 ESKOM (Pty) Ltd. All rights reserved.
//

#import "VACSelectionInList.h"
#import "VACValueHolder.h"

@implementation VACSelectionInList

- (id) init
    {
    self = [super init];
    if (self)
        {
        _selectionModel = [VACValueHolder on: nil];
        _list = @[];
        }
    return(self);
    }

@end
