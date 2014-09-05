//
//  GenericParser.h
//
//  Created by Exequiel Banga on 13/06/11.
//  Copyright 2011 ExequielBanga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GenericParser : NSObject

@property(nonatomic, strong) NSMutableArray *resultObjects;
@property(nonatomic, strong) NSError *error;

- (void)parse:(NSDictionary *)data;
- (NSError *)errorFromDictionary:(NSDictionary *)dictionary;

//To overwrite in subclasses
- (NSString *)keyPathToResponse;
- (Class)responseObjectsClass;
- (void)parseResponse:(NSDictionary*)response;

@end
