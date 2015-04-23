//
//  ARLinkedList.h
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/03.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import "ARObject.h"

@interface ARLinkedList : ARObject

@property(readwrite,assign) ARLinkedList* nextNode;
@property(readwrite,assign) ARObject* value;

@end
