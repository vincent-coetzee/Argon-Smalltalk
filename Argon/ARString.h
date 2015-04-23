//
//  ARString.h
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/03.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import "ARObject.h"

//
// String Layout
//
// Value			Offset
// =======================
// header			0
// size in words	1
// class pointer	2
// length in bytes	3
// bytes			4
//

@interface ARString : ARObject

@property(readwrite,assign) NSString* NSString;
@property(readwrite,assign) WORD lengthInBytes;
@property(readonly) char* bytesPointer;
@property(readonly,assign) WORD hashcode;

@end
