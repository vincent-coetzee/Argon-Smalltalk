//
//  ARASTAssignNode.h
//  Talk
//
//  Created by Vincent Coetzee on 2014/11/22.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import "ARASTExpressionNode.h"

@class ARASTVariableNode;

@interface ARASTAssignNode : ARASTExpressionNode

@property(readwrite,strong) ARASTExpressionNode* operand;
@property(readwrite,strong) ARASTExpressionNode* argument;

@end
