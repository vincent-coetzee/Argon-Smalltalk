//
//  ARBrowsedClass.h
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/03.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import "ARBrowsedItem.h"
#import "ARClass.h"

@interface ARBrowsedClass : ARBrowsedItem

- (void) setBrowsedClass: (ARClass*) aClass;
- (ARClass*) browsedClass;

@end
