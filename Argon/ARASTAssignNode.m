//
//  ARASTAssignNode.m
//  Talk
//
//  Created by Vincent Coetzee on 2014/11/22.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import "ARASTAssignNode.h"
#import "ARASTTemporaryNode.h"
#import "ARByteCodeArray.h"

@implementation ARASTAssignNode

- (NSString*) description
	{
	return([NSString stringWithFormat: @"%@ ASSIGN %@",self.operand.description,self.argument.description]);
	}
	
- (void) generateByteCodeFor: (ARCompiledMethod*) method
	{
	ARASTTemporaryNode* temp;
	
	[self.argument generateByteCodeFor: method];
	if (self.operand.isTemporary)
		{
		temp = (ARASTTemporaryNode*)self.operand;
		[method.byteCode popTemp: temp.offset];
		}
	}
	
@end
