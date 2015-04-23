//
//  ARVM.m
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/03.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import "ARVM.h"
#import "ARClass.h"
#import "gc.h"
#import "ARHashing.h"
#import "ARArray.h"
#import "ARByteCodeArray.h"
#import "ARSymbol.h"
#import "ARDictionary.h"
#import "ARLinkedList.h"
#import "ARAssociation.h"
#import "ARMethod.h"
#import "ARCompiledMethod.h"

#define OBJECT_HEADER_SIZE	(3)
#define PRIMITIVE_COUNT		(2)

static __strong ARVM* ActiveVM;

typedef void (^ARPrimitiveBlock)(void);

@implementation ARVM
	{
	__strong ARClass* classClass;
	__strong ARClass* metaClassClass;
	__strong ARClass* stringClass;
	__strong ARClass* symbolClass;
	__strong ARClass* undefinedObjectClass;
	__strong ARClass* objectClass;
	__strong ARClass* collectionClass;
	__strong ARClass* methodClass;
	__strong ARClass* arrayClass;
	__strong ARClass* instructionArrayClass;
	__strong ARClass* dictionaryClass;
	__strong ARClass* bagClass;
	__strong ARClass* setClass;
	__strong ARClass* compiledMethodClass;
	__strong ARClass* booleanClass;
	__strong ARClass* trueClass;
	__strong ARClass* falseClass;
	__strong ARClass* indexedCollectionClass;
	__strong ARClass* metaclassClass;
	__strong ARClass* magnitudeClass;
	__strong ARClass* numberClass;
	__strong ARClass* fractionClass;
	__strong ARClass* doubleClass;
	__strong ARClass* integerClass;
	__strong ARClass* characterClass;
	__strong ARClass* dateClass;
	__strong ARClass* timeClass;
	__strong ARClass* behaviorClass;
	__strong ARClass* classDescriptionClass;
	__strong ARClass* pointClass;
	__strong ARClass* associationClass;
	__strong ARClass* linkedListClass;
	__strong ARClass* methodActivationFrameClass;
	
	__strong ARObject* nilObject;
	__strong ARDictionary* symbolTable;
	__strong NSMutableDictionary* classes;
	
	WORD* _stack;
	WORD _stackSize;
	WORD* _sp;
	ARPrimitiveBlock _primitives[PRIMITIVE_COUNT];
	}
	
+ (void) initVM
	{
	GC_INIT();
	ActiveVM = [self new];
	}
//
// Init a VM
//
- (id) init
	{
	self = [super init];
	if (self)
		{
		classes = [NSMutableDictionary dictionary];
		NSLog(@"WORD SIZE FOR VM IS %ld",sizeof(WORD));
		[self initBaseClasses];
		[self initStack];
		[self initPrimitives];
		[self initSymbolTable];
		nilObject = [ARObject objectAtPointer: 0];
		}
	return(self);
	}
//
// Return the active VM
//
+ (instancetype) activeVM
	{
	return(ActiveVM);
	}
//
// Init the symbol table for use by the system. Various other objects may
// have their own symbol tables for various things but this is the major
// one for use by the system.
//
- (void) initSymbolTable
	{
	symbolTable = [self newDictionaryWithMaximum: 1024*1024];
	}
//
// Return the VMs nil object
//
- (ARObject*) nilObject
	{
	return(nilObject);
	}
//
// Return all the class proxies that we are currently aware of
//
- (NSArray*) allRootClasses
	{
	return(@[objectClass,undefinedObjectClass]);
	}
//
// Initialize the table of primitives
//
- (void) initPrimitives
	{
	[self initPrimitive1];
	}
//
// Initialize primitive1 - calculate a hash value for the string on the top of
// the stack and push the calculated hash value 
//
- (void) initPrimitive1
	{
	_primitives[0] = 
		^{
		ARString* string;
		
		string = [ARString objectAtPointer: (WORD*)[self popWord]];
		[self pushWord: fasthash64(string.bytesPointer,string.lengthInBytes,(WORD)string.objectPointer)];
		};
	}
