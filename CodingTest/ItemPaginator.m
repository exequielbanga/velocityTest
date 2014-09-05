//
//  ItemPaginator.m
//  CodingTest
//
//  Created by Exequiel Banga on 4/9/14.
//  Copyright (c) 2014 ExequielBanga. All rights reserved.
//

#import "ItemPaginator.h"

@implementation ItemPaginator
- (instancetype)init{
    self = [super init];
    if (self) {
        self.items = [NSMutableArray new];
        self.currentPage = 0;
        self.pageSize = 20;
    }
    return self;
}

@end
