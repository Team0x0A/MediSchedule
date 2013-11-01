//
//  MediSchedule.m
//  MediSchedule
//
//  Created by Ning Chai on 10/30/13.
//  Copyright (c) 2013 Ishan Bhutani. All rights reserved.
//

#import "Doctor.h"
@interface Doctor ()

@end

@implementation Doctor

@synthesize doctorId;
@synthesize name;
@synthesize phonenum;
@synthesize address;
@synthesize email;

-(id)initWithId:(int) newId
       WithName:(NSString*) newName
   WithPhonenum: (NSString*) newPhonenum
    WithAddress: (NSString*) newAddress
      WithEmail: (NSString*) newEmail;
{
    self = [super init];
    if (self){
        [self setDoctorId:newId];
        [self setName:newName];
        [self setPhonenum:newPhonenum];
        [self setAddress:newAddress];
        [self setEmail:newEmail];
    }
    return self;
}
- (NSString *)description{
    return [[NSString alloc] initWithFormat:@"%d, %@, %@, %@, %@", [self doctorId], [self name], [self phonenum], [self address], [self email]];
}
@end
