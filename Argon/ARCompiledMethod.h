//
//  ARCompiledMethod.h
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/03.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import "ARObject.h"
#import "ARArray.h"
#import "ARByteCodeArray.h"
#import "ARMethod.h"

@interface ARCompiledMethod : ARObject

@property(readwrite) ARArray* literalFrame;
@property(readwrite) ARArray* temporaryFrame;
@property(readwrite) ARByteCodeArray* byteCode;
@property(readwrite) ARObject* previousActivation;
@property(readwrite,assign) WORD stackPointerOnEntry;
@property(readwrite) ARArray* exceptionHandlers;
@property(readwrite) ARMethod* method;

@end
