//
//  SearchFilter.h
//  CodingTest
//
//  Created by Jonathan Banga on 4/9/14.
//  Copyright (c) 2014 ExequielBanga. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ItemPaginator;

@interface SearchFilter : NSObject

@property(nonatomic,assign)NSUInteger  currentPage;
@property(nonatomic,assign)NSUInteger  pageSize;
@property(nonatomic,strong)NSString   *queryString;

+ (instancetype)searchFilterWithItemPaginator:(ItemPaginator *)paginator queryString:(NSString *)queryString;


@end
