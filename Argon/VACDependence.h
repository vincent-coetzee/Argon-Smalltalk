//
//  BBDDependent.h
//  ExtensionsBuilder
//
//  Created by Vincent Coetzee on 2011/07/07.
//  Copyright 2011 BBD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VACSymbols.h"

@protocol VACDependence <NSObject>

@required

- (void) update: (VACSymbol) aspect with: (id) object from: (id) sender;

@end

typedef NSObject <VACDependence> VACDependent;
