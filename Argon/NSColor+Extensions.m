//
//  NSColor+Extensions.m
//  CleanTime
//
//  Created by Vincent Coetzee on 2013/04/19.
//  Copyright (c) 2013 Vincent Coetzee. All rights reserved.
//

#import "NSColor+Extensions.h"
#import <QuartzCore/QuartzCore.h>

static __strong NSArray* CrayonColorNames;
static __strong NSMutableArray* CrayonColors;

#define AssignIfNotNull(p,v) ( p != nil ? *p = v : 0 )

@implementation NSColor(Extensions)

/*
**
** This returns an autoreleased colour with the specified unscaled values.
** Scale the values and then use the normal convenience method to create the
** autoreleased colour.
**
*/
+ (instancetype) colorWithUnscaledRed: (CGFloat) red green: (CGFloat) green blue: (CGFloat) blue alpha: (CGFloat) alpha
    {
    return([NSColor colorWithCalibratedRed: red/255.0f green: green/255.0f blue: blue/255.0f alpha: alpha]);
    }

- (instancetype) colorWithAlpha: (CGFloat) alpha
    {
    CGFloat r,g,b,a;

    [self componentsInRed: &r green: &g blue: &b alpha: &a];
    return([[self class] colorWithCalibratedRed: r green: g blue: b alpha: alpha]);
    }
/*
**
** Define some extra color constants
**
*/
+ (NSArray*) crayonColorNames
    {
    static dispatch_once_t onlyOnceToken;

    dispatch_once(&onlyOnceToken,
    ^{
        CrayonColorNames = @[@"strawberry",@"seafoam",@"plum",@"iron",@"nickel",@"maraschino",@"cantaloupe",@"honeydew",@"mercury",@"steel",@"fern",@"asparagus",@"clover",@"lime"];
        });
    return(CrayonColorNames);
    }

+ (NSColor*) strawberryColor
    {
    return([self colorWithUnscaledRed: 255.0f green: 0.0f blue:128.0f alpha: 1.0f]);
    }

+ (NSColor*) limeColor
	{
	return([self colorWithUnscaledRed: 128.0f green: 255.0f blue: 0.0f alpha: 1.0f]);
	}

+ (NSColor*) seafoamColor
    {
    return([self colorWithUnscaledRed: 0.0f green: 255.0f blue:128.0f alpha: 1.0f]);
    }

+ (NSColor*) plumColor
    {
    return([self colorWithUnscaledRed: 128.0f green: 0.0f blue:128.0f alpha: 1.0f]);
    }

+ (NSColor*) ironColor
    {
    return([self colorWithUnscaledRed: 76.0f green: 76.0f blue: 76.0f alpha: 1.0f]);
    }

+ (NSColor*) nickelColor
    {
    return([self colorWithUnscaledRed: 128.0f green: 128.0f blue: 128.0f alpha: 1.0f]);
    }

+ (NSColor*) maraschinoColor
    {
    return([self colorWithUnscaledRed: 255.0f green: 0.0f blue:0.0f alpha: 1.0f]);
    }

+ (NSColor*) cantaloupeColor
    {
    return([self colorWithUnscaledRed: 255.0f green: 204.0f blue: 102.0f alpha: 1.0f]);
    }

+ (NSColor*) honeydewColor
    {
    return([self colorWithUnscaledRed: 204.0f green: 255.0f blue: 102.0f alpha: 1.0f]);
    }

+ (NSColor*) mercuryColor
    {
    return([self colorWithUnscaledRed: 230.0f green: 230.0f blue: 230.0f alpha: 1.0f]);
    }

+ (NSColor*) steelColor
    {
    return([self colorWithUnscaledRed: 102.0f green: 102.0f blue: 102.0f alpha: 1.0f]);
    }

+ (NSColor*) fernColor
    {
    return([self colorWithUnscaledRed: 64.0f green: 128.0f blue: 0.0f alpha: 1.0f]);
    }

