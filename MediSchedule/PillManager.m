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
    if (self)
    {
        if (!pills)
        {
            pills = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

- (void) addPillWithName: (NSString*) newName
               WithImage: (UIImage*) newImage
            WithDoctorId: (int) newDoctorId
               WithNotes: (NSString*) newNotes
{
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

//Not implemented
- (NSArray*) getListOfPillsIds
{
    return @[];
}

//Not implemented
- (NSString*) getPillNameOf: (int) pillId
{
    return @"";
}

//Not implemented
- (void) setPillNameTo: (NSString*) newName
                    Of: (int) pillId
{
    
}

//Not implemented
- (UIImage*) getPillImageOf: (int) pillId
{
    return [[UIImage alloc] init];
}

//Not implemented
- (void) setPillImageTo: (UIImage*) newImage
                     Of: (int) pillId
{
    
}

//Not implemented
- (int) getDoctorIdOf: (int) pillId
{
    return 0;
}

//Not implemented
- (void) setDoctorIdOf: (int) pillId
                    To: (int) newDoctorID
{
    
}

//Not implemented
- (NSString *) getPillNotesOf:(int) pillId
{
    return @"";
}

//Not implemented
- (void) setPillNotesTo: (NSString*) newNotes
                     Of: (int) pillId
{
    
}

@end
