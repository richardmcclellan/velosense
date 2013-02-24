//
//  VeloManager.m
//  BTHandlebars
//
//  Created by Richard McClellan on 2/23/13.
//  Copyright (c) 2013 Richard McClellan. All rights reserved.
//

#import "VeloManager.h"

@implementation VeloManager

+ (id)sharedManager {
    static dispatch_once_t once;
    static id sharedManager;
    dispatch_once(&once, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (id) init {
    if((self = [super init])) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = 100;
        location = [[CLLocation alloc] initWithLatitude:37.28671 longitude:-122.06784];
    }
    return self;
}

- (void) startUpdatingLocation {
    [locationManager startUpdatingLocation];
}

- (NSString *) currentLocationString {
    return [NSString stringWithFormat:@"%f,%f", location.coordinate.latitude, location.coordinate.longitude];
}

#pragma mark -
#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    location = newLocation;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"locationManager did fail with error: %@", [error localizedDescription]);
}


@end
