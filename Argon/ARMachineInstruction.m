//
//  ARMachineInstruction.m
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/03.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import "ARMachineInstruction.h"

#define OP_JMP_ABS		(200)
#define OP_JMP_REL		(201)
#define OP_JMP_ABS_EQ	(202)
#define OP_JMP_ABS_NEQ	(203)
#define OP_JMP_REL_EQ	(204)
#define OP_JMP_REL_NEQ	(205)

#define OP_RET			(280)
#define OP_PRIM			(281)

@implementation ARMachineInstruction

- (void) print
	{
	switch(self.opcode)
		{
	case(OP_PUSH_IVAR):
		NSLog(@"PUSH IVAR %lu",self.operand);
		break;
	case(OP_POP_IVAR):	
		NSLog(@"POP IVAR %lu",self.operand);
		break;
	case(OP_POP):
		NSLog(@"DUP");
		break;
	case(OP_DUP):
		NSLog(@"SWAP");
		break;
	case(OP_PUSH_LIT):
		NSLog(@"PUSH LIT %lu",self.operand);
		break;
	case(OP_PUSH_TEMP):
		NSLog(@"PUSH TEMP %lu",self.operand);
		break;
	case(OP_POP_TEMP):
		NSLog(@"POP TEMP %lu",self.operand);
		break;
	case(OP_PUSH_SELF):
		NSLog(@"PUSH SELF");
		break;
	case(OP_PUSH_NIL):
		NSLog(@"PUSH NIL");
		break;
	case(OP_SEND):
		NSLog(@"SEND");
		break;
	case(OP_JMP_ABS):
		NSLog(@"JMP ABS %lu",self.operand);
		break;
	case(OP_JMP_REL):
		NSLog(@"JMP REL %lu",self.operand);
		break;
	case(OP_JMP_ABS_EQ):
		NSLog(@"JMP ABS EQ%lu",self.operand);
		break;
	case(OP_JMP_ABS_NEQ):
		NSLog(@"JMP ABS NEQ%lu",self.operand);
		break;
	case(OP_JMP_REL_EQ):
		NSLog(@"JMP REL EQ%lu",self.operand);
		break;
	case(OP_JMP_REL_NEQ):
		NSLog(@"JMP REL NEQ%lu",self.operand);
		break;
	case(OP_RET):
		NSLog(@"RET");
		break;
	case(OP_PRIM):
		NSLog(@"PRIM %lu",self.operand);
		break;
	default:
		NSLog(@"UNKNOWN OPCODE");
		break;
		}
	}
	
@end
