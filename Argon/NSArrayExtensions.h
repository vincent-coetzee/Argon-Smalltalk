//
//  NSArrayExtensions.h
//  Frames
//
//  Created by Vincent Coetzee on 2009/04/03.
//  Copyright macsemantics.com 2009-2013. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray ( NSArrayExtensions )

- (NSArray*) excludingString: (NSString*) string;
- (NSArray*) excludingStringsFromArray: (NSArray*) array;
- (NSString*) printString;

@end
