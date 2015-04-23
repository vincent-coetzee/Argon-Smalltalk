//
//  NSString+BBDExtensions.h
//  DiscoveryInsure
//
//  Created by Vincent Coetzee on 2012/02/15.
//  Copyright (c) 2012 BBD (Pty) Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString(VACExtensions)

- (NSArray*) diceStringIntoSegmentsOfLength: (NSUInteger) length;
- (BOOL) isString;
- (NSString*) stringByRemovingFirstKeyPathComponent;
- (NSString*) firstKeyPathComponent;
- (NSString*) setMethodNameString;
- (NSString*) firstLetterCapitalizedString;
- (NSString*) firstLetterLowercaseString;
- (NSString*) upToCharacter: (char) aChar;
- (NSString*) MD5HashString;

@end
