/*
 *  Time.h
 *  MediSchedule
 *
 *  Header file for Pill class
 *  Data structure for each time in a reminder
 *
 *  Copyright (c) 2013 Team 0x0A
 */

#import <Foundation/Foundation.h>

@interface Time : NSObject
- initWithHour:(int) hour
       WithMin:(int) min
       WithSec:(int) sec;

-initWithString:(NSString*) inputString;

- (NSString *)description;
- (int) hour;
- (int) min;
- (int) sec;
- (int) intValue;
@end
