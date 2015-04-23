//
//  ARObject.m
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/02.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import "ARObject.h"
#import "ARClass.h"
#import "ARVM.h"

@interface ARObject ()

- (void) setObjectPointer:(ARObjectPointer) pointer;

@end

@implementation ARObject
	{
	WORD* _pointer;
	}
	
+ (instancetype) objectAtPointer: (ARObjectPointer) pointer
	{
	ARObject* object;
	
	object = [self new];
	[object setObjectPointer: pointer];
	return(object);
	}
	
+ (instancetype) objectWithInt: (WORD) word
	{
	word <<= TAG_BITS;
	word |= TAG_INT;
	return([self objectAtPointer:(WORD*)word]);
	}
	
+ (instancetype) objectWithDouble: (double) aDouble
	{
	WORD* wordPointer;
	WORD mask;
	
	mask = TAG_MASK;
	mask = ~mask;
	wordPointer = (WORD*)&aDouble;
	*wordPointer &= mask;
	*wordPointer |= TAG_DOUBLE;
	return([self objectAtPointer:(WORD*)*wordPointer]);
	}
	
- (BOOL) isTagged
	{
	return((((WORD)_pointer) & TAG_TAG) == TAG_TAG);
	}
	
- (WORD) tag
	{
	WORD pointerWord;
	
	pointerWord = (WORD)_pointer;
	return(pointerWord & TAG_MASK);
	}
	
- (WORD) intValue
	{
	return(((WORD)_pointer)>>4);
	}
	
- (double) doubleValue
	{
	WORD word;
	double* doublePointer;
	
	word = ((WORD)_pointer);
	word &= ~TAG_MASK;
	doublePointer = (double*)&word;
	return(*doublePointer);
	}
	
- (WORD) hashcode
	{
	ARString* className;
	ARClass* aClass;
	NSString* name;
	
	aClass = self.objectClass;
	if (aClass.isNil)
		{
		return((WORD)_pointer);
		}
	className = aClass.className;
	name = className.NSString;
	if ([name isEqualToString: @"String"] || [name isEqualToString: @"Symbol"])
		{
		return([[ARString objectAtPointer: _pointer] hashcode]);
		}
	return((WORD)_pointer);
	}
	
+ (instancetype) objectWithObject: (ARObject*) object
	{
	return([self objectAtPointer: object.objectPointer]);
	}
	
+ (ARObject*) nilObject
	{
	return([[ARVM activeVM] nilObject]);
	}
	
- (ARString*) asString
	{
	return([ARString objectAtPointer: self.objectPointer]);
	}
	
- (BOOL) isAssociation
	{
	return([self.objectClass.NSStringClassName isEqualToString: @"Association"]);
	}
	
- (BOOL) isLinkedList
	{
	return([self.objectClass.NSStringClassName isEqualToString: @"LinkedList"]);
	}
	
- (BOOL) isString
	{
	return([self.objectClass.NSStringClassName isEqualToString: @"String"]);
	}

- (BOOL) isEqualToObject: (ARObject*) object
	{
	return(_pointer == object.objectPointer);
	}
	
- (BOOL) isNil
	{
	return(_pointer == nil);
	}
	
- (BOOL) isEqualTo: (ARObject*) object
	{
	return(self.objectPointer == object.objectPointer);
	}
	
- (WORD) wordAtOffset: (WORD) index
	{
	return(*(_pointer+index));
	}
	
- (void) setWord: (WORD) value atOffset: (WORD) index
	{
	*(_pointer+index) = value;
	}
	
- (void) setObjectPointer: (ARObjectPointer) pointer
	{
	_pointer = pointer;
	}
	
- (ARObjectPointer) objectPointer
	{
	return(_pointer);
	}
	
- (WORD) objectHeader
	{
	return([self wordAtOffset: OFFSET_HEADER]);
	}
	
- (void) setObjectHeader: (WORD) header
	{
	[self setWord: header atOffset: OFFSET_HEADER];
	}
	
- (ARClass*) objectClass
	{
	return([ARClass objectAtPointer: (ARObjectPointer)[self wordAtOffset: OFFSET_CLASS]]);
	}
	
- (void) setObjectClass: (ARClass*) aClass
	{
	[self setWord: (WORD)aClass.objectPointer atOffset: OFFSET_CLASS];
	}
	
- (WORD) objectSizeInWords
	{
	return([self wordAtOffset: OFFSET_SIZE]);
	}
	
- (void) setObjectSizeInWords: (WORD) size
	{
	[self setWord: size atOffset: OFFSET_SIZE];
	}

- (ARObject*) instanceVariableAtIndex: (WORD) index
	{
	return([ARObject objectAtPointer: (WORD*)[self wordAtOffset: OFFSET_CONTENTS + index]]);
	}
	
- (void) setInstanceVariable: (ARObject*) value atIndex: (WORD) index
	{
	[self setWord: (WORD)value.objectPointer atOffset: OFFSET_CONTENTS+index];
	}
	
- (WORD) intValueAtIndex: (WORD) index
	{
	WORD value;
	
	value = [self wordAtOffset: OFFSET_CONTENTS+index];
	value >>= TAG_BITS;
	return(value);
	}
	
- (void) setIntValue: (WORD) word atIndex: (WORD) index
	{
	word <<= TAG_BITS;
	word |= TAG_INT;
	[self setWord: word atOffset: OFFSET_CONTENTS+index];
	}
	
- (BOOL) isIndexed
	{
	return((self.objectHeader & HEADER_MASK_INDEXED) == HEADER_MASK_INDEXED);
	}
	
- (BOOL) isBytes
	{
	return((self.objectHeader & HEADER_MASK_BYTES) == HEADER_MASK_BYTES);
	}
	
@end
