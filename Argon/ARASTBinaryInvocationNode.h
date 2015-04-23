//
//  ARASTBinaryInvocationNode.h
//  Talk
//
//  Created by Vincent Coetzee on 2014/11/25.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import "ARASTInvocationNode.h"
#import "ARASTExpressionNode.h"

@interface ARASTBinaryInvocationNode : ARASTInvocationNode

@property(readwrite,strong) ARASTExpressionNode* argument;

@end