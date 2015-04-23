//
//  NSString+BBDExtensions.m
//  DiscoveryInsure
//
//  Created by Vincent Coetzee on 2012/02/15.
//  Copyright (c) 2012 BBD (Pty) Ltd. All rights reserved.
//

#import "NSString+VACExtensions.h"

@implementation NSString(VACExtensions)

- (NSArray*) diceStringIntoSegmentsOfLength: (NSUInteger) segmentLength
    {
    NSMutableArray* array;
    int index;
    int length;

    for (array=[NSMutableArray array],index=0,length=[self length]; index<length; index+=segmentLength)
        {
        [array addObject: [self substringWithRange: NSMakeRange(index,segmentLength)]];
        }
    return(array);
    }

- (NSString*) MD5HashString
    {
    const char* UTF8String;
    unsigned char buffer[CC_MD5_DIGEST_LENGTH];
    NSMutableString* stringHash;
    int index;

    UTF8String = [self UTF8String];
    CC_MD5(UTF8String,strlen(UTF8String),buffer);
    stringHash = [NSMutableString stringWithCapacity: CC_MD5_DIGEST_LENGTH*2];
    for (index=0; index<CC_MD5_DIGEST_LENGTH; index++)
        {
        [stringHash appendFormat:@"%02x",buffer[index]];
        }
    return(stringHash);
    }

- (BOOL) isString
    {
    return(YES);
    }

- (NSString*) upToCharacter: (char) aChar
    {
    char foundChar;
    int index;
    int stringLength;

    index = 0;
    stringLength = [self length];
    while ((foundChar = [self characterAtIndex: index]) != aChar && (index < stringLength))
        {
        index++;
        }
    return([self substringToIndex: index]);
    }

- (NSString*) firstKeyPathComponent
    {
    NSArray* keys;

    keys = [self componentsSeparatedByString: @"."];
    if ([keys count] > 0)
        {
        return([keys objectAtIndex: 0]);
        }
    return(@"");
    }

- (NSString*) stringByRemovingFirstKeyPathComponent
    {
    NSMutableArray* keys;

    keys = [[self componentsSeparatedByString: @"."] mutableCopy];
    if ([keys count] > 0)
        {
        [keys removeObjectAtIndex: 0];
        return([keys componentsJoinedByString: @"."]);
        }
    return(@"");
    }

- (NSString*) firstLetterCapitalizedString
    {
    NSMutableString* string;

    string = [NSMutableString stringWithString: self];
    [string replaceCharactersInRange: NSMakeRange(0,1) withString: [NSString stringWithFormat: @"%c",toupper([self characterAtIndex: 0])]];
    return(string);
    }

- (NSString*) firstLetterLowercaseString
    {
    NSMutableString* string;

    string = [NSMutableString stringWithString: self];
    [string replaceCharactersInRange: NSMakeRange(0,1) withString: [NSString stringWithFormat: @"%c",tolower([self characterAtIndex: 0])]];
    return(string);
    }

- (NSString*) setMethodNameString
    {
    return([NSString stringWithFormat: @"set%@:",[self firstLetterCapitalizedString]]);
    }



@end
