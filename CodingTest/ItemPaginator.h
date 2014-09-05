//
//  ItemPaginator.h
//  CodingTest
//
//  Created by Exequiel Banga on 4/9/14.
//  Copyright (c) 2014 ExequielBanga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemPaginator : NSObject
@property(nonatomic,strong)NSMutableArray *items;
@property(nonatomic,assign)NSUInteger currentPage;
@property(nonatomic,assign)NSUInteger pageSize;
@end
