//
//  ARASTMethodRootNode.m
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/04.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import "ARASTMethodRootNode.h"
#import "ARASTParameterNode.h"
#import "ARASTTemporaryNode.h"
#import "ARByteCodeArray.h"
#import "ARVM.h"

@implementation ARASTMethodRootNode
	{
	__strong NSMutableArray* statements;
	__strong NSMutableArray* temporaries;
	__strong NSMutableDictionary* temporariesByName;
	__strong NSMutableArray* literals;
	__strong NSMutableArray* parameters;
	__strong NSMutableDictionary* parametersByName;
	__strong ARClass* theClass;
	__strong ARMethod* theMethod;
	}
	
- (id) init
	{
	self = [super init];
	if (self)
		{
		statements = [NSMutableArray array];
		literals = [NSMutableArray array];
		temporaries = [NSMutableArray array];
		temporariesByName = [NSMutableDictionary dictionary];
		parameters = [NSMutableArray array];
		parametersByName = [NSMutableDictionary dictionary];
		}
	return(self);
	}
	
- (void) setMethodSelector: (NSString*) string
	{
	theMethod.methodSelector = [[ARVM activeVM] symbolWithNSString: string];
	}
	
- (NSString*) methodSelector
	{
	return(theMethod.methodSelector.NSString);
	}
	
- (void) addParameterName: (NSString*) name
	{
	ARASTParameterNode* node;
	
	node = [ARASTParameterNode withName: name];
	parametersByName[name] = node;
	[parameters addObject: node];
	}
	
- (void) addTemporaryName: (NSString*) name
	{
	ARASTTemporaryNode* node;
	
	node =  [ARASTTemporaryNode withName: name];
	temporariesByName[name] = node;
	[temporaries addObject: node];
	}
	
- (void) setMethod: (ARMethod*) aMethod
	{
	theMethod = aMethod;
	}

- (void) setMethodClass: (ARClass*) aClass
	{
	theClass = aClass;
	}

- (void) addStatement: (ARASTNode*) node
	{
	[statements addObject: node];
	}
	
- (void) addTemporary: (ARASTNode*) node
	{
	[temporaries addObject: node];
	}
	
- (ARASTVariableNode*) resolveName: (NSString*) name
	{
	ARASTVariableNode* node;
	
	if ((node = parametersByName[name]) != nil)
		{
		return(node);
		}
	return(temporariesByName[name]);
	}
	
- (void) generateByteCodeFor: (ARCompiledMethod*) aMethod
	{
	WORD offset;
	ARByteCodeArray* buffer;
	
	buffer = aMethod.byteCode;
	offset = parameters.count-1;
	for (ARASTParameterNode* node in parameters)
		{
		[buffer popTemp: offset];
		node.offset = offset;
		offset--;
		}
	offset = parameters.count;
	for (ARASTTemporaryNode* node in temporaries)
		{
		node.offset = offset++;
		}
	for (ARASTStatementNode* node in statements)
		{
//		node.bytecodeStartOffset = [buffer currentOffset];
		[node generateByteCodeFor: aMethod];
//		node.bytecodeStopOffset = [buffer currentOffset];
		}
	}
	
@end
