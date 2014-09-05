//
//  ImagesParser.m
//  CodingTest
//
//  Created by Jonathan Banga on 4/9/14.
//  Copyright (c) 2014 ExequielBanga. All rights reserved.
//

#import "ImagesParser.h"
#import "ImagesURLS.h"

@implementation ImagesParser

- (NSString *)keyPathToResponse{
    return @"results";
}

- (Class)responseObjectsClass{
    return [ImagesURLS class];
}

@end
