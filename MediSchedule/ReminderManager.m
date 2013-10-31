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

- (void)deleteReminderWith:(int)index
{
    [reminders removeObjectAtIndex:index];
    [reminders sortUsingFunction:timeSort context:nil];
    [self saveToFile:[self fileLocation]];
}

// Modifiers:
- (void) setTimeTo:(Time*) newTime
                At:(int) index
{
    [[reminders objectAtIndex:index] setTime:newTime];
    [reminders sortUsingFunction:timeSort context:nil];
    [self saveToFile:[self fileLocation]];
}

- (void) setPillIdTo:(int) newPillId
                  At:(int) index
{
    [[reminders objectAtIndex:index] setPillId:newPillId];
    [self saveToFile:[self fileLocation]];
}

- (void) setDosageTo:(int) newDosage
                  At:(int) index
{
    [[reminders objectAtIndex:index] setDosage:newDosage];
    [self saveToFile:[self fileLocation]];
}

- (void) setNotesTo:(NSString*) newNotes
                 At:(int) index
{
    [[reminders objectAtIndex:index] setNotes:newNotes];
    [self saveToFile:[self fileLocation]];
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
- (void) saveToFile: (NSURL*) fileLocation
{
    //Create arrays with list of times, pillids, dosages and notes to create a property list using nsdictionary
    NSMutableArray *listOfTimes = [[NSMutableArray alloc] init];
    NSMutableArray *listOfPillIds = [[NSMutableArray alloc] init];
    NSMutableArray *listOfDosages = [[NSMutableArray alloc] init];
    NSMutableArray *listOfNotes = [[NSMutableArray alloc] init];
    
    for (Reminder* i in reminders)
    {
        [listOfTimes addObject:[[NSString alloc] initWithFormat:@"%d:%d", [[i time] hour], [[i time] min]]];
        [listOfPillIds addObject:[[NSString alloc] initWithFormat:@"%d", [i pillId]]];
        [listOfDosages addObject:[[NSString alloc] initWithFormat:@"%d", [i dosage]]];
        [listOfNotes addObject:[[NSString alloc] initWithFormat:@"%@", [i notes]]];
    }
    
    //Create NSDictionary; valid property list
    NSDictionary *writeToFile = [[NSDictionary alloc] initWithObjects:@[listOfTimes, listOfPillIds, listOfDosages, listOfNotes] forKeys:@[@"time", @"pillId", @"dosage", @"notes"]];
    
    //NSDictionary is written to file
    if([writeToFile writeToURL:fileLocation atomically:YES])
    {
        NSLog(@"Writing to file successful!");
    }
    else
    {
        NSLog(@"Writing to file failed.");
    }
}

// Initialize reminder list from file
- (void) loadFile: (NSURL*) fileLocation
{
    // New reminders are created from the values of these arrays. Note: a single reminder is a row
    // in the matrix [listOfTimes, listOfPillIds, listOfDosages, listOfNotes]
    // where listOfTimes, listOfPillIds, listOfDosages, listOfNotes are valid property lists
    // stored in the NSDictionary readFromFile
    NSDictionary *readFromFile = [[NSDictionary alloc] initWithContentsOfURL:fileLocation];
    NSMutableArray *listOfTimes = [[NSMutableArray alloc] initWithArray:[readFromFile objectForKey:@"time"]];
    NSMutableArray *listOfPillIds = [[NSMutableArray alloc] initWithArray:[readFromFile objectForKey:@"pillId"]];
    NSMutableArray *listOfDosages = [[NSMutableArray alloc] initWithArray:[readFromFile objectForKey:@"dosage"]];
    NSMutableArray *listOfNotes = [[NSMutableArray alloc] initWithArray:[readFromFile objectForKey:@"notes"]];
    
    // Add each reminder into array of reminders
    for(int i = 0; i < [listOfTimes count]; i++)
    {
        NSLog(@"%@", [listOfTimes objectAtIndex:i]);
        [self addReminderWithTime: [[Time alloc] initWithString:[listOfTimes objectAtIndex:i]]
                       WithPillId: [[listOfPillIds objectAtIndex:i] integerValue]
                       WithDosage: [[listOfDosages objectAtIndex:i] integerValue]
                        WithNotes:[listOfNotes objectAtIndex:i]];
    }
}

@end