//
// Initialize primitive2 - pop the index and vector off the stack,
// push the element in the vector at the given index on to the stack
//
- (void) initPrimitive2
	{
	_primitives[1] = 
		^{
		ARArray* vector;
		WORD index;
		
		index = [self popWord];
		vector = [ARArray objectAtPointer: (WORD*)[self popWord]];
		[self pushWord: [vector elementAtIndex: index]]; 
		};
	}
//
// Initialize the stack that will be used by the VM. 
// The stack is allocated from the garbage collected memory so
// that objects that are on the stack are considered roots to avoid
// them being collected when they are on the stack
//
- (void) initStack
	{
	_stackSize = 1024;
	_stack = GC_MALLOC_UNCOLLECTABLE(_stackSize*sizeof(WORD));
	_sp = _stack + (_stackSize - 1);
	}
//
// Push a raw object onto the stack
//
- (void) pushWord: (WORD) aWord
	{
	*_sp-- = aWord;
	}
//
// Pop a raw object off the stack
//
- (WORD) popWord
	{
	return(*--_sp);
	}
//
// Push the object proxied by the object proxy onto the stack
//
- (void) pushObject: (ARObject*) object
	{
	[self pushWord: (WORD)object.objectPointer];
	}
//
// Pop a raw word off the stack and wrap it in an object proxy
//
- (ARObject*) popObject
	{
	return([ARObject objectAtPointer: (WORD*)[self popWord]]);
	}
//
// Return all the classes that are subclasses of the class
// with the specified name
//
- (NSArray*) allSubclassesOfClassWithName: (NSString*) name
	{
	NSMutableArray* subclasses;
	
	subclasses = [NSMutableArray array];
	for (ARClass* aClass in [classes allValues])
		{
		if (!aClass.classSuperclass.isNil)
			{
			if ([aClass.classSuperclass.NSStringClassName isEqualToString: name])
				{
				[subclasses addObject: aClass];
				}
			}
		}
	return([subclasses sortedArrayUsingComparator: ^(id o1, id o2) 
		{
		return([[o1 NSStringClassName] compare: [o2 NSStringClassName]]);;
		}]);
	}
//
// Init the base classes that the VM needs to boot
//
- (void) initBaseClasses
	{
	[self initStringClass];
	[self initSymbolClass];
	[self initObjectClass];
	[self initBehaviorClass];
	[self initClassDescriptionClass];
	[self initMetaclassClass];
	[self initClassClass];
	[self initCollectionClass];
	[self backpatchClasses];
	[self initLinkedListClass];
	[self initAssociationClass];
	[self initUndefinedObjectClass];
	[self initMethodClass];
	[self initIndexedCollectionClass];
	[self initArrayClass];
	[self initInstructionArrayClass];
	[self initCompiledMethodClass];
	[self initBooleanClass];
	[self initTrueClass];
	[self initFalseClass];
	[self initMagnitudeClass];
	[self initNumberClass];
	[self initFractionClass];
	[self initDoubleClass];
	[self initIntegerClass];
	[self initCharacterClass];
	[self initDateClass];
	[self initTimeClass];
	[self initBagClass];
	[self initSetClass];
	[self initDictionaryClass];
	[self initPointClass];
	}
//
// Create an instance of the given class, this assumes that the
// object is not a bytes based object or an indexed object. Use the appropiate
// methods to create either an indexed object or a bytes based object
//
- (ARObject*) newObjectOfClass: (ARClass*) aClass
	{
	ARObject* newObject;
	WORD sizeInWords;
	
	sizeInWords = aClass.instanceSizeInWords;
	newObject = [self newObjectWithSize: sizeInWords];
	newObject.objectClass = aClass;
	return(newObject);
	}
