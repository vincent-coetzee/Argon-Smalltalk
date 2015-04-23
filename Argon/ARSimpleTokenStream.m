//
//  ARASTSmalltalkTokenStream.m
//  Talk
//
//  Created by Vincent Coetzee on 2014/11/22.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import "ARSimpleTokenStream.h"

@implementation ARSimpleTokenStream
	{
	unsigned char currentChar;
	__strong NSMutableString* currentString;
	char* source;
	char* pSource;
	unsigned long currentOffset;
	}

+ (instancetype) onString: (NSString*) source
	{
	return([[self alloc] initWithString: source]);
	}
	
- (id) initWithString: (NSString*) string
	{
	self = [super init];
	if (self)
		{
		source = malloc([string length]+1);
		strcpy(source,[string UTF8String]);
		pSource = source;
		currentChar = *pSource++;
		}
	return(self);
	}
	
- (void) dealloc
	{
	free(source);
	}
	
- (void) nextCharacter
	{
	if (*pSource == 0)
		{
		currentChar = 254;
		return;
		}
	currentChar = *pSource++;
	currentOffset++;
	}
	
- (ARSimpleToken*) nextToken
	{
	ARSimpleToken* aToken;
	
	aToken = [self findNextToken];
	aToken.characterOffset = currentOffset;
	return(aToken);
	}
	
- (ARSimpleToken*) findNextToken
	{
	while (currentChar != 254 && isspace(currentChar))
		{
		[self nextCharacter];
		}
	if (currentChar == 254)
		{
		return([ARSimpleToken eofToken]);
		}
	switch(currentChar)
		{
	case(':'):
		[self nextCharacter];
		if (currentChar == '=')
			{
			[self nextCharacter];
			return([ARSimpleToken symbolToken: T_ASSIGN]);
			}
		return([ARSimpleToken symbolToken: T_COLON]);
	case('.'):
		[self nextCharacter];
		return([ARSimpleToken symbolToken: T_PERIOD]);
	case('+'):
		[self nextCharacter];
		return([ARSimpleToken symbolToken: T_PLUS]);
	case('/'):
		[self nextCharacter];
		return([ARSimpleToken symbolToken: T_SLASH]);
	case('-'):
		[self nextCharacter];
		return([ARSimpleToken symbolToken: T_MINUS]);
	case('\\'):
		[self nextCharacter];
		return([ARSimpleToken symbolToken: T_BACK]);
	case('~'):
		[self nextCharacter];
		return([ARSimpleToken symbolToken: T_TILDE]);
	case('<'):
		[self nextCharacter];
		return([ARSimpleToken symbolToken: T_LESS]);
	case('>'):
		[self nextCharacter];
		return([ARSimpleToken symbolToken: T_MORE]);
	case('='):
		[self nextCharacter];
		return([ARSimpleToken symbolToken: T_EQUAL]);
	case('@'):
		[self nextCharacter];
		return([ARSimpleToken symbolToken: T_AT]);
	case('%'):
		[self nextCharacter];
		return([ARSimpleToken symbolToken: T_PERCENT]);
	case('|'):
		[self nextCharacter];
		return([ARSimpleToken symbolToken: T_BAR]);
	case('&'):
		[self nextCharacter];
		return([ARSimpleToken symbolToken: T_AND]);
	case('^'):
		[self nextCharacter];
		return([ARSimpleToken symbolToken: T_CARET]);
	case('?'):
		[self nextCharacter];
		return([ARSimpleToken symbolToken: T_QUESTION]);
	case('!'):
		[self nextCharacter];
		return([ARSimpleToken symbolToken: T_BANG]);
	case('('):
		[self nextCharacter];
		return([ARSimpleToken symbolToken: T_LPAR]);
	case(')'):
		[self nextCharacter];
		return([ARSimpleToken symbolToken: T_RPAR]);
	case ('['):
		[self nextCharacter];
		return([ARSimpleToken symbolToken: T_LBRA]);
	case (']'):
		[self nextCharacter];
		return([ARSimpleToken symbolToken: T_RBRA]);
	case('#'):
		[self nextCharacter];
		return([ARSimpleToken symbolToken: T_HASH]);
	case('$'):
		[self nextCharacter];
		return([ARSimpleToken symbolToken: T_DOLLAR]);
	case('*'):
		[self nextCharacter];
		return([ARSimpleToken symbolToken: T_MUL]);
	case('\''):
		return([self nextString]);
	case('"'):
		[self scanComment];
		return([self nextToken]);
	default:
		break;
		}
	if (isdigit(currentChar))
		{
		return([self nextNumber]);
		}
	if (isalpha(currentChar))
		{
		return([self nextIdentifier]);
		}
	[NSException raise: @"PARSE_EXCEPTION" format: @"Unknown character %c",currentChar];
	return(nil);
	}
	
- (ARSimpleToken*) nextIdentifier
	{
	char string[1024];
	char* ps;
	
	ps = string;
	*ps++ = currentChar;
	[self nextCharacter];
	while ((isdigit(currentChar) || isalpha(currentChar)) && (currentChar != 254))
		{
		*ps++ = currentChar;
		[self nextCharacter];
		}
	if (currentChar == ':')
		{
		*ps++ = ':';
		*ps = 0;
		[self nextCharacter];
		return([ARSimpleToken keywordToken: [NSString stringWithUTF8String: string]]);
		}
	*ps = 0;
	return([ARSimpleToken identifierToken: [NSString stringWithUTF8String: string]]);
	}
	
- (ARSimpleToken*) nextString
	{
	char string[10240];
	char* ps;
	
	ps = string;
	[self nextCharacter];
	while (currentChar != 254 && currentChar != '\'')
		{
		*ps++ = currentChar;
		[self nextCharacter];
		}
	*ps = 0;
	if (currentChar == '\'')
		{
		[self nextCharacter];
		}
	return([ARSimpleToken stringToken: [NSString stringWithUTF8String: string]]);
	}
	
- (ARSimpleToken*) nextNumber
	{
	long number;
	
	number = currentChar - '0';
	[self nextCharacter];
	while (isdigit(currentChar))
		{
		number *= 10;
		number += currentChar - '0';
		[self nextCharacter];
		}
	return([ARSimpleToken integerToken: number]);
	}
	
- (void) scanComment
	{
	[self nextCharacter];
	while (currentChar != 254 && currentChar != '"')
		{
		[self nextCharacter];
		}
	if (currentChar == '"')
		{
		[self nextCharacter];
		}
	}
	
@end
