//
//  ARString.m
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/03.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import "ARString.h"
#import "ARHashing.h"

#define OFFSET_LENGTH	(3)
#define OFFSET_BYTES	(4)

@implementation ARString

- (WORD) lengthInBytes
	{
	return([self wordAtOffset: OFFSET_LENGTH]);
	}
	
- (void) setLengthInBytes: (WORD) length
	{
	[self setWord: length atOffset: OFFSET_LENGTH];
	}
	
- (NSString*) NSString
	{
	char* bytesPointer;
	
	bytesPointer = (char*)(self.objectPointer + OFFSET_BYTES);
	return([NSString stringWithUTF8String: bytesPointer]);
	}
	
- (void) setNSString: (NSString*) string
	{
	char* bytesPointer;
	
	bytesPointer = (char*)(self.objectPointer + OFFSET_BYTES);
	strcpy(bytesPointer,[string UTF8String]);
	self.lengthInBytes = [string length];
	}
	
- (char*) bytesPointer
	{
	return((char*)(self.objectPointer + OFFSET_BYTES));
	}
	
- (WORD) hashcode
	{
	return((WORD)fasthash64([self.NSString UTF8String],self.lengthInBytes,0));
	}
	
@end
