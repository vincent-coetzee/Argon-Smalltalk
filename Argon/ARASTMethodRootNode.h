//
//  ARASTMethodRootNode.h
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/04.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import "ARASTNode.h"
#import "ARCompiledMethod.h"
#import "ARMethod.h"
#import "ARClass.h"
#import "ARASTStatementNode.h"

@interface ARASTMethodRootNode : ARASTNode

@property(readwrite,strong) NSString* methodSelector;

- (void) addStatement: (ARASTStatementNode*) node;
- (id) resolveName: (NSString*) name;
- (void) addTemporaryName: (NSString*) name;
- (void) addParameterName: (NSString*) name;
- (void) setMethodClass: (ARClass*) aClass;
- (void) setMethod: (ARMethod*) aMethod;
- (void) generateByteCodeFor: (ARCompiledMethod*) aMethod;

@end
