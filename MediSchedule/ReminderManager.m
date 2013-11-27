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
            NSLog(@"Initializing reminder manager...");
            reminders = [[NSMutableArray alloc] init];
            [self loadFile:[self fileLocation]];
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
    [self saveToFile:[self fileLocation]];
    return [reminders indexOfObject:newReminder];
}

- (void)deleteReminderAtIndex:(int)index
{
    [reminders removeObjectAtIndex:index];
    [reminders sortUsingFunction:timeSort context:nil];
    [self saveToFile:[self fileLocation]];
}

- (void) deleteReminderWithId: (int) pillId
{/*
    Reminder *delete;
    for (Reminder *i in reminders)
    {
        //if ([i pillId] == pillId) deleteReminderAtIndex
    }*/
}

// Modifiers:
- (void) setTimeTo:(Time*) newTime
                AtIndex:(int) index
{
    [[reminders objectAtIndex:index] setTime:newTime];
    [reminders sortUsingFunction:timeSort context:nil];
    [self saveToFile:[self fileLocation]];
}

- (void) setPillIdTo:(int) newPillId
                  AtIndex:(int) index
{
    [[reminders objectAtIndex:index] setPillId:newPillId];
    [self saveToFile:[self fileLocation]];
}

- (void) setDosageTo:(int) newDosage
                  AtIndex:(int) index
{
    [[reminders objectAtIndex:index] setDosage:newDosage];
    [self saveToFile:[self fileLocation]];
}

- (void) setNotesTo:(NSString*) newNotes
                 AtIndex:(int) index
{
    [[reminders objectAtIndex:index] setNotes:newNotes];
    [self saveToFile:[self fileLocation]];
}


// Accessors:
- (int) numOfReminders
{
    return [reminders count];
}

- (Time*) timeAtIndex:(int)index
{
    return [[reminders objectAtIndex:index] time];
}

- (int) pillIdAtIndex:(int)index
{
    return [[reminders objectAtIndex:index] pillId];
}

- (int) dosageAtIndex:(int)index
{
    return [[reminders objectAtIndex:index] dosage];
}

- (NSString*) notesAtIndex:(int)index
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
- (void) saveToFile: (NSURL*) fileLocation
{
    // Archive reminders and store in dataToSave, dataToSave can then write itself to the file
    NSData* dataToSave = [NSKeyedArchiver archivedDataWithRootObject:reminders];
    [dataToSave writeToURL:fileLocation atomically:YES];
}

// Initialize reminder list from file
- (void) loadFile: (NSURL*) fileLocation
{
    NSData *savedReminders = [[NSData alloc] initWithContentsOfURL:fileLocation]; //Get data from file and initialize NSData object
    if (savedReminders)//If the file was not empty, unarchive data and re-initialize reminders
    {
        reminders = [[NSMutableArray alloc] initWithArray: [NSKeyedUnarchiver unarchiveObjectWithData:savedReminders]];
    }
}

@end
