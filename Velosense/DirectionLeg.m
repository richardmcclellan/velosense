//
//  DirectionLeg.m
//  BTHandlebars
//
//  Created by Richard McClellan on 2/23/13.
//  Copyright (c) 2013 Richard McClellan. All rights reserved.
//

#import "DirectionLeg.h"

@implementation DirectionLeg

@synthesize distanceText;
@synthesize distanceValue;
@synthesize durationText;
@synthesize durationValue;
@synthesize startAddress;
@synthesize endAddress;
@synthesize startCoordinate;
@synthesize endCoordinate;
@synthesize steps;

- (id) initWithDictionary:(NSDictionary *)dictionary {
    if((self = [super init])) {
        distanceText = dictionary[@"distance"][@"text"];
        distanceValue = [dictionary[@"distance"][@"value"] doubleValue];
        durationText = dictionary[@"duration"][@"text"];
        durationValue = [dictionary[@"duration"][@"value"] doubleValue];
        startAddress = dictionary[@"start_address"];
        endAddress = dictionary[@"end_address"];
        startCoordinate = CLLocationCoordinate2DMake([dictionary[@"start_location"][@"lat"] doubleValue], [dictionary[@"start_location"][@"lng"] doubleValue]);
        endCoordinate = CLLocationCoordinate2DMake([dictionary[@"end_location"][@"lat"] doubleValue], [dictionary[@"end_location"][@"lng"] doubleValue]);
        steps = [NSMutableArray array];
        for(NSDictionary *stepDictionary in dictionary[@"steps"]) {
            [steps addObject:[[DirectionStep alloc] initWithDictionary:stepDictionary]];
        }
    }
    return self;
}

@end
