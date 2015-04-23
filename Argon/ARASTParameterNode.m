//
//  ARASTParameterNode.m
//  Talk
//
//  Created by Vincent Coetzee on 2014/11/22.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import "ARASTParameterNode.h"

@implementation ARASTParameterNode

- (void) generateByteCodeFor: (ARCompiledMethod*) method
	{
	[method.byteCode pushTemp: self.offset];
	}
	
- (NSString*) description
	{
	return([NSString stringWithFormat: @"PARM(%@)",self.name]);
	}
@end
