//
//  BBDSelectionInList.h
//  ESKOMWorkplanner
//
//  Created by Vincent Coetzee on 2013/02/07.
//  Copyright (c) 2013 ESKOM (Pty) Ltd. All rights reserved.
//

#import "VACAbstractModel.h"
#import "VACValueModeling.h"

@interface VACSelectionInList : VACAbstractModel

@property(readwrite,strong) VACValueModel* selectionModel;
@property(readwrite,strong) NSArray* list;

@end
