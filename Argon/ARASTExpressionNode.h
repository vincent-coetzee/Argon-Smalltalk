//
//  ARASTExpressionNode.h
//  Talk
//
//  Created by Vincent Coetzee on 2014/11/22.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import "ARASTStatementNode.h"

@interface ARASTExpressionNode : ARASTStatementNode

@property(readonly) BOOL isTemporary;

@end
