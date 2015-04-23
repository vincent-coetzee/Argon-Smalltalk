//
//  BBDTextNumberTranscriptase.h
//  MomentumWealth
//
//  Created by Elad Tchetchik on 2012/09/19.
//  Copyright (c) 2012 Momentum Wealth (Pty) Ltd. All rights reserved.
//

#import "VACValueHolder.h"

@interface VACTextNumberTranscriptase : VACValueHolder <VACDependence>

@property (nonatomic, strong) VACValueModel* model;
@property (nonatomic, strong) id(^textToNumber)(id);
@property (nonatomic, strong) id(^numberToText)(id);


+ (id) textIntegerTranscriptaseOn:(VACValueModel*)model;
+ (id) textFloatTranscriptaseOn:(VACValueModel*)model withNumberOfDecimalPlaces:(NSUInteger)decimalPlaces;
+ (id) textFloatPercentageTranscriptaseOn: (VACValueModel*) aModel withNumberOfDecimalPlaces:(NSUInteger)decimalPlaces;
+ (id) textPercentageTranscriptaseOn: (VACValueModel*) aModel withNumberOfDecimalPlaces:(NSUInteger)decimalPlaces percentSymbol:(NSString*) percentSymbol;
+ (id) textPercentageTranscriptaseOn:(VACValueModel*)model withNumberOfDecimalPlaces:(NSUInteger)decimalPlaces;
+ (id) textPercentageFromFractionTranscriptaseOn:(VACValueModel*)model withNumberOfDecimalPlaces:(NSUInteger)decimalPlaces;
+ (id) textPercentageFromFractionTranscriptaseWithoutPercentageSymbolOn:(VACValueModel*)model withNumberOfDecimalPlaces:(NSUInteger)decimalPlaces;
+ (id) textRemainingPercentageFromFractionTranscriptaseOn:(VACValueModel*)model withNumberOfDecimalPlaces:(NSUInteger)decimalPlaces;
+ (id) textCurrencyTranscriptaseOn: (VACValueModel*)model withCurrencySymbol:(NSString*)currencySymbol thousandthDecimalDisplayCharacter:(NSString*)displayCharacter;
+ (id) textPercentageNoSymbolTranscriptaseOn: (VACValueModel*) aModel withNumberOfDecimalPlaces:(NSUInteger)decimalPlaces;

@end
