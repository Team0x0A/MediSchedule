//
//  Time.m
//  MediSchedule
//
//  Created by Justin Wang on 10/24/13.
//  Copyright (c) 2013 Justin Wang. All rights reserved.
//

#import "Time.h"

@interface Time()
{
    NSDate* date;
}
@end

@implementation Time

- initWithHour:(int) setHour
       WithMin:(int) setMin
       WithSec:(int) setSec
{
    self = [super init];
    if (self)
    {
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setHour:setHour];
        [comps setMinute:setMin];
        [comps setSecond:setSec];
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        date = [gregorian dateFromComponents:comps];
    }
    
    return self;
}

- (NSString *)description
{
    NSMutableString* output = [[NSMutableString alloc] init];
    
    [output appendString: [[NSString alloc] initWithFormat:@"%d", [self hour]]];
    [output appendString: @":"];
    [output appendString: [[NSString alloc] initWithFormat:@"%d", [self min]]];
    [output appendString: @":"];
    [output appendString: [[NSString alloc] initWithFormat:@"%d", [self hour]]];
    
    return (NSString*)output;
}

- (int) hour
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSHourCalendarUnit fromDate:date];
    
    return [components hour];
}

- (int) min
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSMinuteCalendarUnit fromDate:date];
    
    return [components minute];
}

- (int) sec
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSSecondCalendarUnit fromDate:date];
    
    return [components second];
}

- (int) intValue
{
    return [self hour] * 60 * 60 + [self min] * 60 + [self sec];
}



@end
