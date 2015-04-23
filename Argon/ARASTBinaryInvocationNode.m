//
//  ARASTBinaryInvocationNode.m
//  Talk
//
//  Created by Vincent Coetzee on 2014/11/25.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import "ARASTBinaryInvocationNode.h"
#import "ARByteCodeArray.h"
#import "ARVM.h"

@implementation ARASTBinaryInvocationNode

- (NSString*) description
	{
	return([NSString stringWithFormat: @"%@ PERFORM %@ WITH %@",self.operand,self.selectorString,self.argument]);
	}
	
- (void) generateByteCodeFor: (ARCompiledMethod*) method
	{
	WORD index;
	
	[self.operand generateByteCodeFor: method];
	[self.argument generateByteCodeFor: method];
	index = [method.literalFrame addObjectElement: [[ARVM activeVM] stringWithNSString: self.selectorString]];
	[method.byteCode pushLiteral: index];
	[method.byteCode send];
	}
	
@end
