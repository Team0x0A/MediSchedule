//
//  MediSchedule.m
//  MediSchedule
//
//  Created by Ning Chai on 10/30/13.
//  Copyright (c) 2013 Ishan Bhutani. All rights reserved.
//

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

- (void) addDoctorWithName:(NSString *)newName
               WithPhonenum:(NSString *)newPhonenum
                WithAddress:(NSString *)newAddress
                  WithEmail:(NSString *)newEmail

{
    int doctorId = 0;
    int maxId = 0;
    for (Doctor* i in doctors) {
        if([i doctorId] > maxId) maxId = [i doctorId];
        doctorId = maxId + 1;
    }
    
    Doctor * newDoctor = [[Doctor alloc] initWithId:doctorId WithName:newName WithPhonenum:newPhonenum WithAddress:newAddress WithEmail:newAddress];
    
    [doctors addObject:newDoctor];
}

- (int)getIndexOfDoctorAt: (int) doctorId
{
    if ([doctors count] > 0 )
    {
        for (Doctor* i in doctors) return [doctors indexOfObject: i];
    }
    return -1; // doctors is empty (error)
}

- (void) deleteDoctor:(int)doctorId
{
    [doctors removeObjectAtIndex:[self getIndexOfDoctorAt:doctorId]];
}

- (int) getNumOfDoctors
{
    return [doctors count];
}

- (NSArray*)getListOfDoctorIds
{
    if([doctors count] > 0){
        NSArray* DOCTORID = [NSArray array];
        
        for(Doctor* i in doctors){
            DOCTORID = [DOCTORID arrayByAddingObject:@([i doctorId])];
        }
        return DOCTORID;
    }
    return 0; // fi there no Doctor
}

- (NSString*) getDoctorName:(int)doctorId
{
    if([doctors count] > 0){
        for(Doctor* i in doctors) return [i name];
    }
    return NULL; // if there di not find
}

- (void) setDoctorNameTo:(NSString *)newName
                      Of:(int)doctorId
{
    for(Doctor* i in doctors){
        if([i doctorId] == doctorId){
            [i setName:newName];
        }
    }
}

- (NSString *) getDoctorAddress:(int)doctorId
{
    if ([doctors count] > 0){
        for (Doctor* i in doctors){
            if([i doctorId] == doctorId) return [i address];
        }
    }
    return NULL; // if there did not find
}

- (void) setDoctorAddressTo:(NSString *)newAddress
                         Of:(int)doctorId
{
    for(Doctor* i in doctors){
        if ([i doctorId] == doctorId){
            [i setAddress:newAddress];
        }
    }
}

- (NSString *) getDoctorPhonenum:(int)doctorId
{
    if ([doctors count] > 0){
        for(Doctor* i in doctors) return [i phonenum];
    }
    return NULL; // if there are not find
}

-(void) setDoctorPhonenumOf:(int)doctorId
                         To:(NSString *)newPhonenum
                         
                         
{
    for(Doctor* i in doctors){
        if ([i doctorId] == doctorId){
            [i setPhonenum:newPhonenum];
        }
    }
}

-(NSString *) getDoctorEmail:(int)doctorId
{
    if ([doctors count] > 0){
        for (Doctor* i in doctors) return [i email];
    }
    return NULL; // if there are not find
}

-(void) setDoctorEmailTo:(NSString *)newEmail
                      Of:(int)doctorId
{
    for(Doctor* i in doctors){
        if ([i doctorId] == doctorId){
            [i setEmail:newEmail];
        }
    }
}


@end