//
// Init the class that manages linked lists
//
- (void) initLinkedListClass
	{
	ARClass* aClass;
	ARArray* iVarNames;
	
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"LinkedList"];
	iVarNames = [self newArrayWithMaximum: 2];
	[iVarNames setObjectElement: [self stringWithNSString: @"nextNode"] atIndex: 0];
	[iVarNames setObjectElement: [self stringWithNSString: @"value"] atIndex: 1];
	iVarNames.count = 2;
	aClass.instanceVariableNames = iVarNames;
	aClass.instanceSizeInWords = 2;
	aClass.indexedObject = NO;
	aClass.bytesObject = NO;
	aClass.classSuperclass = collectionClass;
	aClass.objectClass = classClass;
	linkedListClass = aClass;
	classes[@"LinkedList"] = linkedListClass;
	}
//
// Init the class that holds the references in a dictionary
//
- (void) initAssociationClass
	{
	ARClass* aClass;
	ARArray* iVarNames;
	
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"Association"];
	iVarNames = [self newArrayWithMaximum: 2];
	[iVarNames setObjectElement: [self stringWithNSString: @"key"] atIndex: 0];
	[iVarNames setObjectElement: [self stringWithNSString: @"value"] atIndex: 1];
	iVarNames.count = 2;
	aClass.instanceVariableNames = iVarNames;
	aClass.instanceSizeInWords = 2;
	aClass.indexedObject = NO;
	aClass.bytesObject = NO;
	aClass.classSuperclass = objectClass;
	aClass.objectClass = classClass;
	associationClass = aClass;
	classes[@"Association"] = associationClass;
	}
//
// Init the class that acts as the parent of all arrays
//
- (void) initBagClass
	{
	ARClass* aClass;
	
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"Bag"];
	aClass.instanceSizeInWords = 0;
	aClass.indexedObject = NO;
	aClass.bytesObject = NO;
	aClass.classSuperclass = collectionClass;
	aClass.objectClass = classClass;
	bagClass = aClass;
	classes[@"Bag"] = bagClass;
	}
//
// Init the class that handles sets
//
- (void) initSetClass
	{
	ARClass* aClass;
	
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"Set"];
	aClass.instanceSizeInWords = 0;
	aClass.indexedObject = NO;
	aClass.bytesObject = NO;
	aClass.classSuperclass = collectionClass;
	aClass.objectClass = classClass;
	setClass = aClass;
	classes[@"Set"] = setClass;
	}
//
// Init the class that handles sets
//
- (void) initDictionaryClass
	{
	ARClass* aClass;
	ARArray* iVarNames;
	
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"Dictionary"];
	iVarNames = [self newArrayWithMaximum: 2];
	[iVarNames setObjectElement: [self stringWithNSString: @"count"] atIndex: 0];
	[iVarNames setObjectElement: [self stringWithNSString: @"maximum"] atIndex: 1];
	iVarNames.count = 2;
	aClass.instanceVariableNames = iVarNames;
	aClass.instanceSizeInWords = 0;
	aClass.indexedObject = NO;
	aClass.bytesObject = NO;
	aClass.classSuperclass = collectionClass;
	aClass.objectClass = classClass;
	dictionaryClass = aClass;
	classes[@"Dictionary"] = dictionaryClass;
	}
//
// Init the class that acts as the parent of all arrays
//
- (void) initCharacterClass
	{
	ARClass* aClass;
	
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"Character"];
	aClass.instanceSizeInWords = 1;
	aClass.indexedObject = NO;
	aClass.bytesObject = NO;
	aClass.classSuperclass = magnitudeClass;
	aClass.objectClass = classClass;
	characterClass = aClass;
	classes[@"Character"] = characterClass;
	}
