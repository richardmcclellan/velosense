//
//  GMapsHttpClient.m
//  BTHandlebars
//
//  Created by Richard McClellan on 2/23/13.
//  Copyright (c) 2013 Richard McClellan. All rights reserved.
//

#import "GMapsHttpClient.h"
#import "AFJSONRequestOperation.h"

static NSString * const kGMapsAPIBaseURLString = @"http://maps.googleapis.com/maps/api/directions/json";

@implementation GMapsHttpClient

+ (id)sharedClient {
    static dispatch_once_t once;
    static id sharedClient;
    dispatch_once(&once, ^{
        sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kGMapsAPIBaseURLString]];
    });
    return sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    if((self = [super initWithBaseURL:url])) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }
    return self;
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters {
    NSMutableURLRequest *request = [super requestWithMethod:method path:path parameters:parameters];
    NSString *newURLString = [request.URL.absoluteString stringByReplacingOccurrencesOfString:@"json/" withString:@"json"];
    [request setURL:[NSURL URLWithString:newURLString]];
    return request;
    
}

@end
