/*
 *  ReminderManager.h
 *  MediSchedule
 *  
 *  Header file for ReminderManager class
 *  Allows the user interface to create and delete reminders.
 *
 *  Created by: Team 0x0A
 */

#import <Foundation/Foundation.h>
#import "Time.h"

@interface ReminderManager : NSObject

-(id)init;

-(int) addReminderWithTime:(Time*) time
                 WithPillId:(int) pillId
                 WithDosage:(int) dosage
                  WithNotes:(NSString *) notes;

- (void) deleteReminderWith:(int)index;

// Modifiers:
- (void) setTimeTo:(Time*) newTime
                At:(int) index;

- (void) setPillIdTo:(int) newPillId
                  At:(int) index;

- (void) setDosageTo:(int) newDosage
                  At:(int) index;

- (void) setNotesTo:(NSString*) newNotes
                 At:(int) index;

// Accessors:
- (int) numOfReminders;

- (Time*) timeAt:(int)index;

- (int) pillIdAt:(int)index;

- (int) dosageAt:(int)index;

- (NSString*) notesAt:(int)index;

@end
