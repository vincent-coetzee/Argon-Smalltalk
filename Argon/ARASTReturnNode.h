//
//  ARASTReturnNode.h
//  Talk
//
//  Created by Vincent Coetzee on 2014/11/25.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import "ARASTStatementNode.h"

@class ARASTExpressionNode;

@interface ARASTReturnNode : ARASTStatementNode

@property(readwrite,strong) ARASTExpressionNode* argument;

@end
