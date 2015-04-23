//
//  ARStylePalette.m
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/04.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import "ARStylePalette.h"

static ARStylePalette* SharedPalette;

@implementation ARStylePalette
	{
	__strong NSFont* defaultFont;
	__strong NSColor* defaultBackgroundColor;
	}
	
+ (instancetype) sharedPalette
	{
	if (SharedPalette == nil)
		{
		SharedPalette = [self new];
		}
	return(SharedPalette);
	}
	
- (id) init
	{
	self = [super init];
	if (self)
		{
		defaultFont = [NSFont fontWithName: @"SunSansSemiBold" size: 12];
		defaultBackgroundColor = [NSColor colorWithRed: 230/255.0f green: 230/255.0f blue: 240/255.0f alpha: 1.0];
		}
	return(self);
	}
	
- (NSFont*) defaultFont
	{
	return(defaultFont);
	}

- (NSColor*) defaultBackgroundColor
	{
	return(defaultBackgroundColor);
	}
	
@end