//
// Init the class that acts as the parent of all arrays
//
- (void) initPointClass
	{
	ARClass* aClass;
	ARArray* iVarNames;
	
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"Point"];
	iVarNames = [self newArrayWithMaximum: 2];
	[iVarNames setObjectElement: [self stringWithNSString: @"x"] atIndex: 0];
	[iVarNames setObjectElement: [self stringWithNSString: @"y"] atIndex: 1];
	iVarNames.count = 2;
	aClass.instanceVariableNames = iVarNames;
	aClass.instanceSizeInWords = 2;
	aClass.indexedObject = NO;
	aClass.bytesObject = NO;
	aClass.classSuperclass = magnitudeClass;
	aClass.objectClass = classClass;
	pointClass = aClass;
	classes[@"Point"] = pointClass;
	}
//
// Init the class that acts as the parent of all arrays
//
- (void) initMagnitudeClass
	{
	ARClass* aClass;
	
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"Magnitude"];
	aClass.instanceSizeInWords = 0;
	aClass.indexedObject = NO;
	aClass.bytesObject = NO;
	aClass.classSuperclass = objectClass;
	aClass.objectClass = classClass;
	magnitudeClass = aClass;
	classes[@"Magnitude"] = magnitudeClass;
	}
//
// Init the class that acts as the parent of all arrays
//
- (void) initNumberClass
	{
	ARClass* aClass;
	
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"Number"];
	aClass.instanceSizeInWords = 0;
	aClass.indexedObject = NO;
	aClass.bytesObject = NO;
	aClass.classSuperclass = magnitudeClass;
	aClass.objectClass = classClass;
	numberClass = aClass;
	classes[@"Number"] = numberClass;
	}
//
// Init the class that acts as the parent of all arrays
//
- (void) initDateClass
	{
	ARClass* aClass;
	
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"Date"];
	aClass.instanceSizeInWords = 0;
	aClass.indexedObject = NO;
	aClass.bytesObject = NO;
	aClass.classSuperclass = magnitudeClass;
	aClass.objectClass = classClass;
	dateClass = aClass;
	classes[@"Date"] = dateClass;
	}
//
// Init the class that acts as the parent of all arrays
//
- (void) initTimeClass
	{
	ARClass* aClass;
	
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"Time"];
	aClass.instanceSizeInWords = 0;
	aClass.indexedObject = NO;
	aClass.bytesObject = NO;
	aClass.classSuperclass = magnitudeClass;
	aClass.objectClass = classClass;
	timeClass = aClass;
	classes[@"Time"] = timeClass;
	}
//
// Init the class that acts as the parent of all arrays
//
- (void) initDoubleClass
	{
	ARClass* aClass;
	
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"Double"];
	aClass.instanceSizeInWords = 0;
	aClass.indexedObject = NO;
	aClass.bytesObject = NO;
	aClass.classSuperclass = numberClass;
	aClass.objectClass = classClass;
	doubleClass = aClass;
	classes[@"Double"] = doubleClass;
	}
//
// Init the class that acts as the parent of all arrays
//
- (void) initIntegerClass
	{
	ARClass* aClass;
	
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"Integer"];
	aClass.instanceSizeInWords = 0;
	aClass.indexedObject = NO;
	aClass.bytesObject = NO;
	aClass.classSuperclass = numberClass;
	aClass.objectClass = classClass;
	integerClass = aClass;
	classes[@"Integer"] = integerClass;
	}
//
// Init the class that acts as the parent of all arrays
//
- (void) initFractionClass
	{
	ARClass* aClass;
	ARArray* iVarNames;
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"Fraction"];
	iVarNames = [self newArrayWithMaximum: 2];
	[iVarNames setObjectElement: [self stringWithNSString: @"numerator"] atIndex: 0];
	[iVarNames setObjectElement: [self stringWithNSString: @"denominator"] atIndex: 1];
	iVarNames.count = 2;
	aClass.instanceVariableNames = iVarNames;
	aClass.instanceSizeInWords = 2;
	aClass.indexedObject = NO;
	aClass.bytesObject = NO;
	aClass.classSuperclass = numberClass;
	aClass.objectClass = classClass;
	fractionClass = aClass;
	classes[@"Fraction"] = fractionClass;
	}
