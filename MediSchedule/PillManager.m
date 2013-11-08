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

- (int) getIndexOfPillAt: (int) pillId
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
    [pills removeObjectAtIndex:[self getIndexOfPillAt:pillId]];
}


// Modifiers:
- (void) setNameTo: (NSString*) newName
                OfPillId: (int) pillId
{
    Pill *pill = [pills objectAtIndex:[self getIndexOfPillAt:pillId]];
    [pill setName:newName];
}

- (void) setImageTo: (UIImage*) newImage
                 OfPillId: (int) pillId
{
    Pill *pill = [pills objectAtIndex:[self getIndexOfPillAt:pillId]];
    [pill setImage:newImage];
}

- (void) setDoctorIdTo: (int) newDoctorID
                    OfPillId: (int) pillId
{
    Pill *pill = [pills objectAtIndex:[self getIndexOfPillAt:pillId]];
    [pill setDoctorId:newDoctorID];
}

- (void) setNotesTo: (NSString*) newNotes
                 OfPillId: (int) pillId
{
    Pill *pill = [pills objectAtIndex:[self getIndexOfPillAt:pillId]];
    [pill setNotes:newNotes];
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
    Pill *pill = [pills objectAtIndex:[self getIndexOfPillAt:pillId]];
    return [pill name];
}

- (UIImage*) imageOfPillWithId: (int) pillId
{
    Pill *pill = [pills objectAtIndex:[self getIndexOfPillAt:pillId]];
    return [pill image];
}

- (int) doctorIdOfPillWithId: (int) pillId
{
    Pill *pill = [pills objectAtIndex:[self getIndexOfPillAt:pillId]];
    return [pill doctorId];
}

- (NSString *) notesOfPillWithId:(int) pillId
{
    Pill *pill = [pills objectAtIndex:[self getIndexOfPillAt:pillId]];
    return [pill notes];
}

@end
