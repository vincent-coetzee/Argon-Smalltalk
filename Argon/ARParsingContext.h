//
//  ARParsingContext.h
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/04.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ARCompiledMethod.h"
#import "ARMethod.h"
#import "ARASTMethodRootNode.h"

@interface ARParsingContext : NSObject

@property(readwrite,strong) ARCompiledMethod* theCompiledMethod;
@property(readwrite,strong) ARMethod* theMethod;
@property(readwrite,strong) ARClass* theClass;
@property(readwrite,strong) ARASTMethodRootNode* theRootNode;

- (void) generateByteCode;

@end
