//
//  ARVector.h
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/03.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import "ARObject.h"

@interface ARArray : ARObject

@property(readwrite,assign) WORD count;
@property(readwrite,assign) WORD maximum;

- (WORD) elementAtIndex: (WORD) index;
- (void) setElement: (WORD) element atIndex: (WORD) index;
- (void) setObjectElement: (ARObject*) object atIndex: (WORD) index;
- (NSString*) instanceVarNSString;
- (WORD) addObjectElement: (ARObject*) object;
- (WORD) addElement: (WORD) aWord;

@end
