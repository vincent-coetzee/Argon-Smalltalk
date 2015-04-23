//
//  ARASTKeywordInvocationCode.h
//  Talk
//
//  Created by Vincent Coetzee on 2014/11/25.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import "ARASTInvocationNode.h"

@interface ARASTKeywordInvocationNode : ARASTInvocationNode

- (void) addKeyword: (NSString*) keyword;
- (void) addArgument: (ARASTExpressionNode*) argument;

@end
