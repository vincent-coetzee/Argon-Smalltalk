//
//  ARASTNotStatementNode.m
//  Talk
//
//  Created by Vincent Coetzee on 2014/11/22.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import "ARASTNotExpressionNode.h"
#import "ARVM.h"

@implementation ARASTNotExpressionNode

- (void) generateByteCodeFor: (ARCompiledMethod*) method
	{
	WORD index;
	
	[self.argument generateByteCodeFor: method];
	index = [method.literalFrame addObjectElement: [[ARVM activeVM] stringWithNSString: @"not"]];
	[method.byteCode pushLiteral: index];
	[method.byteCode send];
	}
	
@end
