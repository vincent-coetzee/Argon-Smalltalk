//
//  ARASTInvocationNode.h
//  Talk
//
//  Created by Vincent Coetzee on 2014/11/25.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import "ARASTExpressionNode.h"

@interface ARASTInvocationNode : ARASTExpressionNode

@property(readwrite,strong) NSString* selectorString;
@property(readwrite,strong) ARASTExpressionNode* operand;

@end
