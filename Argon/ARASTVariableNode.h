//
//  ARASTVariableNode.h
//  Talk
//
//  Created by Vincent Coetzee on 2014/11/22.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import "ARASTExpressionNode.h"

@interface ARASTVariableNode : ARASTExpressionNode

@property(readwrite,strong) NSString* name;
@property(readwrite,assign) NSInteger offset;

+ (instancetype) withName: (NSString*) name;

@end
