//
//  ImagesService.m
//  CodingTest
//
//  Created by Exequiel Banga on 4/9/14.
//  Copyright (c) 2014 ExequielBanga. All rights reserved.
//

#import "ImagesService.h"
#import "ImagesParser.h"
#import "Item.h"

@implementation ImagesService

- (RestMethod)method {
    return RestMethodGET;
}

- (NSObject *)requestSuccessWithResponseObject:(NSDictionary *)responseObject {
    ImagesParser *parser = [ImagesParser new];
    [parser parse:responseObject];
    return parser.resultObjects;
}

- (void)getImagesForItem:(Item *)item withBlock:(ServiceBlock)serviceBlock{
    self.path = [NSString stringWithFormat:@"listings/%@/images?",item.itemId];
    [super requestWithServiceBlock:serviceBlock];
}


@end
