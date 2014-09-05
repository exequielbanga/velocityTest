//
//  ImagesService.h
//  CodingTest
//
//  Created by Exequiel Banga on 4/9/14.
//  Copyright (c) 2014 ExequielBanga. All rights reserved.
//

#import "RestService.h"

@class Item;

@interface ImagesService : RestService

- (void)getImagesForItem:(Item *)item withBlock:(ServiceBlock)serviceBlock;

@end
