//
//  BBDTextNumberTranscriptase.m
//  MomentumWealth
//
//  Created by Elad Tchetchik on 2012/09/19.
//  Copyright (c) 2012 Momentum Wealth (Pty) Ltd. All rights reserved.
//

#import "VACTextNumberTranscriptase.h"
#import "VACValueModels.h"


@implementation VACTextNumberTranscriptase
    {
    __strong VACValueModel* _numberModel;
    __strong NSNumberFormatter* numberFormatter;
    }

+ (id) textIntegerTranscriptaseOn: (VACValueModel*) aModel
    {
    VACTextNumberTranscriptase* transcriptase;

    transcriptase = [VACTextNumberTranscriptase new];
    transcriptase.numberModel = aModel;
    transcriptase.textToNumber = ^(id input)
        {
        return(@([input intValue]));
        };
    transcriptase.numberToText = ^(id input)
        {
        return([input stringValue]);
        };
    return(transcriptase);
    }

+ (id) textFloatTranscriptaseOn: (VACValueModel*) aModel withNumberOfDecimalPlaces:(NSUInteger)decimalPlaces
    {
    VACTextNumberTranscriptase* transcriptase;
    __block NSNumberFormatter* numberFormatter;

    transcriptase = [VACTextNumberTranscriptase new];
    [transcriptase setupNumberFormatterWithDecimalPlaces:decimalPlaces andGroupingSeparator:@"," andCurrencySymbol:@"" andPercentSymbol:@"" andNumberStyle:NSNumberFormatterDecimalStyle];
    transcriptase.numberModel = aModel;
    numberFormatter = [transcriptase numberFormatter];
    transcriptase.textToNumber = ^(id input)
        {
        return(@([input floatValue]));
        };
    transcriptase.numberToText = ^(id input)
        {
        return([numberFormatter stringFromNumber:input]);
        };
    return(transcriptase);
    }

+ (id) textPercentageTranscriptaseOn: (VACValueModel*) aModel withNumberOfDecimalPlaces:(NSUInteger)decimalPlaces
    {
    VACTextNumberTranscriptase* transcriptase;
    __block NSNumberFormatter* numberFormatter;

    transcriptase = [VACTextNumberTranscriptase new];
    [transcriptase setupNumberFormatterWithDecimalPlaces:decimalPlaces andGroupingSeparator:@"," andCurrencySymbol:@"" andPercentSymbol:@"%" andNumberStyle:NSNumberFormatterPercentStyle];
    transcriptase.numberModel = aModel;
    numberFormatter = [transcriptase numberFormatter];
    transcriptase.textToNumber = ^(id input)
        {
        return(@([input floatValue]));
        };
    transcriptase.numberToText = ^(id input)
        {
        return([numberFormatter stringFromNumber:input]);
        };
    return(transcriptase);
    }

+ (id) textPercentageNoSymbolTranscriptaseOn: (VACValueModel*) aModel withNumberOfDecimalPlaces:(NSUInteger)decimalPlaces
    {
    VACTextNumberTranscriptase* transcriptase;
    __block NSNumberFormatter* numberFormatter;

    transcriptase = [VACTextNumberTranscriptase new];
    [transcriptase setupNumberFormatterWithDecimalPlaces:decimalPlaces andGroupingSeparator:@"," andCurrencySymbol:@"" andPercentSymbol:@"" andNumberStyle:NSNumberFormatterDecimalStyle];
    transcriptase.numberModel = aModel;
    numberFormatter = [transcriptase numberFormatter];
    transcriptase.textToNumber = ^(id input)
        {
        return(@([input floatValue] * 1.0f));
        };
    transcriptase.numberToText = ^(id input)
        {
        return([numberFormatter stringFromNumber:@([input floatValue] * 100.0f)]);
        };
    return(transcriptase);
    }

