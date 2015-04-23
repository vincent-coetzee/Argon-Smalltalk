//
//  BBDModel.h
//  ExtensionsBuilder
//
//  Created by Vincent Coetzee on 2011/07/07.
//  Copyright 2011 BBD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VACDependence.h"
#import "VACSymbols.h"

typedef void (^VACValueModelsDuringBlock)(void);

@protocol VACModeling <NSObject>

@required

- (void) changed: (VACSymbol) aspect with: (id) object from: (id) sender;
- (void) addDependent: (VACDependent*) dependent;
- (void) removeDependent: (VACDependent*) dependent;
- (void) retractInterestOf: (VACDependent*) dependent during: (VACValueModelsDuringBlock) block;

@end

typedef NSObject <VACModeling> VACModel;



