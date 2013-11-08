/*
 *  Doctor.h
 *  MediSchedule
 *
 *  Header file for Doctor class
 *  Contains internal data structure for each doctor
 *
 *  Programmers:
 *  Ishan Bhutani
 *  Ning Chai
 *  Zheren Lu
 *  Justin Wang
 *
 *  Copyright (c) 2013 Team 0x0A
 */

#import <Foundation/Foundation.h>

@interface Doctor : NSObject

@property int doctorId;
@property NSString *name;
@property NSString *phonenum;
@property NSString *address;
@property NSString *email;


-(id)initWithId:(int) newId
       WithName:(NSString*) newName
   WithPhonenum: (NSString*) newPhonenum
    WithAddress: (NSString*) newAddress
      WithEmail: (NSString*) newEmail;

- (NSString *)description;

@end