+ (NSColor*) asparagusColor
    {
    return([self colorWithUnscaledRed: 172.0f green: 144.0f blue: 15.0f alpha: 1.0f]);
    }

+ (NSColor*) cloverColor
    {
    return([self colorWithUnscaledRed: 0.0f green: 128.0f blue: 0.0f alpha: 1.0f]);
    }

+ (NSArray*) crayonColors
    {
    static dispatch_once_t onlyOnceToken;

    dispatch_once(&onlyOnceToken,
    ^{
        CrayonColors = [NSMutableArray array];
        for (NSString* name in [self crayonColorNames])
            {
            [CrayonColors addObject: [self performSelector: NSSelectorFromString([NSString stringWithFormat: @"%@Color",name])]];
            }
        });
    return(CrayonColors);
    }

+ (NSColor*) nextCrayonColor
    {
    NSArray* colors;
    static NSUInteger nextColorIndex = 0;
    colors = [self crayonColors];
    if (nextColorIndex >= [colors count])
        {
        nextColorIndex = 0;
        }
    return([colors objectAtIndex: nextColorIndex]);
    }
/*
**
** Color creation
**
*/
+ (instancetype) colorWithUnscaledWhite: (CGFloat) white alpha: (CGFloat) alpha
    {
    return([self colorWithCalibratedWhite: white/255.0f alpha: alpha]);
    }
	
+ (instancetype) colorWithUnscaledWhite: (CGFloat) color
	{
	return([self colorWithUnscaledWhite: color alpha: 1.0f]);
	}

- (id) copy
    {
    CGFloat red,green,blue,alpha;

    [self componentsInRed: &red green: &green blue: &blue alpha: &alpha];
    return([[self class] colorWithCalibratedRed: red green: green blue: blue alpha: alpha]);
    }

- (CGFloat) redComponent
    {
    CGFloat     r;

    [self componentsInRed: &r green: NULL blue: NULL alpha: NULL];
    return(r);
    }

- (CGFloat) blueComponent
    {
    CGFloat     b;

    [self componentsInRed: NULL green: NULL blue: &b alpha: NULL];
    return(b);
    }

- (CGFloat) greenComponent
    {
    CGFloat     g;

    [self componentsInRed: NULL green: &g blue: NULL alpha: NULL];
    return(g);
    }

- (CGFloat) alphaComponent
    {
    CGFloat     a;

    [self componentsInRed: NULL green: NULL blue: NULL alpha: &a];
    return(a);
    }

- (NSColor*) shadowWithLevel: (CGFloat) level
    {
    return([self alphaMixed: level withColor: [NSColor blackColor]]);
    }

- (NSColor*) highlightWithLevel: (CGFloat) level
    {
    return([self alphaMixed: level withColor: [NSColor whiteColor]]);
    }

- (void) componentsInRed: (CGFloat*) redp green: (CGFloat*) greenp blue: (CGFloat*) bluep alpha: (CGFloat*) alphap
    {
    const   CGFloat*    pointer;
    CGColorRef  ref;

    ref = self.CGColor;
    if (CGColorGetNumberOfComponents(ref) != 4)
        {
        AssignIfNotNull(redp,0);
        AssignIfNotNull(greenp,0);
        AssignIfNotNull(bluep,0);
        AssignIfNotNull(alphap,0);
        return;
        }
    pointer = CGColorGetComponents(ref);
    AssignIfNotNull(redp,*pointer++);
    AssignIfNotNull(greenp,*pointer++);
    AssignIfNotNull(bluep,*pointer++);
    AssignIfNotNull(alphap,*pointer++);
    }

