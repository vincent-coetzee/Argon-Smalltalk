//
//  ARASTSmalltalkToken.m
//  Talk
//
//  Created by Vincent Coetzee on 2014/11/22.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import "ARSimpleToken.h"

@implementation ARSimpleToken
	
+ (ARSimpleToken*) symbolToken: (int) symbolValue
	{
	ARSimpleToken* token;
	
	token = [ARSimpleToken new];
	token.type = symbolValue;
	return(token);
	}
	
+ (ARSimpleToken*) stringToken: (NSString*) string
	{
	ARSimpleToken* token;
	
	token = [ARSimpleToken new];
	token.type = T_STRING;
	token.stringValue = string;
	return(token);
	}
	
+ (ARSimpleToken*) keywordToken: (NSString*) string
	{
	ARSimpleToken* token;
	
	token = [ARSimpleToken new];
	token.type = T_KEYWORD;
	token.stringValue = string;
	return(token);
	}
	
+ (ARSimpleToken*) identifierToken: (NSString*) string
	{
	ARSimpleToken* token;
	
	token = [ARSimpleToken new];
	token.type = T_IDENTIFIER;
	token.stringValue = string;
	return(token);
	}
	
+ (ARSimpleToken*) integerToken: (long) number
	{
	ARSimpleToken* token;
	
	token = [ARSimpleToken new];
	token.type = T_INTEGER;
	token.longValue = number;
	return(token);
	}
	
+ (ARSimpleToken*) eofToken
	{
	ARSimpleToken* token;
	
	token = [ARSimpleToken new];
	token.type = T_EOF;
	return(token);
	}
	
- (NSString*) tokenSelectorString
	{
	switch(self.type)
		{
	case(T_PLUS):
		return(@"__PLUS__");
	case(T_SLASH):
		return(@"__SLASH__");
	case(T_BACK):
		return(@"__BACK__");
	case(T_MUL):
		return(@"__MUL__");
	case(T_TILDE):
		return(@"__TILDE__");
	case(T_LESS):
		return(@"__LESS__");
	case(T_EQUAL):
		return(@"__EQUAL__");
	case(T_MORE):
		return(@"__MORE__");
	case(T_AT):
		return(@"__AT__");
	case(T_PERCENT):
		return(@"__PERCENT__");
	case(T_BAR):
		return(@"__BAR__");
	case(T_AND):
		return(@"__AND__");
	case(T_QUESTION):
		return(@"__QUESTION__");
	case(T_BANG):
		return(@"__BANG__");
	default:
		return(self.stringValue);
		}
	}

- (BOOL) isPeriod
	{
	return(self.type == T_PERIOD);
	}
	
- (BOOL) isInteger
	{
	return(self.type == T_INTEGER);
	}
	
- (BOOL) isCaret
	{
	return(self.type == T_CARET);
	}
	
- (BOOL) isLeftPar
	{
	return(self.type == T_LPAR);
	}
	
- (BOOL) isRightPar
	{
	return(self.type == T_RPAR);
	}

- (BOOL) isAssign
	{
	return(self.type == T_ASSIGN);
	}
	
- (BOOL) isBang
	{
	return(self.type == T_BANG);
	}
	
- (BOOL) isEOF
	{
	return(self.type == T_EOF);
	}
	
- (BOOL) isColon
	{
	return(self.type == T_COLON);
	}
	
- (BOOL) isBar
	{
	return(self.type == T_BAR);
	}
	
- (BOOL) isIdentifier
	{
	return(self.type == T_IDENTIFIER);
	}
	
- (BOOL) isKeyword
	{
	return(self.type == T_KEYWORD);
	}
	
- (BOOL) isSpecialCharacter
	{
	switch(self.type)
		{
	case(T_PLUS):
	case(T_SLASH):
	case(T_BACK):
	case(T_MUL):
	case(T_TILDE):
	case(T_LESS):
	case(T_EQUAL):
	case(T_MORE):
	case(T_AT):
	case(T_PERCENT):
	case(T_BAR):
	case(T_AND):
	case(T_QUESTION):
	case(T_BANG):
		return(YES);
	default:
		return(NO);
		}
	}

- (void) println
	{
	NSLog(@"%@",self);
	}
	
- (NSString*) description
	{
	NSString* output;
	
	switch(self.type)
		{
	case(T_HASH):
		output = @"#";
		break;
	case(T_DOLLAR):
		output = @"$";
		break;
	case(T_LPAR):
		output = @"(";
		break;
	case(T_RPAR):
		output = @")";
		break;
	case(T_LBRA):
		output = @"[";
		break;
	case(T_RBRA):
		output = @"]";
	case(T_PLUS):
		output = @"+";
		break;
	case(T_MINUS):
		output = @"-";
		break;
	case(T_SLASH):
		output = @"/";
		break;
	case(T_BACK):
		output = @"/";
		break;
	case(T_TILDE):
		output = @"~";
		break;
	case(T_LESS):
		output = @"<";
		break;
	case(T_MORE):
		output = @">";
		break;
	case(T_EQUAL):
		output = @"=";
		break;
	case(T_AT):
		output = @"@";
		break;
	case(T_PERCENT):
		output = @"%%";
		break;
	case(T_BAR):
		output = @"|";
		break;
	case(T_AND):
		output = @"&";
		break;
	case(T_CARET):
		output = @"^";
		break;
	case(T_QUESTION):
		output = @"?";
		break;
	case(T_BANG):
		output = @"!";
		break;
	case(T_IDENTIFIER):
		output = [NSString stringWithFormat: @"IDENTIFIER,%@",self.stringValue];
		break;
	case(T_STRING):
		output = [NSString stringWithFormat: @"STRING,%@",self.stringValue];
		break;
	case(T_INTEGER):
		output = [NSString stringWithFormat: @"INTEGER,%lu",self.longValue];
		break;
	case(T_EOF):
		output = @"EOF";
		break;
	case(T_MUL):
		output = @"*";
		break;
	case(T_COLON):
		output = @":";
		break;
	case(T_KEYWORD):
		output = [NSString stringWithFormat: @"KEYWORD,%@",self.stringValue];
		break;
	case(T_ASSIGN):
		output = @"ASSIGN";
		break;
	case(T_DOUBLE):
		output = @"DOUBLE";
		break;
	case(T_PERIOD):
		output = @".";
		break;
	default:
		output = @"UNKNOWN TOKEN TYPE";
		}
	return([NSString stringWithFormat: @"TOKEN(%@)",output]);
	}
	
@end
