//
//  ListingsService.m
//  CodingTest
//
//  Created by Jonathan Banga on 4/9/14.
//  Copyright (c) 2014 ExequielBanga. All rights reserved.
//

#import "ListingsService.h"
#import "ListingsListParser.h"
#import "SearchFilter.h"

@interface ListingsService()
@end

@implementation ListingsService

- (RestMethod)method {
    return RestMethodGET;
}

- (NSObject *)requestSuccessWithResponseObject:(NSDictionary *)responseObject {
    ListingsListParser *parser = [ListingsListParser new];
    [parser parse:responseObject];
    return parser.resultObjects;
}

- (void)getItemsWithSearchFilter:(SearchFilter *)filter withBlock:(ServiceBlock)serviceBlock{
    self.path = [NSString stringWithFormat:@"listings/active?limit=%d&offset=%d",(int)filter.pageSize,(int)(filter.currentPage*filter.pageSize)];
    if (filter.queryString.length) {
        self.path = [self.path stringByAppendingFormat:@"&keywords=%@&",filter.queryString];
    }else{
        self.path = [self.path stringByAppendingString:@"&"];
    }
    [super requestWithServiceBlock:serviceBlock];
}

@end
