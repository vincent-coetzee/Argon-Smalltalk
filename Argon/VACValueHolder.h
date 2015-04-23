//
//  BBDValueHolder.h
//  ExtensionsBuilder
//
//  Created by Vincent Coetzee on 2011/07/07.
//  Copyright 2011 BBD. All rights reserved.
//

#import "VACAbstractModel.h"
#import "VACValueModeling.h"

@interface VACValueHolder : VACAbstractModel < VACValueModeling >
    {
    @protected
    __strong id     _value;
    }

@property(readwrite,strong) id value;

+ (id) on: (id) anObject NS_RETURNS_RETAINED;
- (BOOL) validateValue: (id) aValue error: (NSError**) anError;

@end
