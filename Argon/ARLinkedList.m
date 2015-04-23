//
//  ARLinkedList.m
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/03.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import "ARLinkedList.h"

#define OFFSET_NEXT_NODE	(3)
#define OFFSET_VALUE		(4)

@implementation ARLinkedList

- (ARLinkedList*) nextNode
	{
	return([ARLinkedList objectAtPointer: (WORD*)[self wordAtOffset: OFFSET_NEXT_NODE]]);
	}
	
- (void) setNextNode: (ARLinkedList*) list
	{
	[self setWord: (WORD)list.objectPointer atOffset: OFFSET_NEXT_NODE];
	}
	
- (ARObject*) value
	{
	return([ARObject objectAtPointer: (WORD*)[self wordAtOffset: OFFSET_VALUE]]);
	}
	
- (void) setValue: (ARObject*) object
	{
	[self setWord: (WORD)object.objectPointer atOffset: OFFSET_VALUE];
	}

@end
