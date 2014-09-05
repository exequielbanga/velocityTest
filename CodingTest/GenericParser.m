//
//  GenericParser.m
//
//  Created by Exequiel Banga on 13/06/11.
//  Copyright 2011 ExequielBanga. All rights reserved.
//

#import "GenericParser.h"

@implementation GenericParser

- (id)init {
    self = [super init];
    if (self) {
        self.resultObjects = [NSMutableArray array];
    }
    return self;
}

- (void)parse:(NSDictionary *)data {
    NSError *error = [self errorFromDictionary:data];
    if (error) {
        self.error = error;
    }else{
        [self parseResponse:data];
    }
}

- (NSString *)keyPathToResponse{
    // Abstract method
    return nil;
}

- (Class)responseObjectsClass{
    // Abstract method
    return nil;
}

- (void)parseResponse:(NSDictionary *)dictionary{
    NSObject *objectToParse = [dictionary valueForKeyPath:[self keyPathToResponse]];
    
    if ([objectToParse isKindOfClass:[NSDictionary class]]) {
        [self.resultObjects addObject:[[[self responseObjectsClass] alloc] initWithDictionary:(NSDictionary *)objectToParse]];
    }else if([objectToParse isKindOfClass:[NSArray class]]){
        for (NSDictionary* objectData in (NSArray *)objectToParse) {
            [self.resultObjects addObject:[[[self responseObjectsClass] alloc] initWithDictionary:objectData]];
        }
    }else{
        self.error = [NSError errorWithDomain:nil code:0 userInfo:@{NSLocalizedDescriptionKey:@"Parsing Error"}];
    }
}

- (NSError *)errorFromDictionary:(NSDictionary *)dictionary{
    return nil;
}

@end
