//
//  ARStylePalette.h
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/04.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface ARStylePalette : NSObject

+ (instancetype) sharedPalette;
- (NSFont*) defaultFont;
- (NSColor*) defaultBackgroundColor;

@end
