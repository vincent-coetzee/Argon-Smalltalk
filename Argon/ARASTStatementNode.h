//
//  ARASTStatementNode.h
//  Talk
//
//  Created by Vincent Coetzee on 2014/11/22.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import "ARASTNode.h"

@interface ARASTStatementNode : ARASTNode

@property(readwrite,assign) NSUInteger startCharacterOffset;
@property(readwrite,assign) NSUInteger stopCharacterOffset;
@property(readwrite,assign) NSUInteger bytecodeStartOffset;
@property(readwrite,assign) NSUInteger bytecodeStopOffset;

@end
