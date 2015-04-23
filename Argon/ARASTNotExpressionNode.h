//
//  ARASTNotStatementNode.h
//  Talk
//
//  Created by Vincent Coetzee on 2014/11/22.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import "ARASTExpressionNode.h"

@interface ARASTNotExpressionNode : ARASTExpressionNode

@property(readwrite,strong) ARASTExpressionNode* argument;

@end
