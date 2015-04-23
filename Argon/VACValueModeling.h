//
//  BBDValueModel.h
//  ExtensionsBuilder
//
//  Created by Vincent Coetzee on 2011/07/07.
//  Copyright 2011 BBD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VACModeling.h"

@protocol VACValueModeling < NSObject, VACModeling >

@property(readwrite,strong) id value;

@required

- (BOOL) validateValue: (id*) aValue error: (NSError**) anError;

@end

typedef NSObject <VACValueModeling> VACValueModel;
