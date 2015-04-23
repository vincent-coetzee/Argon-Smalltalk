//
//  ARParsingContext.m
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/04.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import "ARParsingContext.h"

#import "ARVM.h"

@implementation ARParsingContext
	{
	ARByteCodeArray* byteCode;
	}
	
- (void) generateByteCode
	{
	self.theCompiledMethod = [[ARVM activeVM] newCompiledMethod];
	self.theCompiledMethod.method = self.theMethod;
	byteCode = self.theCompiledMethod.byteCode;
	[self.theRootNode generateByteCodeFor: self.theCompiledMethod];
	}
	
@end
