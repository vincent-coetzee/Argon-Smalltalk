//
//  ARDictionary.m
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/03.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import "ARDictionary.h"
#import "ARString.h"
#import "ARAssociation.h"
#import "ARVM.h"
#import "ARLinkedList.h"

#define OFFSET_COUNT	(3)
#define OFFSET_MAXIMUM	(4)
#define OFFSET_BUCKETS	(5)

@implementation ARDictionary

- (void) setValue: (ARObject*) object forNSStringKey: (NSString*) key
	{
	[self setValue: object forKey: [[ARVM activeVM] stringWithNSString: key]];
	}
	
- (ARObject*) valueForNSStringKey: (NSString*) key
	{
	return([self valueForKey: [[ARVM activeVM] stringWithNSString: key]]);
	}

- (NSArray*) allKeys
	{
	NSMutableArray* array;
	ARObject* bucket;
	ARAssociation* association;
	ARLinkedList* node;
	
	array = [NSMutableArray array];
	for (int index=0;index<self.maximum;index++)
		{
		bucket = [self bucketAtOffset: index];
		if (!bucket.isNil)
			{
			if (bucket.isAssociation)
				{
				association = [ARAssociation objectAtPointer: bucket.objectPointer];
				[array addObject: association.key];
				}
			else if (bucket.isLinkedList)
				{
				node = [ARLinkedList objectAtPointer: bucket.objectPointer];
				while (!node.isNil)
					{
					association = [ARAssociation objectAtPointer: node.value.objectPointer];
					[array addObject: association.key];
					node = node.nextNode;
					}
				}
			}
		}
	return(array);
	}
	
- (NSArray*) allValues
	{
	NSMutableArray* array;
	ARObject* bucket;
	ARAssociation* association;
	ARLinkedList* node;
	
	array = [NSMutableArray array];
	for (int index=0;index<self.maximum;index++)
		{
		bucket = [self bucketAtOffset: index];
		if (!bucket.isNil)
			{
			if (bucket.isAssociation)
				{
				association = [ARAssociation objectAtPointer: bucket.objectPointer];
				[array addObject: association.value];
				}
			else if (bucket.isLinkedList)
				{
				node = [ARLinkedList objectAtPointer: bucket.objectPointer];
				while (!node.isNil)
					{
					association = [ARAssociation objectAtPointer: node.value.objectPointer];
					[array addObject: association.value];
					node = node.nextNode;
					}
				}
			}
		}
	return(array);
	}
	
- (ARObject*) valueForKey: (ARObject*) key
	{
	WORD hash;
	ARObject* bucket;
	WORD bucketHash;
	ARAssociation* association;
	ARLinkedList* node;
	WORD keyHash;
	
	hash = [self offsetFromKey: key];
	bucket = [self bucketAtOffset: hash];
	keyHash = [self hashFromKey: key];
	if (bucket.isNil)
		{
		return([[ARVM activeVM] nilObject]);
		}
	else if (bucket.isAssociation)
		{
		association = [ARAssociation objectAtPointer: bucket.objectPointer];
		bucketHash = [self hashFromKey: association.key];
		if (bucketHash == keyHash)
			{
			return(association.value);
			}
		return([[ARVM activeVM] nilObject]);
		}
	else if (bucket.isLinkedList)
		{
		node = [ARLinkedList objectAtPointer: bucket.objectPointer];
		while (!node.isNil)
			{
			association = [ARAssociation objectAtPointer: node.value.objectPointer];
			bucketHash = [self hashFromKey: association.key];
			if (bucketHash == keyHash)
				{
				return(association.value);
				}
			node = node.nextNode;
			}
		return([[ARVM activeVM] nilObject]);
		}
	else
		{
		NSLog(@"ERROR IN Dictionary->valueForKey, INVALID BUCKET TYPE");
		}
	return([[ARVM activeVM] nilObject]);
	}
	
- (WORD) offsetFromKey: (id) aKey
	{
	WORD hashcode;
	
	hashcode = [aKey hashcode];
	hashcode = hashcode % self.maximum;
	return(hashcode);
	}
	
- (WORD) hashFromKey: (ARObject*) key
	{
	return([key hashcode]);
	}
	
- (void) setValue: (ARObject*) object forKey: (ARObject*) key
	{
	WORD hash;
	ARObject* bucket;
	ARAssociation* association;
	ARAssociation* newAssociation;
	ARLinkedList* chain;
	ARLinkedList* oldList;
	
	hash = [self offsetFromKey: key];
	bucket = [self bucketAtOffset: hash];
	newAssociation = [[ARVM activeVM] newAssociation];
	newAssociation.key = key;
	newAssociation.value = object;
	if (bucket.isNil)
		{
		[self setBucket: newAssociation atOffset: hash];
		}
	else
		{
		chain = [[ARVM activeVM] newLinkedList];
		if (bucket.isLinkedList)
			{
			oldList = [ARLinkedList objectAtPointer: bucket.objectPointer];
			chain.value = newAssociation;
			chain.nextNode = oldList.nextNode;
			oldList.nextNode = chain;
			}
		else if (bucket.isAssociation)
			{
			oldList = [[ARVM activeVM] newLinkedList];
			association = [ARAssociation objectAtPointer: bucket.objectPointer];
			oldList.value = association;
			chain.nextNode = (ARLinkedList*)[[ARVM activeVM] nilObject];
			chain.value = newAssociation;
			oldList.nextNode = chain;
			[self setBucket: oldList atOffset: hash];
			}
		}
	self.count = self.count + 1;
	}
	
- (void) setBucket: (ARObject*) object atOffset: (WORD) offset
	{
	[self setWord: (WORD)object.objectPointer atOffset: OFFSET_BUCKETS + offset];
	}
	
- (ARObject*) bucketAtOffset: (WORD) offset
	{
	return([ARObject objectAtPointer: (WORD*)[self wordAtOffset: OFFSET_BUCKETS + offset]]);
	}
	
- (WORD) count
	{
	return([self wordAtOffset: OFFSET_COUNT]);
	}
	
- (void) setCount: (WORD) count
	{
	[self setWord: count atOffset: OFFSET_COUNT];
	}
	
- (WORD) maximum
	{
	return([self wordAtOffset: OFFSET_MAXIMUM]);
	}
	
- (void) setMaximum: (WORD) count
	{
	[self setWord: count atOffset: OFFSET_MAXIMUM];
	}
	
@end
