//
//  DirectionStep.h
//  BTHandlebars
//
//  Created by Richard McClellan on 2/23/13.
//  Copyright (c) 2013 Richard McClellan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DirectionStep : NSObject {
    NSString *distanceText;
    CLLocationDistance distanceValue;
    NSString *durationText;
    NSTimeInterval durationValue;
    CLLocationCoordinate2D startCoordinate;
    CLLocationCoordinate2D endCoordinate;
    NSString *htmlInstructions;
}

@property (nonatomic, strong) NSString *distanceText;
@property (nonatomic, assign) CLLocationDistance distanceValue;
@property (nonatomic, strong) NSString *durationText;
@property (nonatomic, assign) NSTimeInterval durationValue;
@property (nonatomic, assign) CLLocationCoordinate2D startCoordinate;
@property (nonatomic, assign) CLLocationCoordinate2D endCoordinate;
@property (nonatomic, strong) NSString *htmlInstructions;

- (id) initWithDictionary:(NSDictionary *)dictionary;
- (NSString *)textInstructions;
- (BOOL) isLeft;
- (BOOL) isRight;

@end
