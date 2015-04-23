//
//  BBDSortingFilter.h
//  ESKOMWorkplanner
//
//  Created by Vincent Coetzee on 2013/03/23.
//  Copyright (c) 2013 ESKOM (Pty) Ltd. All rights reserved.
//

#import "VACValueHolder.h"

@interface VACSortingFilter : VACValueHolder < VACDependence >

+ (id) sortingFilterOnList: (VACValueModel*) listModel withKey: (NSString*) key ascending: (BOOL) ascending;
@property(readwrite,strong) NSArray* sortDescriptors;
@property(readwrite,strong) VACValueModel* list;

@end
