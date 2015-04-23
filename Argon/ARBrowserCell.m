//
//  BrowserCell.m
//  Production
//
//  Created by Vincent Coetzee on 2014/09/24.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import "ARBrowserCell.h"

@implementation ARBrowserCell

- (NSSize)cellSizeForBounds:(NSRect)aRect
	{
	aRect.size.height = 36;
	return(aRect.size);
	}
	
- (NSRect)drawingRectForBounds:(NSRect)theRect
	{
	if (theRect.size.height < 36)
		{
		theRect.size.height = 36;
		}
	return(theRect);
	}
	
@end
