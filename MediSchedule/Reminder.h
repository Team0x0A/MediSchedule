/*
 *  Reminder.h
 *  MediSchedule
 *
 *  Header file for Reminder class
 *  Creates each individual reminder to be stored in the ReminderManager class
 *
 *  Copyright (c) 2013 Team 0x0A
 */

#import <Foundation/Foundation.h>
#import "Time.h"

@interface Reminder : NSObject

@property Time* time;
@property int pillId;
@property int dosage;
@property NSString *notes;

- (id)initWithTime:(Time *)time
        WithPillId:(int)pillId
        WithDosage:(int)dosage
         WithNotes:(NSString *)notes;

@end
