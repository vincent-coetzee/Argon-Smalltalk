//
//  ARVM.h
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/03.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARObject.h"
#import "ARString.h"
#import "ARByteCodeArray.h"
#import "ARCompiledMethod.h"

@class ARAssociation;
@class ARLinkedList;
@class ARDictionary;

@interface ARVM : NSObject

+ (void) initVM;
+ (instancetype) activeVM;
- (ARObject*) newObjectWithSize: (NSUInteger) size;
- (ARString*) stringWithNSString: (NSString*) string;
- (NSArray*) allRootClasses;
- (NSArray*) allSubclassesOfClassWithName: (NSString*) name;
- (ARByteCodeArray*) newByteCodeArrayWithMaximum: (WORD) maximum;
- (WORD) popWord;
- (void) executeInstructionVector: (ARByteCodeArray*) vector;
- (ARAssociation*) newAssociation;
- (ARLinkedList*) newLinkedList;
- (ARObject*) nilObject;
- (ARDictionary*) newDictionaryWithMaximum: (WORD) maximum;
- (ARCompiledMethod*) newCompiledMethod;
- (ARMethod*) newMethod;
- (ARSymbol*) symbolWithNSString: (NSString*) string;

@end
