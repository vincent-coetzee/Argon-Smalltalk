//
//  ARASTKeywordInvocationCode.m
//  Talk
//
//  Created by Vincent Coetzee on 2014/11/25.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import "ARASTKeywordInvocationNode.h"
#import "ARVM.h"

@implementation ARASTKeywordInvocationNode
	{
	__strong NSMutableArray* _arguments;
	__strong NSMutableArray* _keywords;
	}
	
- (id) init
	{
	self = [super init];
	if (self)
		{
		_arguments = [NSMutableArray array];
		_keywords = [NSMutableArray array];
		}
	return(self);
	}
	
- (NSString*) description
	{
	return([NSString stringWithFormat: @"%@ PERFORM %@ ARGUMENTS %@",self.operand,self.selectorString,[self argumentsString]]);
	}
	
- (void) generateByteCodeFor: (ARCompiledMethod*) method
	{
	WORD index;
	
	[self.operand generateByteCodeFor: method];
	for (ARASTExpressionNode* node in _arguments)
		{
		[node generateByteCodeFor: method];
		}
	index = [method.literalFrame addObjectElement: [[ARVM activeVM] stringWithNSString: self.selectorString]];
	[method.byteCode pushLiteral: index];
	[method.byteCode send];
	}
	
- (NSString*) argumentsString
	{
	NSMutableString* string;
	int index = 0;
	
	for (ARASTExpressionNode* node in _arguments)
		{
		[string appendString: node.description];
		if (index < _arguments.count-1)
			{
			[string appendString: @","];
			}
		}
	return(string);
	}
	
- (NSString*) selectorString
	{
	return([_keywords componentsJoinedByString: @""]);
	}
	
- (void) setSelectorString: (NSString*) string
	{
	}
	
- (void) addKeyword: (NSString*) keyword
	{
	[_keywords addObject: keyword];
	}
	
- (void) addArgument: (ARASTExpressionNode*) argument
	{
	[_arguments addObject: argument];
	}
	
@end
