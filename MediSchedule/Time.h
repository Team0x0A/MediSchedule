/*
 *  Time.h
 *  MediSchedule
 *
 *  Header file for Pill class
 *  Data structure for each time in a reminder
 *
 *  Programmers: 
 *  Ishan Bhutani
 *  Ning Chai
 *  Zheren Lu
 *  Justin Wang
 *  
 *  Copyright (c) 2013 Team 0x0A
 */

#import <Foundation/Foundation.h>

//NSCoding protocol allows the object to archive/unarchive itself when saving to files
@interface Time : NSObject <NSCoding>
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
