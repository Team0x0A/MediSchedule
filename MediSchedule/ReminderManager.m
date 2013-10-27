//
//  ReminderManager.m
//  MediSchedule
//
//  Created by Justin Wang on 10/24/13.
//  Copyright (c) 2013 Justin Wang. All rights reserved.
//

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
    return [reminders indexOfObject:newReminder];
}

- (void)deleteReminderWith:(int)index
{
    [reminders removeObjectAtIndex:index];
    [reminders sortUsingFunction:timeSort context:nil];
}

// Modifiers:
- (void) setTimeTo:(Time*) newTime
                At:(int) index
{
    [[reminders objectAtIndex:index] setTime:newTime];
    [reminders sortUsingFunction:timeSort context:nil];
}

- (void) setPillIdTo:(int) newPillId
                  At:(int) index
{
    [[reminders objectAtIndex:index] setPillId:newPillId];
}

- (void) setDosageTo:(int) newDosage
                  At:(int) index
{
    [[reminders objectAtIndex:index] setDosage:newDosage];
}

- (void) setNotesTo:(NSString*) newNotes
                 At:(int) index
{
    [[reminders objectAtIndex:index] setNotes:newNotes];
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

@end
