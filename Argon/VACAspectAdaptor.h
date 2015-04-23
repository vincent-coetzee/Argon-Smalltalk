//
//  BBDAspectAdaptor.h
//  DiscoveryInsure
//
//  Created by Vincent Coetzee on 2012/04/08.
//  Copyright (c) 2012 BBD (Pty) Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VACAbstractModel.h"
#import "VACValueModeling.h"

@interface VACAspectAdaptor : VACAbstractModel < VACValueModeling >

@property(readwrite,strong) id value;
@property(readonly,assign) VACSymbol aspect;
@property(readonly,strong) VACModel* model;

+ (id) newWithAspect: (VACSymbol) anAspect model: (VACModel*) aModel;
- (id) initWithAspect: (VACSymbol) anAspect model: (VACModel*) aModel;
- (void) update: (VACSymbol) anAspect with: (id) object from: (id) sender;
- (BOOL) validateValue: (id*) aValue error: (NSError**) error;
- (void) setSetterName: (NSString*) aName;
- (void) setGetterName: (NSString*) aName;

@end
