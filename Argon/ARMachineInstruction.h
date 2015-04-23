//
//  ARMachineInstruction.h
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/03.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARObject.h"

//
// STACK RELATED INSTRUCTIONS
//
// All instructions that hadle pushing of popping of various 
// values on or off the stack have opcodes with values between
// 10 and 100
//
#define OP_PUSH_IVAR	(10)
#define OP_POP_IVAR		(30)
#define OP_POP			(31)
#define OP_DUP			(32)
#define OP_SWAP			(33)
#define OP_PUSH_LIT		(40)
#define OP_PUSH_TEMP	(50)
#define OP_POP_TEMP		(60)
#define OP_PUSH_SELF	(80)
#define OP_PUSH_NIL		(81)
//
// Message sending and object management
//
// The instructions that handle the sending of messages
// and the creation and management of objects all fall
// into the 100 to 200 range
//

#define OP_SEND			(100)

//
// Control Instructions
//
// All control instructions fall into the 200 to 300 range. These
// instructions managed the locus of control as well as branching
// and flow control
//

#define OP_JMP_ABS		(200)
#define OP_JMP_REL		(201)
#define OP_JMP_ABS_EQ	(202)
#define OP_JMP_ABS_NEQ	(203)
#define OP_JMP_REL_EQ	(204)
#define OP_JMP_REL_NEQ	(205)

#define OP_RET			(280)
#define OP_PRIM			(281)


@interface ARMachineInstruction : NSObject

@property(readwrite,assign) WORD opcode;
@property(readwrite,assign) WORD operand;

- (void) print;

@end
