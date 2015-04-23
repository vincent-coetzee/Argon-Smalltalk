//
//  BBDDateToStringAdaptor.h
//  MomentumWealth
//
//  Created by Elad Tchetchik on 2012/10/03.
//  Copyright (c) 2012 Momentum Wealth (Pty) Ltd. All rights reserved.
//

#import "VACAbstractModel.h"
#import "VACValueModeling.h"

@interface VACDateToStringAdaptor : VACAbstractModel <VACValueModeling,VACDependence>

@property(nonatomic,strong) VACValueModel* model;

+ (id) newWithDateModel:(VACValueModel*) dateModel;

@end
