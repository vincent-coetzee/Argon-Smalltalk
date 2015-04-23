//
//  ViewController.m
//  Argon
//
//  Created by Vincent Coetzee on 2015/01/02.
//  Copyright (c) 2015 MacSemantics. All rights reserved.
//

#import "ARSystemBrowserViewController.h"
#import "ARVM.h"
#import "VACValueModeling.h"
#import "ARBrowserCell.h"
#import "ARBrowsedClass.h"
#import "ARDictionary.h"
#import "ARMethod.h"
#import "ARSimpleParser.h"
#import "ARParsingContext.h"
#import "ARStylePalette.h"

@implementation ARSystemBrowserViewController
	{
	IBOutlet __strong NSOutlineView* _outliner;
	IBOutlet __strong NSTextView* _sourceView;
	IBOutlet __strong NSTableView* _methodsView;
	IBOutlet __strong NSButtonCell* _classMethodsButton;
	IBOutlet __strong NSButtonCell* _instanceMethodsButton;
	IBOutlet __strong NSButton* _indexedButton;
	IBOutlet __strong NSButton* _bytesButton;
	__strong ARVM* _vm;
	__strong VACValueModel* _classesModel;
	__strong NSMutableArray* _browsedClasses;
	__strong ARClass* selectedClass;
	__strong NSArray* methodNames;
	}
	
- (IBAction) onClassMethodsSelected: (id) sender
	{
	[_instanceMethodsButton setState: NSOffState];
	}
	
- (IBAction) onInstanceMethodsSelected: (id) sender
	{
	[_classMethodsButton setState: NSOffState];
	}
	
- (IBAction) onIndexedSelected: (id) sender
	{
	}
	
- (IBAction) onBytesSelected: (id) sender
	{
	}
	
- (IBAction) onSave: (id) sender
	{
	ARMethod* newMethod;
	ARSimpleParser* parser;
	ARParsingContext* context;
	
	newMethod = [[ARVM activeVM] newMethod];
	newMethod.methodSource = [[ARVM activeVM] stringWithNSString: _sourceView.string]; 
	parser = [ARSimpleParser new];
	context = [parser parseMethod: newMethod forClass: selectedClass];
	newMethod.compiledMethod = context.theCompiledMethod;
	[context.theClass.methodDictionary setValue: newMethod forKey: newMethod.methodSelector];
	methodNames = [selectedClass.methodDictionary allKeys];
	NSLog(@"Size of byteCodeArray is %ld",context.theCompiledMethod.byteCode.count);
	NSLog(@"Size of literalFrame is %ld",context.theCompiledMethod.literalFrame.count);
	NSLog(@"Size of temporaryFrame is %ld",context.theCompiledMethod.temporaryFrame.count);
	[_methodsView reloadData];
	}
	
- (void)viewDidLoad 
	{
	[super viewDidLoad];
	[ARVM initVM];
	_vm = [ARVM activeVM];
	_outliner.backgroundColor = [[ARStylePalette sharedPalette] defaultBackgroundColor];
	_methodsView.backgroundColor = [[ARStylePalette sharedPalette] defaultBackgroundColor];
	[self initBrowsedClasses];
	[_outliner reloadData];
	[_instanceMethodsButton setFont: [[ARStylePalette sharedPalette] defaultFont]];
	[_classMethodsButton setFont: [[ARStylePalette sharedPalette] defaultFont]];
	[_indexedButton setFont: [[ARStylePalette sharedPalette] defaultFont]];
	[_bytesButton setFont: [[ARStylePalette sharedPalette] defaultFont]];
	[_instanceMethodsButton setState: NSOnState];
	[_classMethodsButton setState: NSOffState];
	[_indexedButton setState: NSOffState];
	[_bytesButton setState: NSOffState];
	[_sourceView setFont: [[ARStylePalette sharedPalette] defaultFont]];
	[_methodsView setTarget: self];
	[_methodsView setAction: @selector(methodSelected:)];
	}
	
- (void) methodSelected: (id) sender
	{
	NSInteger rowIndex;
	ARString* methodName;
	ARString* source;
	
	rowIndex = _methodsView.clickedRow;
	if (rowIndex == -1)
		{
		return;
		}
	methodName = [ARString objectWithObject: methodNames[rowIndex]];
	source = [selectedClass sourceForMethodWithName: methodName];
	if (source != nil)
		{
		_sourceView.string = source;
		}
	}
	
- (NSUInteger) numberOfRowsInTableView: (NSTableView*) tableView
	{
	if (selectedClass.methodDictionary.isNil)
		{
		return(0);
		}
	return(selectedClass.methodDictionary.count);
	}
	
- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
	{
	ARString* string;
	
	string = [ARString objectWithObject: methodNames[rowIndex]];
	return(string.NSString);
	}
	
- (NSView *)tableView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn row: (NSInteger) row
	{
	NSTextField* textField;
	
	textField = [NSTextField new];
	textField.stringValue = [ARString objectWithObject: methodNames[row]].NSString;
	[textField setDrawsBackground: NO];
	[textField setBordered: NO];
	[textField setFont: [NSFont fontWithName: @"SunSansSemiBold" size: 12]];
	return(textField);
	}
	
- (void)outlineViewSelectionDidChange:(NSNotification *)notification
	{
	NSUInteger	row;
	ARBrowsedClass* item;
	ARClass* aClass;
	ARString* source;
	NSString* string;
	
	row = [_outliner selectedRow];
	item = [_outliner itemAtRow: row];
	aClass = [item browsedClass];
	source = aClass.classSource;
	if (source.isNil)
		{
		string = [aClass generateClassSourceNSString];
		}
	else
		{
		string = source.NSString;
		}
	[_sourceView setString: string];
	selectedClass = aClass;
	[_methodsView reloadData];
	}
	
- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
	{
	if (item == nil)
		{
		return(_browsedClasses.count);
		}
	return([item childCount]);
	}
	
- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
	{
	return([item childCount] > 0);
	}
	
- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item
	{
	if (item == nil)
		{
		return(_browsedClasses[index]);
		}
	return([item childAtIndex: index]);
	}
	
- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item
	{
	NSUInteger column;
	
	column = [tableColumn.identifier intValue];
	if (column == 0)
		{
		return([item name]);
		}
	return(nil);
	}
	
- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item
	{
	NSTextField* textField;
	
	textField = [NSTextField new];
	textField.stringValue = [item name];
	[textField setDrawsBackground: NO];
	[textField setBordered: NO];
	[textField setFont: [NSFont fontWithName: @"SunSansSemiBold" size: 12]];
	return(textField);
	}
	
- (void) initBrowsedClasses
	{
	NSArray* classes;
	ARBrowsedClass* browsed;
	
	_browsedClasses = [NSMutableArray array];
	classes = [_vm allRootClasses];
	for (ARClass* aClass in classes)
		{
		browsed = [ARBrowsedClass new];
		[browsed setBrowsedClass: aClass];
		[_browsedClasses addObject: browsed];
		}
	}

- (void)setRepresentedObject:(id)representedObject 
	{
	[super setRepresentedObject:representedObject];
	// Update the view, if already loaded.
	}

@end
