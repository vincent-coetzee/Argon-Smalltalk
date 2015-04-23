//
//  ARAssociation.h
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/03.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import "ARObject.h"

@interface ARAssociation : ARObject

@property(readwrite,assign) ARObject* key;
@property(readwrite,assign) ARObject* value;

@end
