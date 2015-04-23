//
//  ARTranscriptViewController.m
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/04.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import "ARTranscriptViewController.h"

static ARTranscriptViewController* _Transcript;

@interface ARTranscriptViewController ()

@end

@implementation ARTranscriptViewController
	{
	IBOutlet __strong NSTextView* _textView;
	}
	
+ (instancetype) sharedTranscript
	{
	return(_Transcript);
	}
	
- (void) printWithFormat: (NSString*) format,...
	{
	va_list arguments;
	NSString* string;
	NSString* text;
	
	va_start(arguments,format);
	string = [[NSString alloc] initWithFormat: format arguments: arguments];
	text = [_textView.string stringByAppendingString: string];
	[_textView setString: text];
	[_textView setFont: [NSFont fontWithName: @"SunSansSemiBold" size: 12]];
	va_end(arguments);
	}
	
- (void) printlnWithFormat: (NSString*) format,...
	{
	va_list arguments;
	NSString* string;
	NSString* text;
	
	va_start(arguments,format);
	string = [[NSString alloc] initWithFormat: format arguments: arguments];
	text = [_textView.string stringByAppendingString: string];
	text = [text stringByAppendingString: @"\n"];
	[_textView setString: text];
	[_textView setFont: [NSFont fontWithName: @"SunSansSemiBold" size: 12]];
	va_end(arguments);
	}
	
- (void) viewDidLoad 
	{
    [super viewDidLoad];
	[_textView setFont: [NSFont fontWithName: @"SunSansSemiBold" size: 12]];
    _Transcript = self;
	}

@end
