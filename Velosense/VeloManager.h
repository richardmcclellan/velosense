//
//  VeloManager.h
//  BTHandlebars
//
//  Created by Richard McClellan on 2/23/13.
//  Copyright (c) 2013 Richard McClellan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VeloManager : NSObject <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    CLLocation *location;
}

+ (id)sharedManager;
- (NSString *) currentLocationString;

@end
