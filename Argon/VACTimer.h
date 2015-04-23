//
//  BBDTimer.h
//  MTMv2
//
//  Created by Vincent Coetzee on 2011/09/09.
//  Copyright (c) 2011 BB&D. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VACTimer : NSObject

+ (id) start;
- (unsigned long long) stop;
- (unsigned long long) elapsedMilliseconds;

@end
