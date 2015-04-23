//
//  NSObject+Extensions.h
//  SoD
//
//  Created by Vincent Coetzee on 2011/12/27.
//  Copyright (c) 2011 BBD (Pty) Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject(VACExtensions)

- (BOOL) isView;
- (BOOL) isViewController;
- (BOOL) isPanel;
- (BOOL) isDecimalNumber;
- (BOOL) isNull;
- (BOOL) isNotNull;
- (BOOL) isString;
- (BOOL) isKeyValueAssociation;
- (BOOL) isDate;
- (BOOL) isNumber;
- (BOOL) isDictionary;
- (BOOL) isArray;
- (BOOL) isValue;
- (id) value;
- (void) setValue: (id) value;
- (BOOL) validateValue: (id) aValue error: (NSError**) anError;
- (NSString*) printString;

- (BOOL) isError;

@end

@interface NSNull(BBDExtensions)

- (BOOL) isNull;
- (BOOL) isNotNull;

@end