//
// Init the class that acts as the parent of all arrays
//
- (void) initArrayClass
	{
	ARClass* aClass;
	
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"Array"];
	aClass.instanceSizeInWords = 2;
	aClass.indexedObject = YES;
	aClass.bytesObject = NO;
	aClass.classSuperclass = indexedCollectionClass;
	aClass.objectClass = classClass;
	arrayClass = aClass;
	classes[@"Array"] = arrayClass;
	}
//
// Init the class that acts as the parent of all arrays
//
- (void) initIndexedCollectionClass
	{
	ARClass* aClass;
	
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"IndexedCollection"];
	aClass.instanceSizeInWords = 2;
	aClass.indexedObject = YES;
	aClass.bytesObject = NO;
	aClass.classSuperclass = collectionClass;
	aClass.objectClass = classClass;
	indexedCollectionClass = aClass;
	classes[@"IndexedCollection"] = indexedCollectionClass;
	}
//
// Init the true class
//
- (void) initTrueClass
	{
	ARClass* aClass;
	
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"True"];
	aClass.instanceSizeInWords = 0;
	aClass.indexedObject = NO;
	aClass.bytesObject = NO;
	aClass.classSuperclass = booleanClass;
	aClass.objectClass = classClass;
	trueClass = aClass;
	classes[@"True"] = trueClass;
	}
//
// Init the false class
//
- (void) initFalseClass
	{
	ARClass* aClass;
	
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"False"];
	aClass.instanceSizeInWords = 0;
	aClass.indexedObject = NO;
	aClass.bytesObject = NO;
	aClass.classSuperclass = booleanClass;
	aClass.objectClass = classClass;
	falseClass = aClass;
	classes[@"False"] = falseClass;
	}
//
// Init the boolean class
//
- (void) initBooleanClass
	{
	ARClass* aClass;
	
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"Boolean"];
	aClass.instanceSizeInWords = 0;
	aClass.indexedObject = NO;
	aClass.bytesObject = NO;
	aClass.classSuperclass = objectClass;
	aClass.objectClass = classClass;
	booleanClass = aClass;
	classes[@"Boolean"] = booleanClass;
	}
//
// Instruction vectors hold executable code, init the class
// that will manage these
//
- (void) initInstructionArrayClass
	{
	ARClass* aClass;
	
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"InstructionArray"];
	aClass.instanceSizeInWords = 0;
	aClass.indexedObject = YES;
	aClass.bytesObject = NO;
	aClass.classSuperclass = arrayClass;
	aClass.objectClass = classClass;
	instructionArrayClass = aClass;
	classes[@"InstructionArray"] = instructionArrayClass;
	}
//
// Init the class we will use to manage methods
//
- (void) initMethodClass
	{
	ARClass* aClass;
	ARArray* iVarNames;
	
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"Method"];
	iVarNames = [self newArrayWithMaximum: 4];
	[iVarNames setObjectElement: [self stringWithNSString: @"methodName"] atIndex: 0];
	[iVarNames setObjectElement: [self stringWithNSString: @"methodSelector"] atIndex: 1];
	[iVarNames setObjectElement: [self stringWithNSString: @"methodSource"] atIndex: 2];
	[iVarNames setObjectElement: [self stringWithNSString: @"compiledMethod"] atIndex: 3];
	aClass.instanceVariableNames = iVarNames;
	iVarNames.count = 4;
	aClass.instanceSizeInWords = 0;
	aClass.indexedObject = NO;
	aClass.bytesObject = NO;
	aClass.classSuperclass = objectClass;
	aClass.objectClass = classClass;
	methodClass = aClass;
	classes[@"Method"] = methodClass;
	}
