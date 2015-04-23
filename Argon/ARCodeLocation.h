//
//  ARASTCodeLocation.h
//  TheTalk
//
//  Created by Vincent Coetzee on 2014/11/26.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARCodeLocation : NSObject

@property(readwrite,assign) NSUInteger sourceCodeStart;
@property(readwrite,assign) NSUInteger sourceCodeStop;
@property(readwrite,assign) NSUInteger bytecodeStart;
@property(readwrite,assign) NSUInteger bytecodeStop;

@end
