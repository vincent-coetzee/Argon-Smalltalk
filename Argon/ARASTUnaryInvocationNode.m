//
//  ARASTUnaryInvocationNode.m
//  Talk
//
//  Created by Vincent Coetzee on 2014/11/25.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import "ARASTUnaryInvocationNode.h"
#import "ARVM.h"

@implementation ARASTUnaryInvocationNode

- (NSString*) description
	{
	return([NSString stringWithFormat: @"%@ PERFORM %@",self.operand,self.selectorString]);
	}
	
- (void) generateByteCodeFor: (ARCompiledMethod*) method
	{
	WORD index;
	
	[self.operand generateByteCodeFor: method];
	index = [method.literalFrame addObjectElement: [[ARVM activeVM] stringWithNSString: self.selectorString]];
	[method.byteCode pushLiteral: index];
	[method.byteCode send];
	}
	
@end
