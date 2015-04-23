//
//  ARASTVariableNode.m
//  Talk
//
//  Created by Vincent Coetzee on 2014/11/22.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import "ARASTVariableNode.h"

@implementation ARASTVariableNode

+ (instancetype) withName: (NSString*) name
	{
	ARASTVariableNode* node;
	
	node = [[self alloc] init];
	node.name = name;
	return(node);
	}
	
- (id) init
	{
	self = [super init];
	if (self)
		{
		self.name = @"";
		}
	return(self);
	}
	
- (NSString*) description
	{
	return([NSString stringWithFormat: @"VARIABLE(%@)",self.name]);
	}
	
- (void) generateByteCodeFor: (ARCompiledMethod*) method
	{
	NSLog(@"VARIABLE %@ SHOULD NEVER BE ACCSSED IN CODE GEN",self.name);
	}
	
@end
