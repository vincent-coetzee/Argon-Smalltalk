//
//  BBDTimer.m
//  MTMv2
//
//  Created by Vincent Coetzee on 2011/09/09.
//  Copyright (c) 2011 BB&D. All rights reserved.
//

#import "VACTimer.h"
#import <sys/time.h>

@implementation VACTimer
    {
    unsigned long long startValue;
    unsigned long long stopValue;
    }

+ (id) start
    {
    return([[self alloc] init]);
    }

- (id) init
    {
    struct timeval value;

    self = [super init];
    if (self)
        {
        gettimeofday(&value,NULL);
        startValue = 1000000LL*value.tv_sec + value.tv_usec;
        }
    return(self);
    }

- (unsigned long long) stop
    {
    struct timeval value;


    gettimeofday(&value,NULL);
    stopValue = 1000000LL*value.tv_sec + value.tv_usec;
    return(stopValue - startValue);
    }

- (unsigned long long) elapsedMilliseconds
    {
    return((stopValue - startValue)/1000LL);
    }

@end
