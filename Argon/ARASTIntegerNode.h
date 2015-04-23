//
//  ARASTIntegerNode.h
//  Talk
//
//  Created by Vincent Coetzee on 2014/11/25.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import "ARASTExpressionNode.h"

@interface ARASTIntegerNode : ARASTExpressionNode

@property(readwrite,assign) NSUInteger longValue;

@end
