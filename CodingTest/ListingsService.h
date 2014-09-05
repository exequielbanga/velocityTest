//
//  ListingsService.h
//  CodingTest
//
//  Created by Jonathan Banga on 4/9/14.
//  Copyright (c) 2014 ExequielBanga. All rights reserved.
//

#import "RestService.h"
@class SearchFilter;

@interface ListingsService : RestService

- (void)getItemsWithSearchFilter:(SearchFilter *)filter withBlock:(ServiceBlock)serviceBlock;

@end
