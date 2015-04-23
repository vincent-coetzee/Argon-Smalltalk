//
//  ARASTReturnNode.m
//  Talk
//
//  Created by Vincent Coetzee on 2014/11/25.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import "ARASTReturnNode.h"
#import "ARASTExpressionNode.h"

@implementation ARASTReturnNode
	
- (void) generateByteCodeFor: (ARCompiledMethod*) method
	{
	[self.argument generateByteCodeFor: method];
	[method.byteCode ret];
	}

@end
