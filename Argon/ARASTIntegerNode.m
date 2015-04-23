//
//  ARASTIntegerNode.m
//  Talk
//
//  Created by Vincent Coetzee on 2014/11/25.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import "ARASTIntegerNode.h"

@implementation ARASTIntegerNode

- (NSString*) description
	{
	return([NSString stringWithFormat: @"INTEGER LITERAL %lu",self.longValue]);
	}
	
- (void) generateByteCodeFor: (ARCompiledMethod*) method
	{
	WORD index;
	
	index = [method.literalFrame addElement: self.longValue];
	[method.byteCode pushLiteral: index];
	}
	
@end