//
// Init the class we will use to manage methods
//
- (void) initCompiledMethodClass
	{
	ARClass* aClass;
	ARArray* iVarNames;
	
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"CompiledMethod"];
	iVarNames = [self newArrayWithMaximum: 7];
	[iVarNames setObjectElement: [self stringWithNSString: @"literalFrame"] atIndex: 0];
	[iVarNames setObjectElement: [self stringWithNSString: @"temporaryFrame"] atIndex: 1];
	[iVarNames setObjectElement: [self stringWithNSString: @"byteCode"] atIndex: 2];
	[iVarNames setObjectElement: [self stringWithNSString: @"previousActivation"] atIndex: 3];
	[iVarNames setObjectElement: [self stringWithNSString: @"stackPointerOnEntry"] atIndex: 4];
	[iVarNames setObjectElement: [self stringWithNSString: @"exceptionHandlers"] atIndex: 5];
	[iVarNames setObjectElement: [self stringWithNSString: @"method"] atIndex: 6];
	iVarNames.count = 7;
	aClass.instanceVariableNames = iVarNames;
	aClass.instanceSizeInWords = 7;
	aClass.indexedObject = NO;
	aClass.bytesObject = NO;
	aClass.classSuperclass = objectClass;
	aClass.objectClass = classClass;
	compiledMethodClass = aClass;
	classes[@"CompiledMethod"] = compiledMethodClass;
	}
//
// Back patch the created classes with the class
// information that did not exist when they were created
//
- (void) backpatchClasses
	{
	stringClass.objectClass = classClass;
	stringClass.classSuperclass = collectionClass;
	objectClass.objectClass = classClass;
	collectionClass.objectClass = classClass;
	collectionClass.classSuperclass = objectClass;
	symbolClass.objectClass = classClass;
	}
//
// Init the superclass of collections, Collection
//
- (void) initCollectionClass
	{
	ARClass* aClass;
	
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"Collection"];
	aClass.instanceSizeInWords = 0;
	aClass.indexedObject = NO;
	aClass.bytesObject = NO;
	aClass.classSuperclass = objectClass;
	aClass.objectClass = classClass;
	aClass.totalInstanceSizeInWords = 0;
	collectionClass = aClass;
	classes[@"Collection"] = collectionClass;
	}
//
// Init the Object class
//
- (void) initObjectClass
	{
	ARClass* aClass;
	
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"Object"];
	aClass.methodDictionary = [self newDictionaryWithMaximum: 512];
	aClass.instanceSizeInWords = 0;
	aClass.indexedObject = NO;
	aClass.bytesObject = NO;
	aClass.totalInstanceSizeInWords = 0;
	objectClass = aClass;
	classes[@"Object"] = objectClass;
	}
//
// Init the Class class
//
- (void) initClassClass
	{
	ARClass* aClass;
	
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"Class"];
	aClass.instanceSizeInWords = 0;
	aClass.indexedObject = NO;
	aClass.bytesObject = NO;
	aClass.classSuperclass = classDescriptionClass;
	aClass.objectClass = aClass;
	aClass.totalInstanceSizeInWords = 0;
	classClass = aClass;
	classes[@"Class"] = classClass;
	}
//
// Init the Class class
//
- (void) initClassDescriptionClass
	{
	ARClass* aClass;
	
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"ClassDescription"];
	aClass.instanceSizeInWords = 0;
	aClass.indexedObject = NO;
	aClass.bytesObject = NO;
	aClass.classSuperclass = behaviorClass;
	aClass.objectClass = aClass;
	aClass.totalInstanceSizeInWords = 0;
	classDescriptionClass = aClass;
	classes[@"ClassDescription"] = classDescriptionClass;
	}
//
// Init the Behavior class
//
- (void) initBehaviorClass
	{
	ARClass* aClass;
	
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"Behavior"];
	aClass.instanceSizeInWords = 0;
	aClass.indexedObject = NO;
	aClass.bytesObject = NO;
	aClass.classSuperclass = objectClass;
	aClass.objectClass = aClass;
	aClass.totalInstanceSizeInWords = 0;
	behaviorClass = aClass;
	classes[@"Behavior"] = behaviorClass;
	}
