//
//  ARBrowsedItem.h
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/03.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARBrowsedItem : NSObject

- (NSString*) name;
- (NSUInteger) childCount;
- (ARBrowsedItem*) childAtIndex: (NSUInteger) index;

@end
