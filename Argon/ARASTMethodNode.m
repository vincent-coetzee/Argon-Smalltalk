//
//  ARASTSmalltalkMethodNode.m
//  Talk
//
//  Created by Vincent Coetzee on 2014/11/22.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import "ARASTMethodNode.h"
#import "ARASTStatementNode.h"
#import "ARASTParameterNode.h"
#import "ARASTTemporaryNode.h"
#import "ARByteCodeArray.h"

@implementation ARASTMethodNode
	{
	__strong NSMutableDictionary* _parametersByName;
	__strong NSMutableArray* _parameters;
	__strong NSMutableDictionary* _temporariesByName;
	__strong NSMutableArray* _temporaries;
	__strong NSMutableArray* _statements;
	__strong ARByteCodeArray* _byteCode;
	}
	
- (id) init
	{
	self = [super init];
	if (self)
		{
		_parametersByName = [NSMutableDictionary dictionary];
		_temporariesByName = [NSMutableDictionary dictionary];
		_temporaries = [NSMutableArray array];
		_parameters = [NSMutableArray array];
		_statements = [NSMutableArray array];
		}
	return(self);
	}
	
- (ARByteCodeArray*) bytecodes
	{
	return(_byteCode);
	}
	
//- (void) emitByteCodeInByteArray: (ARByteCodeArray*) buffer
//	{
//	NSUInteger tempFrameSize;
//	NSInteger offset;
//	
//	tempFrameSize = _parameters.count + _temporaries.count;
//	_temporaryFrameSize = tempFrameSize;
//	_literalFrameSize = 0;
//	[buffer enterWithTemporaryFrameOfSize: tempFrameSize];
//	offset = _parameters.count-1;
//	for (ARASTParameterNode* node in _parameters)
//		{
//		[buffer popAndStoreTemp: offset];
//		node.offset = offset;
//		offset--;
//		}
//	offset = _parameters.count;
//	for (ARASTTemporaryNode* node in _temporaries)
//		{
//		node.offset = offset++;
//		}
//	for (ARASTStatementNode* node in _statements)
//		{
//		node.bytecodeStartOffset = [buffer currentOffset];
//		[node emitByteCodeInByteArray: buffer];
//		node.bytecodeStopOffset = [buffer currentOffset];
//		}
//	}
	
- (ARASTVariableNode*) resolveName: (NSString*) name
	{
	ARASTVariableNode* node;
	
	if ((node = _parametersByName[name]) != nil)
		{
		return(node);
		}
	return(_temporariesByName[name]);
	}
	
- (void) addStatement: (ARASTStatementNode*) statement
	{
	[_statements addObject: statement];
	}
	
- (void) addParameterName: (NSString*) name
	{
	ARASTParameterNode* node;
	
	node = [ARASTParameterNode withName: name];
	_parametersByName[name] = node;
	[_parameters addObject: node];
	}
	
- (void) addTemporaryName: (NSString*) name
	{
	ARASTTemporaryNode* node;
	
	node =  [ARASTTemporaryNode withName: name];
	_temporariesByName[name] = node;
	[_temporaries addObject: node];
	}
	
@end