//
// Init the Class class
//
- (void) initMetaclassClass
	{
	ARClass* aClass;
	
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"Metaclass"];
	aClass.instanceSizeInWords = 0;
	aClass.indexedObject = NO;
	aClass.bytesObject = NO;
	aClass.classSuperclass = classDescriptionClass;
	aClass.objectClass = aClass;
	aClass.totalInstanceSizeInWords = 0;
	metaclassClass = aClass;
	classes[@"MetaClass"] = metaclassClass;
	}
//
// Init the undefined object class, the class pointers will be
// backpatched once the class and meta class objects have been
// created
//
- (void) initUndefinedObjectClass
	{
	ARClass* aClass;
	
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"UndefinedObject"];
	aClass.instanceSizeInWords = 0;
	aClass.indexedObject = NO;
	aClass.bytesObject = NO;
	aClass.totalInstanceSizeInWords = 0;
	undefinedObjectClass = aClass;
	classes[@"UndefinedObject"] = undefinedObjectClass;
	}
//
// Init the String class that we will use for storing
// strings that are used by the VM
//
- (void) initStringClass
	{
	ARClass* aClass;
	
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"String"];
	aClass.indexedObject = YES;
	aClass.bytesObject = YES;
	aClass.instanceSizeInWords = 0;
	aClass.indexedObject = YES;
	aClass.bytesObject = YES;
	aClass.totalInstanceSizeInWords = 0;
	stringClass = aClass;
	classes[@"String"] = stringClass;
	}
//
// Init the Symbol class that we will use for storing
// canonical strings that are used by the VM
//
- (void) initSymbolClass
	{
	ARClass* aClass;
	ARArray* iVarNames;
	
	aClass = [ARClass objectWithObject: [self newRootObjectWithSize: CLASS_SIZE_IN_WORDS]];
	aClass.className = [self stringWithNSString: @"Symbol"];
	iVarNames = [self newArrayWithMaximum: 1];
	[iVarNames setObjectElement: [self stringWithNSString: @"stringValue"] atIndex: 0];
	iVarNames.count = 1;
	aClass.instanceVariableNames = iVarNames;
	aClass.indexedObject = YES;
	aClass.bytesObject = YES;
	aClass.instanceSizeInWords = 0;
	aClass.indexedObject = YES;
	aClass.bytesObject = YES;
	aClass.classSuperclass = stringClass;
	aClass.totalInstanceSizeInWords = 0;
	symbolClass = aClass;
	classes[@"Symbol"] = symbolClass;
	}
//
// Allocate a new object with the specified size. The size is 
// the number of words EXCLUDING the object header
//
- (ARObject*) newObjectWithSize: (NSUInteger) size
	{
	WORD*	pointer;
	ARObject* object;
	
	pointer = GC_MALLOC((size+OBJECT_HEADER_SIZE)*sizeof(WORD));
	object = [ARObject objectAtPointer: pointer];
	object.objectSizeInWords = size;
	object.objectHeader = HEADER_MASK_OBJECT;
	return(object);
	}
//
// Allocate a new root object with the specified size. The size is 
// the number of words EXCLUDING the object header
//
- (ARObject*) newRootObjectWithSize: (NSUInteger) size
	{
	WORD*	pointer;
	ARObject* object;
	
	pointer = GC_MALLOC_UNCOLLECTABLE((size+OBJECT_HEADER_SIZE)*sizeof(WORD));
	object = [ARObject objectAtPointer: pointer];
	object.objectSizeInWords = size;
	object.objectHeader = HEADER_MASK_OBJECT;
	return(object);
	}
//
// Create a new string object from an NSString
//
- (ARString*) stringWithNSString: (NSString*) string
	{
	WORD sizeInWords;
	WORD count;
	WORD totalSize;
	ARString* newString;
	
	count = string.length;
	sizeInWords = count / 4 + 1;
	totalSize = 1 + sizeInWords;
	newString = [ARString objectAtPointer: [self newObjectWithSize: totalSize].objectPointer];
	newString.NSString = string;
	newString.objectClass = stringClass;
	return(newString);
	}
