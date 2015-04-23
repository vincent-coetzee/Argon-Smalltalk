//
//  ARCompiledMethod.m
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/03.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import "ARCompiledMethod.h"

#define OFFSET_LITS		(3)
#define OFFSET_TEMPS	(4)
#define OFFSET_BYTECODE	(5)
#define OFFSET_PREV_ACT	(6)
#define OFFSET_SP		(7)
#define OFFSET_HANDLERS	(8)
#define OFFSET_METHOD	(9)

@implementation ARCompiledMethod

- (ARArray*) literalFrame
	{
	return([ARArray objectAtPointer: (WORD*)[self wordAtOffset: OFFSET_LITS]]);
	}
	
- (void) setLiteralFrame: (ARArray*) frame
	{
	[self setWord: (WORD)frame.objectPointer atOffset: OFFSET_LITS];
	}
	
- (ARArray*) temporaryFrame
	{
	return([ARArray objectAtPointer: (WORD*)[self wordAtOffset: OFFSET_TEMPS]]);
	}
	
- (void) setTemporaryFrame: (ARArray*) frame
	{
	[self setWord: (WORD)frame.objectPointer atOffset: OFFSET_TEMPS];
	}	

- (ARByteCodeArray*) byteCode
	{
	return([ARByteCodeArray objectAtPointer: (WORD*)[self wordAtOffset: OFFSET_BYTECODE]]);
	}
	
- (void) setByteCode: (ARByteCodeArray*) frame
	{
	[self setWord: (WORD)frame.objectPointer atOffset: OFFSET_BYTECODE];
	}
	
- (ARObject*) previousActivation
	{
	return([ARByteCodeArray objectAtPointer: (WORD*)[self wordAtOffset: OFFSET_PREV_ACT]]);
	}
	
- (void) setPreviousActivation: (ARObject*) frame
	{
	[self setWord: (WORD)frame.objectPointer atOffset: OFFSET_PREV_ACT];
	}

- (WORD) stackPointerOnEntry
	{
	return([self wordAtOffset: OFFSET_SP]);
	}
	
- (void) setStackPointerOnEntry: (WORD) frame
	{
	[self setWord: frame atOffset: OFFSET_SP];
	}
	
- (ARArray*) exceptionHandlers
	{
	return([ARArray objectAtPointer: (WORD*)[self wordAtOffset: OFFSET_HANDLERS]]);
	}
	
- (void) setExceptionHandlers: (ARArray*) frame
	{
	[self setWord: (WORD)frame.objectPointer atOffset: OFFSET_HANDLERS];
	}

- (ARMethod*) method
	{
	return([ARMethod objectAtPointer: (WORD*)[self wordAtOffset: OFFSET_METHOD]]);
	}
	
- (void) setMethod: (ARMethod*) frame
	{
	[self setWord: (WORD)frame.objectPointer atOffset: OFFSET_METHOD];
	}

@end
