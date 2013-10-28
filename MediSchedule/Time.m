/*
 *  Time.m
 *  MediSchedule
 *
 *  Implementation file for Time class
 *
 *  Programmers:
 *  Ishan Bhutani
 *  Ning Chai
 *  Zheren Lu
 *  Justin Wang
 *
 *  Copyright (c) 2013 Team 0x0A
 */

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

-initWithString:(NSString*) inputString
{
    self = [super init];
    if (self)
    {
        NSArray *tokens = [inputString componentsSeparatedByString:@":"];
        NSString *token0 = [tokens objectAtIndex:0];
        NSString *token1 = [tokens objectAtIndex:1];
        int setHour = [token0 intValue];
        int setMin = [token1 intValue];

        
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setHour:setHour];
        [comps setMinute:setMin];
        [comps setSecond:0];
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
    [output appendString: [[NSString alloc] initWithFormat:@"%d", [self sec]]];
    
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