+ (id) textPercentageTranscriptaseOn: (VACValueModel*) aModel withNumberOfDecimalPlaces:(NSUInteger)decimalPlaces percentSymbol:(NSString*) percentSymbol
    {
    VACTextNumberTranscriptase* transcriptase;
    __block NSNumberFormatter* numberFormatter;

    transcriptase = [VACTextNumberTranscriptase new];
    [transcriptase setupNumberFormatterWithDecimalPlaces:decimalPlaces andGroupingSeparator:@"," andCurrencySymbol:@"" andPercentSymbol:percentSymbol andNumberStyle:NSNumberFormatterPercentStyle];
    transcriptase.numberModel = aModel;
    numberFormatter = [transcriptase numberFormatter];
    transcriptase.textToNumber = ^(id input)
        {
        return(@([input floatValue]));
        };
    transcriptase.numberToText = ^(id input)
        {
        return([numberFormatter stringFromNumber:input]);
        };
    return(transcriptase);
    }

+ (id) textFloatPercentageTranscriptaseOn: (VACValueModel*) aModel withNumberOfDecimalPlaces:(NSUInteger)decimalPlaces
    {
    VACTextNumberTranscriptase* transcriptase;
    __block NSNumberFormatter* numberFormatter;

    transcriptase = [VACTextNumberTranscriptase new];
    [transcriptase setupNumberFormatterWithDecimalPlaces:decimalPlaces andGroupingSeparator:@"," andCurrencySymbol:@"" andPercentSymbol:@"" andNumberStyle:NSNumberFormatterDecimalStyle];
    transcriptase.numberModel = aModel;
    numberFormatter = [transcriptase numberFormatter];
    transcriptase.textToNumber = ^(id input)
        {
        return(@([input floatValue]));
        };
    transcriptase.numberToText = ^(id input)
        {
        return([[numberFormatter stringFromNumber:input] stringByAppendingString: @" %"]);
        };
    return(transcriptase);
    }

+ (id) textPercentageFromFractionTranscriptaseOn:(VACValueModel*)aModel withNumberOfDecimalPlaces:(NSUInteger)decimalPlaces;
    {
    VACTextNumberTranscriptase* transcriptase;
    __block NSNumberFormatter* numberFormatter;
    transcriptase = [VACTextNumberTranscriptase new];
    [transcriptase setupNumberFormatterWithDecimalPlaces:decimalPlaces andGroupingSeparator:@"," andCurrencySymbol:@"" andPercentSymbol:@"" andNumberStyle:NSNumberFormatterDecimalStyle];
    transcriptase.numberModel = aModel;
    numberFormatter = [transcriptase numberFormatter];
    transcriptase.textToNumber = ^(id input)
        {
        return(@([input floatValue]/100));
        };
    transcriptase.numberToText = ^(id input)
        {
        return([[numberFormatter stringFromNumber:(@([input floatValue]*100.0f))] stringByAppendingString: @" %"]);
        };
    return(transcriptase);
    }

+ (id) textRemainingPercentageFromFractionTranscriptaseOn:(VACValueModel*)aModel withNumberOfDecimalPlaces:(NSUInteger)decimalPlaces
    {
    VACTextNumberTranscriptase* transcriptase;
    __block NSNumberFormatter* numberFormatter;
    transcriptase = [VACTextNumberTranscriptase new];
    [transcriptase setupNumberFormatterWithDecimalPlaces:decimalPlaces andGroupingSeparator:@"," andCurrencySymbol:@"" andPercentSymbol:@"" andNumberStyle:NSNumberFormatterDecimalStyle];
    transcriptase.numberModel = aModel;
    numberFormatter = [transcriptase numberFormatter];
    transcriptase.textToNumber = ^(id input)
        {
        return(@(1.00f-[input floatValue]/100));
        };
    transcriptase.numberToText = ^(id input)
        {
        return([[numberFormatter stringFromNumber:(@(100.00f-[input floatValue]*100.0f))] stringByAppendingString: @"%"]);
        };
    return(transcriptase);
    }

