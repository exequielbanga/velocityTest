//
//  Item.h
//  CodingTest
//
//  Created by Exequiel Banga on 4/9/14.
//  Copyright (c) 2014 ExequielBanga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject
@property (nonatomic,strong)NSString *itemId;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *itemDescription;
@property (nonatomic,strong)NSNumber *quantity;
@property (nonatomic,strong)NSNumber *price;
@property (nonatomic,strong)NSArray *tags;
@property (nonatomic,strong)NSArray *images;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
