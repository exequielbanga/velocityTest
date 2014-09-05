//
//  ImagesURLS.m
//  CodingTest
//
//  Created by Exequiel Banga on 4/9/14.
//  Copyright (c) 2014 ExequielBanga. All rights reserved.
//

#import "ImagesURLS.h"

@implementation ImagesURLS

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        if (dictionary[@"url_75x75"]) {
            self.small = dictionary[@"url_75x75"];
        }
        if (dictionary[@"url_fullxfull"]) {
            self.big = dictionary[@"url_fullxfull"];
        }
    }
    return self;
}

@end
