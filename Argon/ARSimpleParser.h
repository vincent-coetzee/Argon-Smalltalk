//
//  ARASTSmalltalkParser.h
//  Talk
//
//  Created by Vincent Coetzee on 2014/11/22.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARCompiledMethod.h"
#import "ARMethod.h"
#import "ARParsingContext.h"

@class ARASTMethodNode;

@interface ARSimpleParser : NSObject

- (ARParsingContext*) parseMethod: (ARMethod*) aMethod forClass: (ARClass*) aClass;

@end
