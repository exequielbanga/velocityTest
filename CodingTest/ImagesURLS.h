//
//  ImagesURLS.h
//  CodingTest
//
//  Created by Jonathan Banga on 4/9/14.
//  Copyright (c) 2014 ExequielBanga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImagesURLS : NSObject
@property(nonatomic,copy)NSString *small;
@property(nonatomic,copy)NSString *big;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
