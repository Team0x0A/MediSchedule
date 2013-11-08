/*
 *  PillManager.m
 *  MediSchedule
 *
 *  Header file for each PillManager class
 *  Creates each individual pill to be stored in the PillManager class
 *
 *  Programmers:
 *  Ishan Bhutani
 *  Ning Chai
 *  Zheren Lu
 *  Justin Wang
 *
 *  Copyright (c) 2013 Team 0x0A
 */

#import "PillManager.h"
#import "Pill.h"

@interface PillManager ()
{
    NSMutableArray* pills;
}

@end

@implementation PillManager

- (id)init
{
    self = [super init];
    NSLog(@"Initializing PillManager...");
    if (self)
    {
        if (!pills)
        {
            pills = [[NSMutableArray alloc] init];
            [self loadFile:[self fileLocation]];
            NSLog(@"PillManager Initialized!");
        }
    }
    return self;
}

- (void) addPillWithName: (NSString*) newName
               WithImage: (UIImage*) newImage
            WithDoctorId: (int) newDoctorId
               WithNotes: (NSString*) newNotes
{
    //NSLog(@"Adding %@ : {%@, %d, %@}", newName, [newImage description], newDoctorId, newNotes);
    int pillId = 0;
    int maxId = 0;
    for(Pill* i in pills) 
    {
        if([i pillId] > maxId) maxId = [i pillId];
        pillId = maxId + 1;
    }
    
    Pill* newPill = [[Pill alloc] initWithId:pillId WithName:newName WithImage:newImage WithDoctorId:newDoctorId WithNotes:newNotes];
    
    [pills addObject:newPill];
    [self saveToFile:[self fileLocation]];
}

- (NSString *) description
{
    NSMutableString* output = [[NSMutableString alloc] init];
    [output appendString: @"\n"];
    
    for(Pill* i in pills)
    {
        [output appendString:[i description]];
        [output appendString: @"\n"];
    }
    
    return (NSString*)output;
}

- (int) getIndexOfPillWithId: (int) pillId
{
    if([pills count] > 0)
    {
        for (Pill* i in pills)
        {
            if ([i pillId] == pillId) return [pills indexOfObject:i];
        }
    }
    return -1; // pills is empty (error)
}

- (void) deletePillWithId: (int) pillId
{
    [pills removeObjectAtIndex:[self getIndexOfPillWithId:pillId]];
    [self saveToFile:[self fileLocation]];
}

- (void) deletePillWithIndex: (int)index
{
    [pills removeObjectAtIndex:index];
    [self saveToFile:[self fileLocation]];
}

// Modifiers:
- (void) setNameTo: (NSString*) newName
                OfPillId: (int) pillId
{
    Pill *pill = [pills objectAtIndex:[self getIndexOfPillWithId:pillId]];
    [pill setName:newName];
    [self saveToFile:[self fileLocation]];
}

- (void) setImageTo: (UIImage*) newImage
                 OfPillId: (int) pillId
{
    Pill *pill = [pills objectAtIndex:[self getIndexOfPillWithId:pillId]];
    [pill setImage:newImage];
    [self saveToFile:[self fileLocation]];
}

- (void) setDoctorIdTo: (int) newDoctorID
                    OfPillId: (int) pillId
{
    Pill *pill = [pills objectAtIndex:[self getIndexOfPillWithId:pillId]];
    [pill setDoctorId:newDoctorID];
    [self saveToFile:[self fileLocation]];
}

- (void) setNotesTo: (NSString*) newNotes
                 OfPillId: (int) pillId
{
    Pill *pill = [pills objectAtIndex:[self getIndexOfPillWithId:pillId]];
    [pill setNotes:newNotes];
    [self saveToFile:[self fileLocation]];
}


// Accessors:
- (int) numOfPills
{
    return  [pills count];
}

- (NSArray*) listOfPillsIds
{
    NSMutableArray *pillIds = [[NSMutableArray alloc] init];
    for (Pill* i in pills)
    {
        [pillIds addObject: [[NSNumber alloc] initWithInt:[i pillId]]];
    }
    return pillIds;
}

- (NSString*) nameOfPillWithId: (int) pillId
{
    Pill *pill = [pills objectAtIndex:[self getIndexOfPillWithId:pillId]];
    return [pill name];
}

- (UIImage*) imageOfPillWithId: (int) pillId
{
    Pill *pill = [pills objectAtIndex:[self getIndexOfPillWithId:pillId]];
    return [pill image];
}

- (int) doctorIdOfPillWithId: (int) pillId
{
    Pill *pill = [pills objectAtIndex:[self getIndexOfPillWithId:pillId]];
    return [pill doctorId];
}

- (NSString *) notesOfPillWithId:(int) pillId
{
    Pill *pill = [pills objectAtIndex:[self getIndexOfPillWithId:pillId]];
    return [pill notes];
}

//Returns the location of the file saved on the device
- (NSURL *) fileLocation
{
    NSURL *documentDirectory = [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory
                                                                      inDomains:NSUserDomainMask] lastObject];
    return [NSURL URLWithString:@"PillManager"
                  relativeToURL:documentDirectory];
}

- (void) saveToFile: (NSURL*) fileLocation
{
    NSData* dataToSave = [NSKeyedArchiver archivedDataWithRootObject:pills];
    [dataToSave writeToURL:fileLocation atomically:YES];
}

- (void) loadFile: (NSURL*) fileLocation
{
    NSData *savedReminders = [[NSData alloc] initWithContentsOfURL:fileLocation];
    if (savedReminders)
    {
        pills = [[NSMutableArray alloc] initWithArray: [NSKeyedUnarchiver unarchiveObjectWithData:savedReminders]];
    }
}

- (NSString*) nameOfPillWithIndex: (int) index
{
    Pill *pill = [pills objectAtIndex:index];
    return [pill name];
}

- (NSString *) notesOfPillWithIndex:(int) index
{
    Pill *pill = [pills objectAtIndex:index];
    return [pill notes];
}

@end
