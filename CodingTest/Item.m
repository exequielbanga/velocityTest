//
//  Item.m
//  CodingTest
//
//  Created by Jonathan Banga on 4/9/14.
//  Copyright (c) 2014 ExequielBanga. All rights reserved.
//

#import "Item.h"

@implementation Item

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        
        if (dictionary[@"listing_id"]) {
            self.itemId = dictionary[@"listing_id"];
        }
        if (dictionary[@"title"]) {
            self.title = dictionary[@"title"];
        }
        if (dictionary[@"description"]) {
            self.itemDescription = dictionary[@"description"];
        }
        if (dictionary[@"quantity"]) {
            self.quantity = dictionary[@"quantity"];
        }
        if (dictionary[@"price"]) {
            NSNumberFormatter *formatter = [NSNumberFormatter new];
            formatter.decimalSeparator = @".";
            self.price = [formatter numberFromString:dictionary[@"price"]];
        }
        if (dictionary[@"tags"]) {
            self.tags = dictionary[@"tags"];
        }
//        if (dictionary[@"tags"]) {
//            self.imageURL = [NSURL URLWithString:dictionary[@"tags"]];
//        }
    }
    return self;
}

@end
