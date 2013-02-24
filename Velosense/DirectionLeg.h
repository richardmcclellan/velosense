//
//  DirectionLeg.h
//  BTHandlebars
//
//  Created by Richard McClellan on 2/23/13.
//  Copyright (c) 2013 Richard McClellan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DirectionStep.h"

@interface DirectionLeg : NSObject {
    NSString *distanceText;
    CLLocationDistance distanceValue;
    NSString *durationText;
    NSTimeInterval durationValue;
    NSString *startAddress;
    NSString *endAddress;
    CLLocationCoordinate2D startCoordinate;
    CLLocationCoordinate2D endCoordinate;
    NSMutableArray *steps;
}

@property (nonatomic, strong) NSString *distanceText;
@property (nonatomic, assign) CLLocationDistance distanceValue;
@property (nonatomic, strong) NSString *durationText;
@property (nonatomic, assign) NSTimeInterval durationValue;
@property (nonatomic, strong) NSString *startAddress;
@property (nonatomic, strong) NSString *endAddress;
@property (nonatomic, assign) CLLocationCoordinate2D startCoordinate;
@property (nonatomic, assign) CLLocationCoordinate2D endCoordinate;
@property (nonatomic, strong) NSMutableArray *steps;


- (id) initWithDictionary:(NSDictionary *)dictionary;



@end
