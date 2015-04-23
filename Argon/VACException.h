//
//  BBDException.h
//  DiscoveryInsure
//
//  Created by Vincent Coetzee on 2012/04/08.
//  Copyright (c) 2012 BBD (Pty) Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VACException : NSException

+ (id) raiseWithFormat: (NSString*) format,...;
+ (id) raiseNotImplementedYet;
+ (id) raiseShouldBeOverridden;
+ (id) raiseShouldNotBeInvoked;
+ (id) raiseShouldNotHappen;
+ (id) raiseInvalidDesignatedInitializerName: (NSString*) invalidName forClassNamed: (NSString*) className validName: (NSString*) validName;
+ (id) raiseMustNotBeImplemented;
+ (id) raiseInvalidIndex: (NSUInteger) index upperBound: (NSUInteger) upperBound;
+ (id) raiseInvalidValue: (id) aValue forPlace: (id) aPlace;

@end
