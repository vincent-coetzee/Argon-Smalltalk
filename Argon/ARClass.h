//
//  ARClass.h
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/03.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import "ARObject.h"

#define CLASS_SIZE_IN_WORDS (8)

@class ARString;
@class ARArray;
@class ARDictionary;

//
// Class Layout
//
// Value					Offset	Content Offset
// ===========================================
// header					0		-3
// size in words			1		-2
// class pointer			2		-1
// class name				3		0
// instance size in words	4		1	
// byte object flag			5		2
// instance variable names	6		3
// method dictionary		7		4
// superclass				8		5
// indexed object flag		9		6
// source					10		7
// total size in words		11		8

@interface ARClass : ARObject

@property(readwrite) NSString* NSStringClassName;
@property(readwrite) ARString* className;
@property(readwrite,assign) WORD instanceSizeInWords;
@property(readwrite) ARArray* instanceVariableNames;
@property(readwrite) ARDictionary* methodDictionary;
@property(readwrite) ARClass* classSuperclass;
@property(readwrite,assign) WORD bytesObject;
@property(readwrite,assign) WORD indexedObject;
@property(readonly) NSArray* allSubclasses;
@property(readwrite) ARString* classSource;
@property(readwrite,assign) WORD totalInstanceSizeInWords;

- (NSString*) generateClassSourceNSString;
- (ARString*) sourceForMethodWithName: (ARString*) name;

@end
