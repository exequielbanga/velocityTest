//
//  RestService.h
//  Allianz
//
//  Created by Exequiel Banga on 9/4/14.
//  Copyright (c) 2014 Exequiel Banga. All rights reserved.
//


#import "RestService.h"
#import "AFNetworking.h"

#define kURI @"https://openapi.etsy.com/v2/"
#define kAPIKey @"2yel9hwm3xxgtmbv1yisuxdh"

@interface RestService()
@property (nonatomic, strong) AFHTTPRequestOperation* requestOperation;
@end

@implementation RestService


- (id)init {
    self = [super init];
    if (self) {
        self.isRunning = NO;
    }
    return self;
}

#pragma mark - To inherit
- (RestMethod)method {
    return RestMethodGET;
}

// Se llamara a este metodo cuando todo haya terminado con code 2xx
- (NSObject*)requestSuccessWithResponseObject:(id)responseObject {
    return nil;
}

// username for authen caso de ser una llamada autenticada
- (NSString*)username {
    return nil;
}

// El password en caso de ser una llamada autenticada
- (NSString*)password {
    return nil;
}

// YES si es autenticada, NO en caso contrario
- (BOOL)isAuthenticated {
    return YES;
}

#pragma mark - Private
- (void)requestWithServiceBlock:(ServiceBlock)serviceBlock {
    if ([self method] == RestMethodGET) {
        [self makeGetWithServiceBlock:serviceBlock];
    } else {
        [self makePost];
    }
}

- (void)makeGetWithServiceBlock:(ServiceBlock)serviceBlock {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];

    if ([self isAuthenticated]) {
        [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:[self username]  password:[self password]];
    }

    NSString* path = [NSString stringWithFormat:@"%@%@api_key=%@", kURI, self.path,kAPIKey];
    self.isRunning = YES;
    self.requestOperation = [manager GET:path parameters:self.queryParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.isRunning = NO;
        NSObject* returnObject = [self requestSuccessWithResponseObject:responseObject];
        if (serviceBlock) {
            serviceBlock(returnObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.isRunning = NO;
        // No es porque cancelamos el request
        if (serviceBlock && error.code != -999) {
            serviceBlock(nil, error);
        }
    }];
}

- (void)makePost {
#warning TODO
}

- (void)invalidate {
    [self.requestOperation cancel];
    self.isRunning = NO;
}

- (void)dealloc {
    [self invalidate];
}

@end
