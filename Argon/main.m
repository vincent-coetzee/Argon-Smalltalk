//
//  main.m
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/02.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import <Cocoa/Cocoa.h>

int main(int argc, const char * argv[]) 
	{
	@autoreleasepool
		{
		@try
			{
			return NSApplicationMain(argc, argv);
			}
		 @catch(NSException* exception)
            {
            NSLog(@"**************************************************************");
            NSLog(@"*");
            NSLog(@"* LAST DITCH EXCEPTION HANDLER !");
            NSLog(@"* YOUR THREAD OF EXECUTION SHOULD NEVER END UP HERE !");
            NSLog(@"*");
            NSLog(@"* %@",exception);
            NSLog(@"*");
            for (NSString* symbol in [exception callStackSymbols])
                {
                NSLog(@"* %@",symbol);
                }
            NSLog(@"*");
            NSLog(@"**************************************************************");
            }
		}
	}