- (NSColor*) alphaMixed: (CGFloat) proportion withColor: (NSColor*) color
    {
    CGFloat frac1,frac2;
    CGFloat  r,b,g,a;
    CGFloat r1,g1,b1,a1;

    [self componentsInRed: &r green: &g blue: &b alpha: &a];
    [color componentsInRed: &r1 green: &g1 blue: &b1 alpha: &a1];
    frac1 = MAX(0.0f,MIN(proportion,1.0f));
    frac2 = 1.0f - frac1;
    r =  r*frac1 + r1*frac2;
    g =  g*frac1 + g1*frac2;
    b =  b*frac1 + b1*frac2;
    a =  a*frac1 + a1*frac2;
    return([NSColor colorWithRed: r green: g blue: b alpha: a]);
    }

- (NSColor*) lighter
    {
    return([self adjustSaturation: -0.03f brightness: 0.08f]);
    }

- (void) hue: (CGFloat*) hue saturation: (CGFloat*) sat brightness: (CGFloat*) val
    {
    CGFloat r,g,b,a;
    CGFloat rgb_min, rgb_max;

    [self componentsInRed: &r green: &g blue: &b alpha: &a];
    rgb_min = MIN(MIN(r,g),b);
    rgb_max = MAX(MAX(r,g),b);

    if (rgb_max == rgb_min)
        {
        *hue = 0.0f;
        }
    else if (rgb_max == r)
        {
        *hue = 60.0f * ((g - b) / (rgb_max - rgb_min));
        *hue = fmodf(*hue, 360.0f);
        }
    else if (rgb_max == g)
        {
        *hue = 60.0f * ((b - r) / (rgb_max - rgb_min)) + 120.0f;
        }
    else if (rgb_max == b)
        {
        *hue = 60.0f * ((r - g) / (rgb_max - rgb_min)) + 240.0f;
        }
    *val = rgb_max;
    if (rgb_max == 0)
        {
        *sat = 0;
        }
    else
        {
        *sat = 1.0 - (rgb_min / rgb_max);
        }
    *hue /= 360.0f;
    }

- (NSColor*) paler
    {
    return([self adjustSaturation: -0.09f brightness: 0.09f]);
    }

- (NSColor*) muchDarker
    {
    return([self alphaMixed: 0.5f withColor: [NSColor blackColor]]);
    }

- (NSColor*) muchLighter
    {
    return([self alphaMixed: 0.233f withColor: [NSColor whiteColor]]);
    }

- (NSColor*) adjustSaturation: (float) saturation brightness: (float) brightness
    {
    CGFloat a;
    CGFloat h,s,b;

    [self componentsInRed: NULL green: NULL blue: NULL alpha: &a];
    [self hue: &h saturation: &s brightness: &b];
    return([NSColor colorWithCalibratedHue: h saturation: s+MAX(0.005f,MIN(saturation,1.0f)) brightness: b+MAX(0.005f,MIN(brightness,1.0f)) alpha: a]);
    }

- (NSColor*) adjustBrightness: (float) brightness
    {
    CGFloat a;
    CGFloat h,s,b;

    [self componentsInRed: NULL green: NULL blue: NULL alpha: &a];
    [self hue: &h saturation: &s brightness: &b];
    return([NSColor colorWithCalibratedHue: h saturation: s brightness: b + MAX(0.005f,MIN(brightness,1.0f)) alpha: a]);
    }

- (NSColor*) darker
    {
    return([self adjustBrightness: -0.08f]);
    }
//!
//! Return a new autoreleased color that has come black mixed into it to make it darker.
//!
- (NSColor*) blacker
    {
    return([self alphaMixed: 0.8333f withColor: [NSColor blackColor]]);
    }
//!
//! Return a new autoreleased color that has come white mixed into it to make it lighter.
//!
- (NSColor*) whiter
    {
    return([self alphaMixed: 0.8333f withColor: [NSColor whiteColor]]);
    }

- (NSColor*) slightlyDarker
    {
    return([self adjustBrightness: -0.03f]);
    }

- (NSColor*) slightlyLighter
    {
    return([self adjustSaturation: -0.01f brightness: 0.03f]);
    }

- (NSColor*) slightlyWhiter
    {
    return([self alphaMixed: 0.85f withColor: [NSColor whiteColor]]);
    }

@end
