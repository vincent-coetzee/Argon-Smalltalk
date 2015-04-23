//
//  NSArrayExtensions.m
//  Frames
//
//  Created by Vincent Coetzee on 2009/04/03.
//  Copyright macsemantics.com 2009-2013. All rights reserved.
//

#import "NSArrayExtensions.h"

@implementation NSArray ( NSArrayExtensions )

- (NSArray*) excludingString: (NSString*) outString
	{
	NSMutableArray*		newArray;
	NSString*			string;
	int					index;
	
	newArray = [NSMutableArray array];
	for (index=0;index<[self count];index++)
		{
		string = [self objectAtIndex: index];
		if (![string isEqualToString: outString])
			[newArray addObject: string];
		}
	return(newArray);
	}
	
- (NSArray*) excludingStringsFromArray: (NSArray*) array
	{
	return([NSArray array]);
	}

- (NSString*) printString
	{
	NSString*	string;
	int			index;
	
	string = @"( ";
	for (index=0;index<[self count];index++)
		{
		string = [string stringByAppendingFormat: @"%@ ",[[self objectAtIndex: index] printString]];
		}
	return([string stringByAppendingString: @")"]);
	}
	
@end
