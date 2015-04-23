//
//  ARASTSmalltalkNode.h
//  Talk
//
//  Created by Vincent Coetzee on 2014/11/22.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARByteCodeArray.h"
#import "ARCompiledMethod.h"

@interface ARASTNode : NSObject

- (NSString*) description;
- (void) generateByteCodeFor: (ARCompiledMethod*) method;

@end
