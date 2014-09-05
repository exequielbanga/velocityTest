//
//  ListingsListParser.m
//  CodingTest
//
//  Created by Jonathan Banga on 4/9/14.
//  Copyright (c) 2014 ExequielBanga. All rights reserved.
//

#import "ListingsListParser.h"
#import "Item.h"

@implementation ListingsListParser

- (NSString *)keyPathToResponse{
    return @"results";
}

- (Class)responseObjectsClass{
    return [Item class];
}

@end
