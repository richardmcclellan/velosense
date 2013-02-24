//
//  GMapsHttpClient.h
//  BTHandlebars
//
//  Created by Richard McClellan on 2/23/13.
//  Copyright (c) 2013 Richard McClellan. All rights reserved.
//

#import "AFHTTPClient.h"

@interface GMapsHttpClient : AFHTTPClient {
    
}

+ (id)sharedClient;

@end