//
// Create a new instruction vector with the given size and maximum
//
- (ARByteCodeArray*) newByteCodeArrayWithMaximum: (WORD) maximum
	{
	ARByteCodeArray* vector;
	WORD totalSize;
	
	totalSize = 1 + 1 + maximum;
	vector = [ARByteCodeArray objectAtPointer: [self newObjectWithSize: totalSize].objectPointer];
	vector.count = 0;
	vector.maximum = maximum;
	vector.objectClass = instructionArrayClass;
	return(vector);
	}
//
// Create a new array object
//
- (ARArray*) newArrayWithMaximum: (WORD) maximum
	{
	ARArray* array;
	WORD totalSize;
	
	totalSize = 1 + 1 + maximum;
	array = [ARArray objectAtPointer: [self newObjectWithSize: totalSize].objectPointer];
	array.count = 0;
	array.maximum = maximum;
	array.objectClass = arrayClass;
	return(array);
	}
//
// Create a new symbol object from the given string. Check the symbol table
// to see whether the symbol already exists, if it does return the existing symbol
// not a new one.
//
- (ARSymbol*) symbolWithNSString: (NSString*) string
	{
	ARSymbol* symbol;
	ARObject* object;
	ARString* dummy;
	
	object = [symbolTable valueForNSStringKey: string];
	if (!object.isNil)
		{
		symbol = [ARSymbol objectWithObject: object];
		return(symbol);
		}
	dummy = [self stringWithNSString: string];
	symbol = [ARSymbol objectWithObject: dummy];
	symbol.objectClass = symbolClass;
	[symbolTable setValue: symbol forNSStringKey: string];
	return(symbol);
	}
//
// Create a new association
//
- (ARAssociation*) newAssociation
	{
	ARAssociation* association;
	WORD totalSize;
	
	totalSize = 2;
	association = [ARAssociation objectAtPointer: [self newObjectWithSize: totalSize].objectPointer];
	association.objectClass = associationClass;
	return(association);
	}
//
// Create a new LinkedListNode
//
- (ARLinkedList*) newLinkedList
	{
	ARLinkedList* association;
	WORD totalSize;
	
	totalSize = 2;
	association = [ARLinkedList objectAtPointer: [self newObjectWithSize: totalSize].objectPointer];
	association.objectClass = linkedListClass;
	return(association);
	}
//
// Create a dictionary with the specified maximum size
//
//
// Create a new LinkedListNode
//
- (ARDictionary*) newDictionaryWithMaximum: (WORD) maximum
	{
	ARDictionary* dict;
	WORD totalSize;
	
	totalSize = maximum + 1 + 1;
	dict = [ARDictionary objectAtPointer: [self newObjectWithSize: totalSize].objectPointer];
	dict.count = 0;
	dict.maximum = maximum;
	dict.objectClass = dictionaryClass;
	return(dict);
	}
//
// Create a new CompiledMethod
//
- (ARCompiledMethod*) newCompiledMethod
	{
	ARCompiledMethod* method;
	WORD totalSize;
	
	totalSize = 7;
	method = [ARCompiledMethod objectAtPointer: [self newObjectWithSize: totalSize].objectPointer];
	method.literalFrame = [self newArrayWithMaximum: 256];
	method.temporaryFrame = [self newArrayWithMaximum: 128];
	method.byteCode = [self newByteCodeArrayWithMaximum: 128];
	method.previousActivation = [self nilObject];
	method.stackPointerOnEntry = 0;
	method.exceptionHandlers = [self newArrayWithMaximum: 32];
	method.method = [self nilObject];
	method.objectClass = compiledMethodClass;
	return(method);
	}
//
// Create a new Method
//
- (ARMethod*) newMethod
	{
	ARMethod* method;
	WORD totalSize;
	
	totalSize = 4;
	method = [ARMethod objectAtPointer: [self newObjectWithSize: totalSize].objectPointer];
	method.objectClass = methodClass;
	return(method);
	}
@end
