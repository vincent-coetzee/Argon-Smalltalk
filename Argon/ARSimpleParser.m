//
//  ARASTSmalltalkParser.m
//  Talk
//
//  Created by Vincent Coetzee on 2014/11/22.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import "ARSimpleParser.h"
#import "ARParseException.h"
#import "ARASTMethodNode.h"
#import "ARSimpleTokenStream.h"
#import "ARASTStatementNode.h"
#import "ARASTNotExpressionNode.h"
#import "ARASTAssignNode.h"
#import "ARASTKeywordInvocationNode.h"
#import "ARASTBinaryInvocationNode.h"
#import "ARASTUnaryInvocationNode.h"
#import "ARASTReturnNode.h"
#import "ARASTIntegerNode.h"
#import "ARCompiledMethod.h"
#import "ARVM.h"
#import "ARASTMethodRootNode.h"
#import "ARParsingContext.h"

@implementation ARSimpleParser
	{
	__strong ARSimpleTokenStream* tokenStream;
	__strong ARSimpleToken* token;
	unsigned long characterOffset;
	__weak NSString* sourceString;
	__strong ARASTMethodRootNode* rootNode;
	__strong ARMethod* method;
	}
	
+ (instancetype) parserOnString: (NSString*) string
	{
	ARSimpleParser* parser;
	
	parser = [self new];
	[parser setSourceString: string];
	return(parser);
	}
	
- (void) setSourceString: (NSString*) string
	{
	tokenStream = [ARSimpleTokenStream onString: string];
	sourceString = string;
	}
	
- (ARParsingContext*) parseMethod: (ARMethod*) aMethod forClass: (ARClass*) aClass
	{
	ARParsingContext* context;
	
	rootNode = [ARASTMethodRootNode new];
	[rootNode setMethodClass: aClass];
	[rootNode setMethod: aMethod];
	[self setSourceString: aMethod.methodSource.NSString];
	[self parseMessagePattern];
	[self parseTemporaries];
	[self parseStatements];
	context = [ARParsingContext new];
	context.theClass = aClass;
	context.theMethod = aMethod;
	context.theRootNode = rootNode;
	[context generateByteCode];
	return(context);
	}
	
- (void) parseStatements
	{
	NSUInteger start;
	ARASTStatementNode* node;
	
	while (![token isEOF])
		{
		start = characterOffset;
		[rootNode addStatement: (node = [self parseStatement])];
		node.startCharacterOffset = start;
		node.stopCharacterOffset = characterOffset;
		}
	}
	
- (ARASTExpressionNode*) parseSimpleExpression
	{
	ARASTVariableNode* variable;
	ARASTExpressionNode* node;
	ARASTIntegerNode* intNode;
	
	if ([token isLeftPar])
		{
		[self nextToken];
		node = [self parseExpression];
		if (![token isRightPar])
			{
			[ARParseException raise: @"PARSEEXCEPTION" format: @") expected"];
			}
		[self nextToken];
		return(node);
		}
	else if ([token isIdentifier])
		{
		variable = [rootNode resolveName: token.stringValue];
		if (variable != nil)
			{
			[self nextToken];
			return(variable);
			}
		}
	else if ([token isInteger])
		{
		intNode = [ARASTIntegerNode new];
		intNode.longValue = token.longValue;
		[self nextToken];
		return(intNode);
		}
	[ARParseException raise: @"PARSEEXCEPTION" format: @"expression expected"];
	return(nil);
	}
	
- (ARASTExpressionNode*) parseExpression
	{
	ARASTVariableNode* variable;
	ARASTExpressionNode* node;
	ARASTIntegerNode* intNode;
	
	if ([token isLeftPar])
		{
		[self nextToken];
		node = [self parseExpression];
		if (![token isRightPar])
			{
			[ARParseException raise: @"PARSEEXCEPTION" format: @") expected"];
			}
		[self nextToken];
		return(node);
		}
	else if ([token isIdentifier])
		{
		variable = [rootNode resolveName: token.stringValue];
		if (variable != nil)
			{
			[self nextToken];
			if ([token isKeyword])
				{
				return([self parseKeywordExpression: variable]);
				}
			else if ([token isSpecialCharacter])
				{
				return([self parseBinaryExpression: variable]);
				}
			else if ([token isIdentifier])
				{
				return([self parseUnaryExpression: variable]);
				}
			return(variable);
			}
		}
	else if ([token isInteger])
		{
		intNode = [ARASTIntegerNode new];
		intNode.longValue = token.longValue;
		[self nextToken];
		if ([token isKeyword])
			{
			return([self parseKeywordExpression: intNode]);
			}
		else if ([token isSpecialCharacter])
			{
			return([self parseBinaryExpression: intNode]);
			}
		else if ([token isIdentifier])
			{
			return([self parseUnaryExpression: intNode]);
			}
		return(intNode);
		}
	[ARParseException raise: @"PARSEEXCEPTION" format: @"expression expected"];
	return(nil);
	}
	
