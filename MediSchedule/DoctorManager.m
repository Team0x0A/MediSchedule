/*
 *  DoctorManager.m
 *  MediSchedule
 *
 *  Implementation file for DoctorManager class
 *
 *  Programmers:
 *  Ishan Bhutani
 *  Ning Chai
 *  Zheren Lu
 *  Justin Wang
 *
 *  Copyright (c) 2013 Team 0x0A
 */

#import "DoctorManager.h"
#import "Doctor.h"

@interface DoctorManager ()
{
    NSMutableArray* doctors;
}
@end

@implementation DoctorManager
                
- (id) init
{
    self = [super init];
    if (self)
    {
        if (!doctors)
        {
            doctors = [[NSMutableArray alloc] init];
        }
    }
    return self;

}

- (void) addDoctorWithName: (NSString*) newName
                WithNumber: (NSString*) newNumber
               WithAddress: (NSString*) newAddress
                 WithEmail: (NSString*) newEmail

{
    int doctorId = 0;
    int maxId = 0;
    for (Doctor* i in doctors) {
        if([i doctorId] > maxId) maxId = [i doctorId];
        doctorId = maxId + 1;
    }
    
    Doctor *newDoctor = [[Doctor alloc] initWithId:doctorId WithName:newName WithNumber:newNumber WithAddress:newAddress WithEmail:newEmail];
    
    [doctors addObject:newDoctor];
}

- (NSString *) description
{
    NSMutableString* output = [[NSMutableString alloc] init];
    [output appendString: @"\n"];
    
    for(Doctor* i in doctors)
    {
        [output appendString:[i description]];
        [output appendString: @"\n"];
    }
    
    return (NSString*)output;
}

- (int)getIndexOfDoctorWithId: (int) doctorId
{
    if([doctors count] > 0)
    {
        for (Doctor* i in doctors)
        {
            if ([i doctorId] == doctorId) return [doctors indexOfObject:i];
        }
    }
    return -1; // pills is empty (error)
}

//Returns the location of the file saved on the device
- (NSURL *) fileLocation
{
    NSURL *documentDirectory = [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory
                                                                      inDomains:NSUserDomainMask] lastObject];
    return [NSURL URLWithString:@"DoctorManager"
                  relativeToURL:documentDirectory];
}

- (void) saveToFile: (NSURL*) fileLocation
{
    NSData* dataToSave = [NSKeyedArchiver archivedDataWithRootObject:doctors];
    [dataToSave writeToURL:fileLocation atomically:YES];
}

- (void) loadFile: (NSURL*) fileLocation
{
    NSData *savedReminders = [[NSData alloc] initWithContentsOfURL:fileLocation];
    if (savedReminders)
    {
        doctors = [[NSMutableArray alloc] initWithArray: [NSKeyedUnarchiver unarchiveObjectWithData:savedReminders]];
    }
}

//Modifiers:

- (void) deleteDoctorWithId:(int) doctorId
{
    [doctors removeObjectAtIndex:[self getIndexOfDoctorWithId:doctorId]];
    //[self saveToFile:[self fileLocation]];
}

- (void) deleteDoctorWithIndex:(int) index
{
    [doctors removeObjectAtIndex:index];
}



- (void) setNameTo: (NSString*) newName
        OfDoctorId: (int) doctorId
{
    Doctor *doctor = [doctors objectAtIndex:[self getIndexOfDoctorWithId:doctorId]];
    [doctor setName:newName];
}

- (void) setAddressTo: (NSString*) newAddress
           OfDoctorId: (int) doctorId
{
    Doctor *doctor = [doctors objectAtIndex:[self getIndexOfDoctorWithId:doctorId]];
    [doctor setAddress:newAddress];
    //[self saveToFile:[self fileLocation]];
}

- (void) setNumberTo: (NSString *) newNumber
          OfDoctorId: (int) doctorId
{
    Doctor *doctor = [doctors objectAtIndex:[self getIndexOfDoctorWithId:doctorId]];
    [doctor setNumber:newNumber];
    //[self saveToFile:[self fileLocation]];
}

- (void) setEmailTo: (NSString*) newEmail
         OfDoctorId: (int) doctorId
{
    Doctor *doctor = [doctors objectAtIndex:[self getIndexOfDoctorWithId:doctorId]];
    [doctor setEmail:newEmail];
     //[self saveToFile:[self fileLocation]];
}

//Accessors:

- (int) numOfDoctors
{
    return [doctors count];
}

- (NSArray*) listOfDoctorIds
{
    NSMutableArray *doctorIds = [[NSMutableArray alloc] init];
    for (Doctor* i in doctors)
    {
        [doctorIds addObject: [[NSNumber alloc] initWithInt:[i doctorId]]];
    }
    return doctorIds;
}

- (NSString*) nameOfDoctorWithId: (int) doctorId
{
    Doctor *doctor = [doctors objectAtIndex:[self getIndexOfDoctorWithId:doctorId]];
    return [doctor name];
}

- (NSString*) addressOfDoctorWithId: (int) doctorId
{
    Doctor *doctor = [doctors objectAtIndex:[self getIndexOfDoctorWithId:doctorId]];
    return [doctor address];
}

- (NSString*) numberOfDoctorWithId: (int) doctorId
{
    Doctor *doctor = [doctors objectAtIndex:[self getIndexOfDoctorWithId:doctorId]];
    return [doctor number];
}

- (NSString *) emailOfDoctorWithId:(int) doctorId
{
    Doctor *doctor = [doctors objectAtIndex:[self getIndexOfDoctorWithId:doctorId]];
    return [doctor email];
}

- (NSString*) nameOfDoctorWithIndex: (int) index
{
    Doctor *doctor = [doctors objectAtIndex:index];
    return [doctor name];
}

- (NSString*) addressOfDoctorWithIndex: (int) index
{
    Doctor *doctor = [doctors objectAtIndex:index];
    return [doctor address];
}

- (NSString*) numberOfDoctorWithIndex: (int) index
{
    Doctor *doctor = [doctors objectAtIndex:index];
    return [doctor number];
}

- (NSString *) emailOfDoctorWithIndex:(int) index
{
    Doctor *doctor = [doctors objectAtIndex:index];
    return [doctor email];
}

@end
