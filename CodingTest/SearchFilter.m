//
//  SearchFilter.m
//  CodingTest
//
//  Created by Jonathan Banga on 4/9/14.
//  Copyright (c) 2014 ExequielBanga. All rights reserved.
//

#import "SearchFilter.h"
#import "ItemPaginator.h"

@implementation SearchFilter

+ (instancetype)searchFilterWithItemPaginator:(ItemPaginator *)paginator queryString:(NSString *)queryString{
    SearchFilter *filter = [SearchFilter new];
    if (filter) {
        filter.pageSize = paginator.pageSize;
        filter.currentPage = paginator.currentPage;
        filter.queryString = queryString;        
    }
    return filter;
}


@end
