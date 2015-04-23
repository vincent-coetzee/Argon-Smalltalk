//
//  ARClass.m
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/03.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import "ARClass.h"
#import "ARString.h"
#import "ARVM.h"
#import "ARDictionary.h"

#define OFFSET_CLASS_NAME		(3)
#define OFFSET_INSTANCE_SIZE	(4)
#define OFFSET_BYTES			(5)
#define OFFSET_IVAR_NAMES		(6)
#define OFFSET_METHOD_DICT		(7)
#define OFFSET_SUPERCLASS		(8)
#define OFFSET_INDEXED			(9)
#define OFFSET_CLASS_SOURCE		(10)
#define OFFSET_TOTAL_SIZE		(11)

@implementation ARClass

- (NSArray*) allSubclasses
	{
	ARVM* vm;
	
	vm = [ARVM activeVM];
	return([vm allSubclassesOfClassWithName: self.NSStringClassName]);
	}
	
- (NSString*) sourceForMethodWithName: (ARString*) name
	{
	ARDictionary* dict;
	ARMethod* method;
	ARObject* value;
	ARString* source;
	
	dict = self.methodDictionary;
	if (dict.isNil)
		{
		return(@"");
		}
	value = [dict valueForKey: name];
	if (value.isNil)
		{
		return(@"");
		}
	method = [ARMethod objectAtPointer: value.objectPointer];
	source = method.methodSource;
	if (source.isNil)
		{
		return(@"");
		}
	return(source.NSString);
	}
	
- (NSString*) generateClassSourceNSString
	{
	NSString* string;
	NSString* format;
	NSString* className;
	NSString* ivarNames;
	
	format = @"%@ subclass #%@.\n\n%@ instanceVariableNames: %@.\n";
	if (self.instanceVariableNames.isNil)
		{
		ivarNames = @"''";
		}
	else
		{
		ivarNames = [self.instanceVariableNames instanceVarNSString];
		}
	className = self.NSStringClassName;
	if (self.classSuperclass.isNil)
		{
		string = [NSString stringWithFormat: format,@"Nil",className,className,ivarNames];
		}
	else
		{
		string = [NSString stringWithFormat: format,self.classSuperclass.NSStringClassName,className,className,ivarNames];
		}
	return(string);
	}
	
- (NSString*) NSStringClassName
	{
	ARString* string;
	
	string = [ARString objectAtPointer: (WORD*)[self wordAtOffset: OFFSET_CLASS_NAME]];
	return(string.NSString);
	}
	
- (void) setNSStringClassName: (NSString*) string
	{
	ARString* rawString;
	
	rawString = [[ARVM activeVM] stringWithNSString: string];
	[self setWord: (WORD)rawString.objectPointer atOffset: OFFSET_CLASS_NAME];
	}
	
- (ARString*) className
	{
	return([ARString objectAtPointer: (WORD*)[self wordAtOffset: OFFSET_CLASS_NAME]]);
	}
	
- (void) setClassName: (ARString*) string
	{
	[self setWord: (WORD)string.objectPointer atOffset: OFFSET_CLASS_NAME];
	}
	
- (WORD) instanceSizeInWords
	{
	return([self wordAtOffset: OFFSET_INSTANCE_SIZE]);
	}
	
- (void) setInstanceSizeInWords: (WORD) size
	{
	[self setWord: size atOffset: OFFSET_INSTANCE_SIZE];
	}
	
- (WORD) totalInstanceSizeInWords
	{
	return([self wordAtOffset: OFFSET_TOTAL_SIZE]);
	}
	
- (void) setTotalInstanceSizeInWords: (WORD) size
	{
	[self setWord: size atOffset: OFFSET_TOTAL_SIZE];
	}
	
- (WORD) bytesObject
	{
	return([self wordAtOffset: OFFSET_BYTES]);
	}
	
- (void) setBytesObject: (WORD) size
	{
	[self setWord: size atOffset: OFFSET_BYTES];
	}
	
- (WORD) indexedObject
	{
	return([self wordAtOffset: OFFSET_INDEXED]);
	}
	
- (void) setIndexedObject: (WORD) size
	{
	[self setWord: size atOffset: OFFSET_INDEXED];
	}
	
- (ARArray*) instanceVariableNames
	{
	return([ARArray objectAtPointer: [self wordAtOffset: OFFSET_IVAR_NAMES]]);
	}
	
- (void) setInstanceVariableNames: (ARArray*) array
	{
	[self setWord: (WORD)array.objectPointer atOffset: OFFSET_IVAR_NAMES];
	}
	
- (ARDictionary*) methodDictionary
	{
	return([ARDictionary objectAtPointer: (WORD*)[self wordAtOffset: OFFSET_METHOD_DICT]]);
	}
	
- (void) setMethodDictionary: (ARDictionary*) array
	{
	[self setWord: (WORD)array.objectPointer atOffset: OFFSET_METHOD_DICT];
	}

- (ARClass*) classSuperclass
	{
	return([ARClass objectAtPointer: (WORD*)[self wordAtOffset: OFFSET_SUPERCLASS]]);
	}
	
- (void) setClassSuperclass: (ARClass*) aClass
	{
	[self setWord: (WORD)aClass.objectPointer atOffset: OFFSET_SUPERCLASS];
	}
	
- (void) setClassSource: (ARString*) source
	{
	[self setWord: (WORD) source.objectPointer atOffset: OFFSET_CLASS_SOURCE];
	}
		
- (ARString*) classSource
	{
	return([ARString objectAtPointer: (WORD*)[self wordAtOffset: OFFSET_CLASS_SOURCE]]);
	}
	
@end
