//
//  ARASTSmalltalkToken.h
//  Talk
//
//  Created by Vincent Coetzee on 2014/11/22.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import <Foundation/Foundation.h>

#define T_HASH		1
#define	T_DOLLAR	2
#define T_LPAR		3
#define T_RPAR		4
#define T_LBRA		5
#define T_RBRA		6
#define T_PLUS		7
#define T_MINUS		8
#define T_SLASH		9
#define T_BACK		10
#define T_TILDE		11
#define	T_LESS		12
#define T_MORE		13
#define	T_EQUAL		14
#define T_AT		15
#define	T_PERCENT	16
#define T_BAR		17
#define T_AND		18
#define	T_CARET		19
#define T_QUESTION	20
#define T_BANG		21
#define T_IDENTIFIER	22
#define T_STRING		23
#define T_CHARACTER		24
#define T_INTEGER		25
#define	T_EOF			26
#define T_MUL			27
#define T_COLON			28
#define T_KEYWORD		29
#define T_ASSIGN		30
#define T_DOUBLE		31
#define T_PERIOD		32

@interface ARSimpleToken : NSObject

@property(readwrite,strong) NSString* stringValue;
@property(readwrite,assign) long longValue;
@property(readwrite,assign) int type;
@property(readwrite,assign) unsigned long characterOffset;

+ (ARSimpleToken*) symbolToken: (int) symbolValue;
+ (ARSimpleToken*) stringToken: (NSString*) string;
+ (ARSimpleToken*) keywordToken: (NSString*) string;
+ (ARSimpleToken*) identifierToken: (NSString*) string;
+ (ARSimpleToken*) integerToken: (long) number;
+ (ARSimpleToken*) eofToken;

- (void) println;
- (NSString*) tokenSelectorString;

- (BOOL) isSpecialCharacter;
- (BOOL) isSymbol;
- (BOOL) isIdentifier;
- (BOOL) isColon;
- (BOOL) isKeyword;
- (BOOL) isBar;
- (BOOL) isEOF;
- (BOOL) isBang;
- (BOOL) isAssign;
- (BOOL) isLeftPar;
- (BOOL) isRightPar;
- (BOOL) isCaret;
- (BOOL) isInteger;
- (BOOL) isPeriod;

@end
