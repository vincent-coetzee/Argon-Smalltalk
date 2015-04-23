//
//  ARBrowsedClass.m
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/03.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import "ARBrowsedClass.h"

@implementation ARBrowsedClass
	{
	__strong ARClass* _class;
	__strong NSArray* _subclasses;
	__strong NSMutableArray* _browsedClasses;
	}
	
- (void) setBrowsedClass: (ARClass*) aClass
	{
	_class = aClass;
	_browsedClasses = [NSMutableArray array];
	}
	
- (NSString*) name
	{
	return(_class.NSStringClassName);
	}
	
- (NSUInteger) childCount
	{
	if (_subclasses == nil)
		{
		_subclasses = [_class allSubclasses];
		}
	return(_subclasses.count);
	}
	
- (ARBrowsedItem*) childAtIndex: (NSUInteger) index
	{
	ARBrowsedClass* child;
	
	if (_subclasses == nil)
		{
		_subclasses = [_class allSubclasses];
		}
	child = [ARBrowsedClass new];
	[child setBrowsedClass: _subclasses[index]];
	[_browsedClasses addObject: child];
	return(child);
	}
	
- (ARClass*) browsedClass
	{
	return(_class);
	}
	
@end
