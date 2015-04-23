//
//  ARASTSmalltalkMethodNode.h
//  Talk
//
//  Created by Vincent Coetzee on 2014/11/22.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import "ARASTNode.h"

@class ARASTStatementNode;
@class ARASTVariableNode;
@class ARASTClass;

@interface ARASTMethodNode : ARASTNode

@property(readwrite,strong) NSString* methodSelector;
@property(readwrite,weak) ARASTClass* methodClass;
@property(readwrite,strong) NSString* source;
@property(readonly) NSUInteger literalFrameSize;
@property(readonly) NSUInteger temporaryFrameSize;
@property(readonly) ARByteCodeArray* bytecodes;

- (void) addParameterName: (NSString*) name;
- (void) addTemporaryName: (NSString*) name;
- (void) addStatement: (ARASTStatementNode*) statement;
- (ARASTVariableNode*) resolveName: (NSString*) name;
- (void) generateByteCode;

@end
