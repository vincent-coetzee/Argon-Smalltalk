//
//  ARInstructionVector.m
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/03.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import "ARByteCodeArray.h"
#import "ARVM.h"
#import "ARMachineInstruction.h"

#define MASK_OPCODE		0xFFFFFFFF00000000
#define MASK_OPERAND	0x00000000FFFFFFFF

@implementation ARByteCodeArray

- (ARMachineInstruction*) decodeInstructionAtIndex: (WORD) index
	{
	WORD storedInstruction;
	ARMachineInstruction* instruction;
	
	storedInstruction = [self elementAtIndex: index];
	instruction = [ARMachineInstruction new];
	instruction.opcode = (storedInstruction & MASK_OPCODE) >> 32;
	instruction.operand = storedInstruction & MASK_OPERAND;
	return(instruction);
	}
	
- (void) print
	{
	WORD index;
	WORD count;
	ARMachineInstruction* instruction;
	
	count = self.count;
	for (index=0;index<count;index++)
		{
		instruction = [self decodeInstructionAtIndex: index];
		[instruction print];
		}
	}
	
- (void) pushLiteral: (WORD) index
	{
	[self emitOpCode: OP_PUSH_LIT operand: index];
	}
	
- (void) send
	{
	[self emitOpCode: OP_SEND operand: 0];
	}
	
- (void) ret
	{
	[self emitOpCode: OP_RET operand: 0];
	}
	
- (void) pushTemp: (WORD) index
	{
	[self emitOpCode: OP_PUSH_TEMP operand: index];
	}
	
- (void) popTemp: (WORD) index
	{
	[self emitOpCode: OP_POP_TEMP operand: index];
	}
	
- (void) primitive: (WORD) index
	{
	[self emitOpCode: OP_PRIM operand: index];
	}

- (void) emitWord: (WORD) aWord
	{
	WORD count;
	
	count = self.count;
	[self setElement: aWord atIndex: count++];
	self.count = count;
	}
	
- (void) emitOpCode: (WORD) code operand: (WORD) operand
	{
	WORD count;
	
	code &= !MASK_OPCODE;
	code <<= 32;
	operand &= MASK_OPERAND;
	operand = code | operand;
	count = self.count;
	[self setElement: operand atIndex: count++];
	self.count = count;
	}
	
@end
