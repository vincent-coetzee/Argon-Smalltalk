//
//  VACSymbols.h
//  DiscoveryInsure
//
//  Created by Vincent Coetzee on 2012/04/10.
//  Copyright (c) 2012 VAC (Pty) Ltd. All rights reserved.
//

#ifndef VACSymbols_h
#define VACSymbols_h

/*
**
** Note from VAC
**
** This is really crappy I know, but in theory it should work correctly
** and it should not cause any problems since a selector is unique and
** it won't interfere with the underlying mechanism since we are not hacking
** anything just overloading the meaning.
**
** Namespaces may fuck this up !
**
** What this gives us is the ability to implement aspect testing
** extremely efficiently also to do identity tests and fancy
** dispatch.
**
*/

#ifndef VACSymbol

#define VACSymbol SEL
#define VACSymbolFromNSString(_string_) (NSSelectorFromString(_string_))
#define NSStringFromVACSymbol(_symbol_) (NSStringFromSelector(_symbol_))

#define VACSymbolValue VACSymbolFromNSString(@"value")
#define VACSymbolSelection VACSymbolFromNSString(@"selection")
#define VACSymbolSelectionIndex VACSymbolFromNSString(@"selectionIndex")
#define VACSymbolIndex VACSymbolFromNSString(@"index")
#define VACSymbolList VACSymbolFromNSString(@"list")

#define VACSymbolNULL (NULL)

#endif

#endif