- (ARASTExpressionNode*) parseKeywordExpression: (ARASTExpressionNode*) receiver
	{
	ARASTKeywordInvocationNode* node;
	
	node = [ARASTKeywordInvocationNode new];
	node.operand = receiver;
	while ([token isKeyword])
		{
		[node addKeyword: token.stringValue];
		[self nextToken];
		[node addArgument: [self parseSimpleExpression]];
		}
	return(node);
	}
	
- (ARASTExpressionNode*) parseBinaryExpression: (ARASTExpressionNode*) value
	{
	ARASTBinaryInvocationNode* node;
	
	if (value == nil)
		{
		NSLog(@"halt");
		}
	node = [ARASTBinaryInvocationNode new];
	node.operand = value;
	node.selectorString = [token tokenSelectorString];
	[self nextToken];
	node.argument = [self parseSimpleExpression];
	return(node);
	}
	
- (ARASTStatementNode*) parseUnaryExpression: (ARASTExpressionNode*) receiver
	{
	ARASTUnaryInvocationNode* node;
	
	node = [ARASTUnaryInvocationNode new];
	node.operand = receiver;
	node.selectorString = token.stringValue;
	[self nextToken];
	return(node);
	}
	
- (ARASTStatementNode*) parseStatement
	{
	ARASTExpressionNode* first;
	ARASTNotExpressionNode* notNode;
	ARASTReturnNode* returnNode;
	ARASTAssignNode* assign;
	ARASTExpressionNode* result;
	
	if ([token isBang])
		{
		[self nextToken];
		notNode = [ARASTNotExpressionNode new];
		notNode.argument = [self parseExpression];
		result = notNode;
		}
	else if ([token isCaret])
		{
		[self nextToken];
		returnNode = [ARASTReturnNode new];
		returnNode.argument = [self parseExpression];
		result = returnNode;
		}
	else
		{
		first = [self parseExpression];
		if ([token isAssign])
			{
			assign = [ARASTAssignNode new];
			assign.operand = first;
			[self nextToken];
			assign.argument = [self parseExpression];
			result = assign;
			}
		}
	if ([token isPeriod])
		{
		[self nextToken];
		}
	return(result);
	}
	
- (void) parseTemporaries
	{
	if ([token isBar])
		{
		[self nextToken];
		do
			{
			if (![token isIdentifier])
				{
				[ARParseException raise: @"PARSEEXCEPTION" format: @"Temporary name expected"];
				}
			[rootNode addTemporaryName: token.stringValue];
			[self nextToken];
			}
		while ([token isIdentifier]);
		if (![token isBar])
			{
			[ARParseException raise: @"PARSEEXCEPTION" format: @"| expected"];
			}
		[self nextToken];
		}
	}
	
- (void) parseMessagePattern
	{
	NSMutableString* keywordSelector;
	
	[self nextToken];
	if ([token isIdentifier])
		{
		rootNode.methodSelector = token.stringValue;
		[self nextToken];
		}
	else if ([token isSpecialCharacter])
		{
		rootNode.methodSelector = [token tokenSelectorString];
		[self nextToken];
		if (![token isIdentifier])
			{
			[ARParseException raise: @"PARSEEXCEPTION" format: @"Parameter name expected"];
			}
		[rootNode addParameterName: token.stringValue];
		[self nextToken];
		}
	else if ([token isKeyword])
		{
		keywordSelector = [NSMutableString new];
		
		do
			{
			[keywordSelector appendString: token.stringValue];
			[self nextToken];
			if (![token isIdentifier])
				{
				[ARParseException raise: @"PARSEEXCEPTION" format: @"Parameter name expected"];
				}
			[rootNode addParameterName: token.stringValue];
			[self nextToken];
			}
		while ([token isKeyword]);
		rootNode.methodSelector = keywordSelector;
		}
	else
		{
		[ARParseException raise: @"PARSEEXCEPTION" format: @"Unary selector or binary selector or keyword selector expected"];
		}
	}
	
- (void) nextToken
	{
	token = [tokenStream nextToken];
	characterOffset = token.characterOffset;
	[token println];
	}
@end
