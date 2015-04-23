//
//  ARAssociation.m
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/03.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import "ARAssociation.h"
#import "ARString.h"

#define OFFSET_KEY		(3)
#define OFFSET_VALUE	(4)

@implementation ARAssociation

- (ARObject*) key
	{
	ARObject* keyObject;
	
	keyObject = [ARObject objectAtPointer: (WORD*)[self wordAtOffset: OFFSET_KEY]];
	if (keyObject.isString)
		{
		return([ARString objectAtPointer: keyObject.objectPointer]);
		}
	else
		{
		return(keyObject);
		}
	}
	
- (void) setKey: (ARObject*) key
	{
	[self setWord: (WORD)key.objectPointer atOffset: OFFSET_KEY];
	}
	
- (ARObject*) value
	{
	return([ARObject objectAtPointer: (WORD*)[self wordAtOffset: OFFSET_VALUE]]);
	}
	
- (void) setValue: (ARObject*) value
	{
	[self setWord: (WORD)value.objectPointer atOffset: OFFSET_VALUE];
	}
	
@end
