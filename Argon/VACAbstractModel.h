//
//  BBDAbstractModel.h
//  ExtensionsBuilder
//
//  Created by Vincent Coetzee on 2011/07/07.
//  Copyright 2011 BBD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VACDependentsSet.h"
#import "VACModeling.h"

@interface VACAbstractModel : NSObject < VACModeling >

- (id) init;
- (id) initWithCoder: (NSCoder*) coder;
- (void) encodeWithCoder: (NSCoder*) coder;
- (void) changed: (VACSymbol) aspect with: (id) object from: (id) sender;
- (void) addDependent: (VACDependent*) dependent;
- (void) removeDependent: (VACDependent*) dependent;
- (void) retractInterestOf: (VACDependent*) dependent during: (VACValueModelsDuringBlock) block;
- (void) changed;

@end
