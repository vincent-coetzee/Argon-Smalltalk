//
//  NSColor+Extensions.h
//  CleanTime
//
//  Created by Vincent Coetzee on 2013/04/19.
//  Copyright (c) 2013 Vincent Coetzee. All rights reserved.
//

#import <AppKit/AppKit.h>
#import <Cocoa/Cocoa.h>

@interface NSColor (Extensions)

/*
**
** Some convenience color related routines
**
*/
+ (instancetype) colorWithUnscaledRed: (CGFloat) red green: (CGFloat) green blue: (CGFloat) blue alpha: (CGFloat) alpha;
+ (instancetype) colorWithUnscaledWhite: (CGFloat) white alpha: (CGFloat) alpha;
- (instancetype) colorWithAlpha: (CGFloat) alpha;
+ (instancetype) colorWithUnscaledWhite: (CGFloat) color;
/*
**
** Add Apple's Crayon palette to NSColor
**
*/
+ (NSColor*) maraschinoColor;
+ (NSColor*) cantaloupeColor;
+ (NSColor*) honeydewColor;
+ (NSColor*) fernColor;
+ (NSColor*) asparagusColor;
+ (NSColor*) mercuryColor;
+ (NSColor*) steelColor;
+ (NSColor*) ironColor;
+ (NSColor*) nickelColor;
+ (NSColor*) cloverColor;
+ (NSColor*) strawberryColor;
+ (NSColor*) seafoamColor;
+ (NSColor*) plumColor;
+ (NSColor*) nextCrayonColor;
+ (NSArray*) crayonColorNames;
+ (NSArray*) crayonColors;
+ (NSColor*) limeColor;
/*
**
** Return color components
**
*/
- (CGFloat) redComponent;
- (CGFloat) greenComponent;
- (CGFloat) blueComponent;
- (CGFloat) alphaComponent;
- (void) componentsInRed: (CGFloat*) redp green: (CGFloat*) greenp blue: (CGFloat*) bluep alpha: (CGFloat*) alphap;
/*
**
** Mix colors
**
*/
- (NSColor*) alphaMixed: (CGFloat) proportion withColor: (NSColor*) color;
- (NSColor*) lighter;
- (NSColor*) paler;
- (NSColor*) muchDarker;
- (NSColor*) muchLighter;
- (NSColor*) darker;
- (NSColor*) blacker;
- (NSColor*) whiter;
- (NSColor*) slightlyDarker;
- (NSColor*) slightlyLighter;
- (NSColor*) slightlyWhiter;
/*
**
** HSB / HSV support
**
*/
- (void) hue: (CGFloat*) h saturation: (CGFloat*) s brightness: (CGFloat*) b;
- (NSColor*) adjustSaturation: (float) saturation brightness: (float) brightness;
- (NSColor*) adjustBrightness: (float) brightness;
/*
**
** Shadows
**
*/
- (NSColor*) shadowWithLevel: (CGFloat) level;
- (NSColor*) highlightWithLevel: (CGFloat) level;
- (id) copy;

@end
