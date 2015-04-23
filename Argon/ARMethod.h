//
//  ARMethod.h
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/04.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import "ARObject.h"
#import "ARSymbol.h"
#import "ARString.h"

@class ARCompiledMethod;

@interface ARMethod : ARObject

@property(readwrite) ARString* methodName;
@property(readwrite) ARSymbol* methodSelector;
@property(readwrite) ARString* methodSource;
@property(readwrite) ARCompiledMethod* compiledMethod;

@end
