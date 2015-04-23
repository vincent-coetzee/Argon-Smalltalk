//
//  ARMemoryTests.m
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/03.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "ARVM.h"
#import "ARString.h"
#import "ARClass.h"
#import "ARByteCodeArray.h"
#import "ARDictionary.h"
#import "ARSymbol.h"

@interface ARVMTests : XCTestCase

@end

@implementation ARVMTests

- (void)setUp 
	{
    [super setUp];
    [ARVM initVM];
	}

- (void)tearDown 
	{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
	}

- (void) testBasicObjects
	{
	ARObject* object;
	
	object = [[ARVM activeVM] newObjectWithSize: 0];
//	XCTAssert(object.objectHeader == 1,@"Object header should be 1");
	XCTAssert(object.objectSizeInWords == 0,@"Object size in words should be 0");
	}
	
- (void) testStrings
	{
    ARString* string1;
	ARString* string2;
	
	string1 = [[ARVM activeVM] stringWithNSString: @"Vincent"];
	XCTAssert(string1.lengthInBytes == 7,@"'Vincent' should be of length 7");
	string2 = [[ARVM activeVM] stringWithNSString: @"Vincent"];
	XCTAssert([string1.NSString isEqualToString: string2.NSString],@"'Vincent' should equal 'Vincent'");
    XCTAssert(string1.isBytes == YES,@"String should be a byte object class");
	XCTAssert([string1.objectClass.NSStringClassName isEqualToString: @"String"],@"'String' class name should be 'String'");
	XCTAssert([string1.objectClass.classSuperclass.NSStringClassName isEqualToString: @"Collection"],@"'String' class superclass name should be 'Collection'");
	}
	
- (void) testDictionaries
	{
	ARString* key1;
	ARString* key2;
	ARString* key3;
	ARString* value1;
	ARString* value2;
	ARString* value3;
	ARDictionary* dict;
	ARString* badKey;
	ARString* temp;
	NSArray* keys;
	NSArray* values;
	
	badKey = [[ARVM activeVM] stringWithNSString: @"BadKey"];
	key1 = [[ARVM activeVM] stringWithNSString: @"Vincent"];
	key2 = [[ARVM activeVM] stringWithNSString: @"Vanessa"];
	key3 = [[ARVM activeVM] stringWithNSString: @"Louis"];
	value1 = [[ARVM activeVM] stringWithNSString: @"Vincent-Value"];
	value2 = [[ARVM activeVM] stringWithNSString: @"Vanessa-Value"];
	value3 = [[ARVM activeVM] stringWithNSString: @"Louis-Value"];
	dict = [[ARVM activeVM] newDictionaryWithMaximum: 256];
	[dict setValue: value1 forKey: key1];
	[dict setValue: value2 forKey: key2];
	[dict setValue: value3 forKey: key3];
	XCTAssert([dict valueForKey: badKey] == [ARObject nilObject],@"BadKey should have nil return value for valueForKey");
	XCTAssert([[dict valueForKey: key1] isEqual: value1],@"Value for key Vincent should be Vincent-Value");
	temp = [ARString objectAtPointer: [dict valueForKey: key1].objectPointer];
	XCTAssert([temp.NSString isEqualToString: @"Vincent-Value"],@"Value for key Vincent should be Vincent-Value");
	keys = [dict allKeys];
	for (ARString* string in keys)
		{
		NSLog(@"KEY = %@",string.NSString);
		}
	values = [dict allValues];
	for (ARString* string in values)
		{
		NSLog(@"VALUE = %@",[string asString].NSString);
		}
	}
	
- (void) testSymbols
	{
	ARSymbol* symbol1;
	ARSymbol* symbol2;
	ARVM* vm;
	
	vm = [ARVM activeVM];
	symbol1 = [vm symbolWithNSString: @"Symbol"];
	symbol2 = [vm symbolWithNSString: @"Symbol"];
	XCTAssert([symbol1 isEqualTo: symbol2],@"symbol1 and symbol2 should be identical");
	NSLog(@"symbol1 string value is %@",symbol1.NSString);
	XCTAssert([symbol1.NSString isEqualToString: @"Symbol"],"symbol1 NSString value should be Symbol and it is not");
	}
	
- (void) testInstructionArray
	{
	ARByteCodeArray* vector;
	ARVM* vm;
	
	vm = [ARVM activeVM];
	vector = [vm newByteCodeArrayWithMaximum: 1024];
//	[vector emitPushObject: vector];
//	[vector emitPushInstanceVarAtIndex: 0];
//	[vector emitRet];
//	[vm executeInstructionVector: vector];
	}

- (void) testStringPerformance 
	{
    [self measureBlock:
		^{
		ARString* string1;
        string1 = [[ARVM activeVM] stringWithNSString: @"Vincent"];
		}];
	}

@end
