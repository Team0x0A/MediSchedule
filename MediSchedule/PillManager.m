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

- (void) deletePill: (int) pillId
{
    [pills removeObjectAtIndex:[self getIndexOfPillAt:pillId]];
}

- (int) getNumOfPills
{
    return  [pills count];
}

- (NSArray*) getListOfPillsIds
{
    NSMutableArray *pillIds = [[NSMutableArray alloc] init];
    for (Pill* i in pills)
    {
        [pillIds addObject: [[NSNumber alloc] initWithInt:[i pillId]]];
    }
    return pillIds;
}

//FIX THIS
- (NSString*) getPillNameOf: (int) pillId
{
    if([pills count] > 0){
        for (Pill* i in pills) {
            if([i pillId] == pillId) return [i name];
        }
    }
    return NULL; //if there did not find
}

//FIX THIS
- (void) setPillNameTo: (NSString*) newName
                    Of: (int) pillId
{
    for (Pill* i in pills) {
        if([i pillId] == pillId){
            [i setName:newName];
        }
    }
    
}

//FIX THIS
- (UIImage*) getPillImageOf: (int) pillId
{
    for (Pill* i in pills) {
        if ([i pillId] == pillId) {
            return [[UIImage alloc] init];
        }
    }
    return NULL;//if there did not find
}

//FIX THIS
- (void) setPillImageTo: (UIImage*) newImage
                     Of: (int) pillId
{
    for (Pill* i in pills) {
        if ([i pillId] == pillId) {
            [i setImage:newImage];
        }
    }
    
}

//FIX THIS
- (int) getDoctorIdOf: (int) pillId
{
    for (Pill* i in pills) {
        if ([i pillId] == pillId) return [i doctorId];
                    
    }
    return -1;//if did not find
}

//FIX THIS
- (void) setDoctorIdOf: (int) pillId
                    To: (int) newDoctorID
{
    for (Pill* i in pills) {
        if ([i pillId] == pillId){
            [i setDoctorId:newDoctorID];
        }
    }
    
}

//FIX THIS
- (NSString *) getPillNotesOf:(int) pillId
{
    for (Pill* i in pills) {
        if ([i pillId] == pillId) return [i notes];
    }

    return NULL;//if there did not find
}

//FIX THIS
- (void) setPillNotesTo: (NSString*) newNotes
                     Of: (int) pillId
{
    for (Pill* i in pills) {
        if ([i pillId] == pillId){
            [i setNotes: newNotes];
        }
    }

    
}

@end
