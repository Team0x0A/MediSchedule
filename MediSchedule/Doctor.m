/*
 *  Doctor.m
 *  MediSchedule
 *
 *  Implementation file for Doctor class
 *
 *  Programmers:
 *  Ishan Bhutani
 *  Ning Chai
 *  Zheren Lu
 *  Justin Wang
 *
 *  Copyright (c) 2013 Team 0x0A
 */

#import "Doctor.h"
@interface Doctor ()

@end

@implementation Doctor

@synthesize doctorId;
@synthesize name;
@synthesize number;
@synthesize address;
@synthesize email;

-(id)initWithId:(int) newId
       WithName:(NSString*) newName
   WithNumber: (NSString*) newNumber
    WithAddress: (NSString*) newAddress
      WithEmail: (NSString*) newEmail;
{
    self = [super init];
    if (self){
        [self setDoctorId:newId];
        [self setName:newName];
        [self setNumber:newNumber];
        [self setAddress:newAddress];
        [self setEmail:newEmail];
    }
    return self;
}
- (NSString *)description
{
    return [[NSString alloc] initWithFormat:@"%d, %@, %@, %@, %@", [self doctorId], [self name], [self number], [self address], [self email]];
}
@end
