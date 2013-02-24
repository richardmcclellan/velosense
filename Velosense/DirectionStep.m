//
//  DirectionStep.m
//  BTHandlebars
//
//  Created by Richard McClellan on 2/23/13.
//  Copyright (c) 2013 Richard McClellan. All rights reserved.
//

#import "DirectionStep.h"

@implementation DirectionStep

@synthesize distanceText;
@synthesize distanceValue;
@synthesize durationText;
@synthesize durationValue;
@synthesize startCoordinate;
@synthesize endCoordinate;
@synthesize htmlInstructions;

- (id) initWithDictionary:(NSDictionary *)dictionary {
    if((self = [super init])) {
        distanceText = dictionary[@"distance"][@"text"];
        distanceValue = [dictionary[@"distance"][@"value"] doubleValue];
        durationText = dictionary[@"duration"][@"text"];
        durationValue = [dictionary[@"duration"][@"value"] doubleValue];
        startCoordinate = CLLocationCoordinate2DMake([dictionary[@"start_location"][@"lat"] doubleValue], [dictionary[@"start_location"][@"lng"] doubleValue]);
        endCoordinate = CLLocationCoordinate2DMake([dictionary[@"end_location"][@"lat"] doubleValue], [dictionary[@"end_location"][@"lng"] doubleValue]);
        htmlInstructions = dictionary[@"html_instructions"];
    }
    return self;
}

- (NSString *)textInstructions {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<(.*?)>" options:NSRegularExpressionCaseInsensitive error:NULL];
    
//    NSString *text = [htmlInstructions stringByReplacingOccurrencesOfString:@"<b>" withString:@""];
//    text = [text stringByReplacingOccurrencesOfString:@"</b>" withString:@""];
    
    return [regex stringByReplacingMatchesInString:htmlInstructions options:0 range:NSMakeRange(0, [htmlInstructions length]) withTemplate:@" "];
}

- (NSString *)directionString {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"/<b>(.*?)</b>/" options:NSRegularExpressionCaseInsensitive error:NULL];
    NSRange range = [regex rangeOfFirstMatchInString:htmlInstructions options:0 range:NSMakeRange(0, htmlInstructions.length)];
    if(range.location != NSNotFound) {
        return [htmlInstructions substringWithRange:range];
    }
    return nil;
}

- (BOOL) isLeft {
    NSRange range = [htmlInstructions rangeOfString:@"left"];
    return range.location != NSNotFound;
}

- (BOOL) isRight {
    NSRange range = [htmlInstructions rangeOfString:@"right"];
    return range.location != NSNotFound;}

@end
