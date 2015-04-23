//
//  ARMethod.m
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/04.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import "ARMethod.h"
#import "ARCompiledMethod.h"

#define OFFSET_NAME			(3)
#define OFFSET_SELECTOR		(4)
#define OFFSET_SOURCE		(5)
#define OFFSET_COMPILED		(6)

@implementation ARMethod

- (ARString*) methodName
	{
	return([ARString objectAtPointer: (WORD*)[self wordAtOffset: OFFSET_NAME]]);
	}
	
- (void) setMethodName: (ARString*) frame
	{
	[self setWord: (WORD)frame.objectPointer atOffset: OFFSET_NAME];
	}
	
- (ARSymbol*) methodSelector
	{
	return([ARSymbol objectAtPointer: (WORD*)[self wordAtOffset: OFFSET_SELECTOR]]);
	}
	
- (void) setMethodSelector: (ARSymbol*) frame
	{
	[self setWord: (WORD)frame.objectPointer atOffset: OFFSET_SELECTOR];
	}
	
- (ARString*) methodSource
	{
	return([ARSymbol objectAtPointer: (WORD*)[self wordAtOffset: OFFSET_SOURCE]]);
	}
	
- (void) setMethodSource: (ARString*) frame
	{
	[self setWord: (WORD)frame.objectPointer atOffset: OFFSET_SOURCE];
	}
	
- (ARCompiledMethod*) compiledMethod
	{
	return([ARCompiledMethod objectAtPointer: (WORD*)[self wordAtOffset: OFFSET_COMPILED]]);
	}
	
- (void) setCompiledMethod: (ARCompiledMethod*) frame
	{
	[self setWord: (WORD)frame.objectPointer atOffset: OFFSET_COMPILED];
	}	
	
@end
