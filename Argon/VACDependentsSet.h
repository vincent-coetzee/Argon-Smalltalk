//
//  BBDDependentsSet.h
//  ExtensionsBuilder
//
//  Created by Vincent Coetzee on 2011/07/07.
//  Copyright 2011 BBD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VACDependence.h"
#import "VACSymbols.h"

@interface VACDependentsSet : NSObject < VACDependence >

@property(readonly,nonatomic,assign) NSUInteger count;

- (id) init;
- (void) addDependent: (VACDependent*) dependent;
- (void) removeDependent: (VACDependent*) dependent;
- (void) update: (VACSymbol) aspect with: (id) object from: (id) sender;
- (BOOL) containsDependent: (VACDependent*) dependent;

@end
