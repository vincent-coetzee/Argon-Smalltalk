//
//  ARInstructionVector.h
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/03.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import "ARArray.h"

@class ARVM;
@class ARMachineInstruction;

@interface ARByteCodeArray : ARArray

- (void) primitive: (WORD) number;
- (void) popTemp: (WORD) index;
- (void) pushTemp: (WORD) index;
- (void) pushLiteral: (WORD) index;
- (void) send;
- (void) ret;
- (ARMachineInstruction*) decodeInstructionAtIndex: (WORD) index;
- (void) print;

@end
