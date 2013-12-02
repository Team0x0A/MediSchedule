/*
 *  ReminderManager.h
 *  MediSchedule
 *  
 *  Header file for ReminderManager class
 *  Manages list of reminders: creates ability to add/remove reminders
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

@interface ReminderManager : NSObject

-(id)init;

-(int) addReminderWithTime:(NSDate*) time
                 WithPillId:(int) pillId
                 WithDosage:(int) dosage
                  WithNotes:(NSString *) notes;

- (void) deleteReminderAtIndex:(int)index;

- (void) deleteRemindersWithPillId: (int) pillId;

// Modifiers:
- (void) setTimeTo:(NSDate*) newTime
                AtIndex:(int) index;

- (void) setPillIdTo:(int) newPillId
                  AtIndex:(int) index;

- (void) setDosageTo:(int) newDosage
                  AtIndex:(int) index;

- (void) setNotesTo:(NSString*) newNotes
                 AtIndex:(int) index;

// Accessors:
- (int) numOfReminders;

- (NSDate*) timeAtIndex:(int)index;

- (int) pillIdAtIndex:(int)index;

- (int) dosageAtIndex:(int)index;

- (NSString*) notesAtIndex:(int)index;

@end
