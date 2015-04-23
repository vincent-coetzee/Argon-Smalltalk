//
//  ARObject.h
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/02.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import <Foundation/Foundation.h>

#define OFFSET_HEADER	(0)
#define OFFSET_SIZE		(1)
#define OFFSET_CLASS	(2)
#define OFFSET_CONTENTS	(3)

#define HEADER_MASK_SHIFT	(61)
#define HEADER_MASK_INT		(((WORD)0)<<HEADER_MASK_SHIFT)
#define HEADER_MASK_OBJECT	(((WORD)1)<<HEADER_MASK_SHIFT)
#define HEADER_MASK_INDEXED	(((WORD)2)<<HEADER_MASK_SHIFT)
#define HEADER_MASK_DOUBLE	(((WORD)3)<<HEADER_MASK_SHIFT)
#define HEADER_MASK_BYTES	(((WORD)4)<<HEADER_MASK_SHIFT)

#define TAG_TAG				((WORD)1)
#define TAG_MASK			((WORD)15)
#define TAG_OBJECT			((WORD)0)
#define TAG_INT				((WORD)3)
#define TAG_DOUBLE			((WORD)5)
#define TAG_BITS			((WORD)4)

//
// Object Layout
//
// Value			Offset
// =======================
// header			0
// sizeInWords		1
// class pointer	2
// contents			3
//
//

@class ARClass;
@class ARString;

typedef unsigned long WORD;
typedef WORD* ARObjectPointer;

@interface ARObject : NSObject

@property(readwrite,assign) WORD objectHeader;
@property(readwrite,assign) ARClass* objectClass;
@property(readwrite,assign) WORD objectSizeInWords;
@property(readonly,assign) ARObjectPointer objectPointer;
@property(readonly,assign) BOOL isBytes;
@property(readonly,assign) BOOL isIndexed;
@property(readonly,assign) BOOL isNil;
@property(readonly,assign) BOOL isTagged;
@property(readonly,assign) WORD tag;
@property(readonly,assign) WORD wordValue;
@property(readonly,assign) double doubleValue;

+ (instancetype) objectAtPointer: (ARObjectPointer) pointer;
+ (instancetype) objectWithObject: (ARObject*) object;
+ (instancetype) objectWithInt: (WORD) word;
+ (instancetype) objectWithDouble: (double) aDouble;

+ (ARObject*) nilObject;
- (ARObject*) instanceVariableAtIndex: (WORD) index;
- (void) setInstanceVariable: (ARObject*) value atIndex: (WORD) index;
- (unsigned long) wordAtOffset: (unsigned long) index;
- (void) setWord: (unsigned long) value atOffset: (unsigned long) index;
- (BOOL) isEqualToObject: (ARObject*) object;
- (BOOL) isAssociation;
- (BOOL) isLinkedList;
- (BOOL) isString;
- (ARString*) asString;
- (BOOL) isEqualTo: (ARObject*) object;
- (WORD) hashcode;

@end
