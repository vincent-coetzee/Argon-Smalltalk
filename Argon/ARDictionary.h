//
//  ARDictionary.h
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/03.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import "ARObject.h"

@interface ARDictionary : ARObject

@property(readwrite,assign) WORD count;
@property(readwrite,assign) WORD maximum;

- (ARObject*) valueForKey: (ARObject*) key;
- (void) setValue: (ARObject*) object forKey: (ARObject*) key;
- (void) setValue: (ARObject*) object forNSStringKey: (NSString*) key;
- (ARObject*) valueForNSStringKey: (NSString*) key;
- (NSArray*) allKeys;
- (NSArray*) allValues;

@end
