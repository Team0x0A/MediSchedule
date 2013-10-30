/*
 *  ReminderManager.m
 *  MediSchedule
 *
 *  Implementation file for ReminderManager class
 *
 *  Programmers:
 *  Ishan Bhutani
 *  Ning Chai
 *  Zheren Lu
 *  Justin Wang
 *
 *  Copyright (c) 2013 Team 0x0A
 */

#import "ReminderManager.h"
#import "Reminder.h"
#import <CoreFoundation/CoreFoundation.h>

@interface ReminderManager (){
    NSMutableArray *reminders;
}
@end

@implementation ReminderManager

- (id)init
{
    self = [super init];
    if (self) {
        if (!reminders)
        {
            reminders = [[NSMutableArray alloc] init];
            reminders = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithContentsOfURL:[self fileLocation]]];
        }
    }
    return self;
}

- (NSString *) description
{
    NSMutableString* output = [[NSMutableString alloc] init];
    [output appendString: @"\n"];
    
    for(Reminder* i in reminders)
    {
        [output appendString:[i description]];
        [output appendString: @"\n"];
    }
    
    return (NSString*)output;
}

- (int) addReminderWithTime:(Time*)time
                  WithPillId:(int)pillId
                  WithDosage:(int)dosage
                   WithNotes:(NSString *)notes
{
    Reminder* newReminder = [[Reminder alloc] initWithTime:time
                                                WithPillId:pillId
                                                WithDosage:dosage
                                                 WithNotes:notes];
    [reminders addObject:newReminder];
    [reminders sortUsingFunction:timeSort context:nil];
    [self save];
    return [reminders indexOfObject:newReminder];
}

- (void)deleteReminderWith:(int)index
{
    [reminders removeObjectAtIndex:index];
    [reminders sortUsingFunction:timeSort context:nil];
    [self save];
}

// Modifiers:
- (void) setTimeTo:(Time*) newTime
                At:(int) index
{
    [[reminders objectAtIndex:index] setTime:newTime];
    [reminders sortUsingFunction:timeSort context:nil];
    [self save];
}

- (void) setPillIdTo:(int) newPillId
                  At:(int) index
{
    [[reminders objectAtIndex:index] setPillId:newPillId];
    [self save];
}

- (void) setDosageTo:(int) newDosage
                  At:(int) index
{
    [[reminders objectAtIndex:index] setDosage:newDosage];
    [self save];
}

- (void) setNotesTo:(NSString*) newNotes
                 At:(int) index
{
    [[reminders objectAtIndex:index] setNotes:newNotes];
    [self save];
}


// Accessors:
- (int) numOfReminders
{
    return [reminders count];
}

- (Time*) timeAt:(int)index
{
    return [[reminders objectAtIndex:index] time];
}

- (int) pillIdAt:(int)index
{
    return [[reminders objectAtIndex:index] pillId];
}

- (int) dosageAt:(int)index
{
    return [[reminders objectAtIndex:index] dosage];
}

- (NSString*) notesAt:(int)index
{
    return [[reminders objectAtIndex:index] notes];
}

// used by reminders array when calling sortUsingFunction.
// compares two reminders based on their time and returns: NSOrderedAscending, NSOrderedDescending or NSOrderedSame
// these values are used to sort the array into ascending order (smallest time at 0th index)
NSInteger timeSort(id reminder1, id reminder2, void *context)
{
    int v1 = [[reminder1 time] intValue];
    int v2 = [[reminder2 time] intValue];
    
    if (v1 < v2)
        return NSOrderedAscending;
    else if (v1 > v2)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}

//Returns the location of the file saved on the device
- (NSURL *) fileLocation
{
    NSURL *documentDirectory = [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory
                                                                      inDomains:NSUserDomainMask] lastObject];
    return [NSURL URLWithString:@"ReminderManager"
                  relativeToURL:documentDirectory];
}

//Saves the reminder manager into the appropriate file
- (void) save
{
    [reminders writeToURL:[self fileLocation] atomically:YES];
}

@end