+ (id) textPercentageFromFractionTranscriptaseWithoutPercentageSymbolOn:(VACValueModel*)aModel withNumberOfDecimalPlaces:(NSUInteger)decimalPlaces
    {
    VACTextNumberTranscriptase* transcriptase;
    __block NSNumberFormatter* numberFormatter;
    transcriptase = [VACTextNumberTranscriptase new];
    [transcriptase setupNumberFormatterWithDecimalPlaces:decimalPlaces andGroupingSeparator:@"," andCurrencySymbol:@"" andPercentSymbol:@"" andNumberStyle:NSNumberFormatterDecimalStyle];
    transcriptase.numberModel = aModel;
    numberFormatter = [transcriptase numberFormatter];
    transcriptase.textToNumber = ^(id input)
        {
        return(@([input floatValue]/100));
        };
    transcriptase.numberToText = ^(id input)
        {
        return([[numberFormatter stringFromNumber:(@([input floatValue]*100.0f))] stringByAppendingString: @""]);
        };
    return(transcriptase);
    }

+ (id) textCurrencyTranscriptaseOn: (VACValueModel*)model withCurrencySymbol:(NSString*)currencySymbol thousandthDecimalDisplayCharacter:(NSString*)displayCharacter
    {
    VACTextNumberTranscriptase* transcriptase;
    __block NSNumberFormatter* numberFormatter;

    transcriptase = [VACTextNumberTranscriptase new];
    [transcriptase setupNumberFormatterWithDecimalPlaces:2 andGroupingSeparator:displayCharacter andCurrencySymbol:currencySymbol andPercentSymbol:@"" andNumberStyle:NSNumberFormatterCurrencyStyle];
    transcriptase.numberModel = model;
    numberFormatter = [transcriptase numberFormatter];
    transcriptase.textToNumber = ^(id input)
        {
        return(@([input floatValue]));
        };
    transcriptase.numberToText = ^(id input)
        {
        return([numberFormatter stringFromNumber:input]);
        };
    return(transcriptase);
    }

- (id) init
    {
    self = [super init];
    if (self)
        {
        self.numberModel = [VACValueHolder on: @0];
        }
    return(self);
    }

- (void) setupNumberFormatterWithDecimalPlaces:(NSUInteger)numberOfDecimalPlaces andGroupingSeparator:(NSString*) groupingSeparator andCurrencySymbol:(NSString *) currencySymbol andPercentSymbol:(NSString *) percentSymbol andNumberStyle: (NSNumberFormatterStyle) numberStyle
    {
    numberFormatter = [NSNumberFormatter new];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits: numberOfDecimalPlaces];
    [numberFormatter setMinimumFractionDigits: numberOfDecimalPlaces];
    [numberFormatter setRoundingMode: NSNumberFormatterRoundHalfUp];
    [numberFormatter setGroupingSeparator:groupingSeparator];
    [numberFormatter setNotANumberSymbol:@"Illegal Value"];
    [numberFormatter setNumberStyle:numberStyle];
    [numberFormatter setCurrencySymbol:currencySymbol];
    [numberFormatter setDecimalSeparator:@"."];
    [numberFormatter setPercentSymbol:percentSymbol];
    }

- (void) update: (VACSymbol) aspect with: (id) object from: (id) sender
    {
    if (aspect == VACSymbolValue && sender == _numberModel)
        {
        [self changed: VACSymbolValue with: _value from: self];
        }
    }

- (id) value
    {
    return(_numberToText(_numberModel.value));
    }

- (void) setValue: (id) aValue
    {
    _numberModel.value = _textToNumber(aValue);
    }

- (void) setNumberModel: (VACValueModel*) model
    {
    [_numberModel removeDependent: self];
    _numberModel = model;
    [_numberModel addDependent: self];
    }

- (VACValueModel*) numberModel
    {
    return(_numberModel);
    }

- (NSNumberFormatter*) numberFormatter
    {
    return numberFormatter;
    }

@end

