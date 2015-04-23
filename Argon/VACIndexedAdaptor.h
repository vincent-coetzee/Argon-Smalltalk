//
//  BBDIndexedAdaptor.h
//  DiscoveryInsure
//
//  Created by Vincent Coetzee on 2012/05/12.
//  Copyright (c) 2012 Discovery (Pty) Ltd. All rights reserved.
//

#import "VACAbstractModel.h"
#import "VACValueModeling.h"

@interface VACIndexedAdaptor : VACAbstractModel < VACDependence >

+ (id) newOnSubject: (VACValueModel*) model withIndexHolder: (VACValueModel*) anIndex NS_RETURNS_RETAINED;
+ (id) newOnSubject: (VACValueModel*) model withIntegerIndex: (int) anIndex NS_RETURNS_RETAINED;
- (void) setValue: (id) anObject;
- (id) value;

@end
