/*
 *  Reminder.h
 *  MediSchedule
 *
 *  Header file for Reminder class
 *  Creates each individual reminder to be stored in the ReminderManager class
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
#import "Time.h"

//NSCoding protocol allows the object to archive/unarchive itself when saving to files
@interface Reminder : NSObject <NSCoding>

@property NSDate* time;
@property int pillId;
@property int dosage;
@property NSString *notes;

- (id)initWithTime:(NSDate *)time
        WithPillId:(int)pillId
        WithDosage:(int)dosage
         WithNotes:(NSString *)notes;

@end
