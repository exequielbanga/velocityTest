//
//  RestService.h
//  Allianz
//
//  Created by Exequiel Banga on 9/4/14.
//  Copyright (c) 2014 Exequiel Banga. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum  {
    RestMethodGET = 0,
    RestMethodPOST
} RestMethod;

typedef void (^ServiceBlock)(NSObject *response, NSError * error);

@interface RestService : NSObject

@property (nonatomic, strong) NSString* path;
@property (nonatomic, strong) NSDictionary* queryParams;
@property (nonatomic, strong) NSDictionary* bodyParams;
@property (nonatomic) BOOL isRunning;

- (void)requestWithServiceBlock:(ServiceBlock)serviceBlock;

- (void)invalidate;

@end
