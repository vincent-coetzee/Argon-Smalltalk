//
//  ARVector.m
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/03.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import "ARArray.h"
#import "ARString.h"

#define OFFSET_COUNT		(3)
#define OFFSET_MAXIMUM		(4)
#define OFFSET_ELEMENTS		(5)

@implementation ARArray

- (NSString*) instanceVarNSString
	{
	NSMutableString* string;
	
	string = [NSMutableString string];
	if (self.count > 0)
		{
		[string appendString: [NSString stringWithFormat: @"'%@'",[ARString objectAtPointer: (WORD*)[self elementAtIndex: 0]].NSString]];
		}
	for (int index=1;index<self.count;index++)
		{
		[string appendString: [NSString stringWithFormat: @",'%@'",[ARString objectAtPointer: (WORD*)[self elementAtIndex: index]].NSString]];
		}
	return(string);
	}
	
- (WORD) addObjectElement: (ARObject*) object
	{
	WORD index;
	
	index = self.count;
	[self setObjectElement: object atIndex: index];
	self.count = index + 1;
	return(index);
	}
	
- (WORD) addElement: (WORD) element
	{
	WORD index;
	
	index = self.count;
	[self setElement: element atIndex: index];
	self.count = index + 1;
	return(index);
	}
	
- (WORD) elementAtIndex: (WORD) index
	{
	WORD count;
	
	count = [self wordAtOffset: OFFSET_COUNT];
	if (index >= count)
		{
		return(0);
		}
	return([self wordAtOffset: OFFSET_ELEMENTS + index]);
	}
	
- (void) setObjectElement: (ARObject*) object atIndex: (WORD) index
	{
	if (index >= self.maximum)
		{
		[self grow];
		}
	[self setElement: (WORD)object.objectPointer atIndex: index];
	}
	
- (void) grow
	{
	}
	
- (void) setElement: (WORD) element atIndex: (WORD) index
	{
	[self setWord: element atOffset: OFFSET_ELEMENTS + index];
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
