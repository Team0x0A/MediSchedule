/*
 *  DoctorManager.h
 *  MediSchedule
 *
 *  Header file for DoctorManager class
 *  Manages list of doctors: creates ability to add/remove doctors
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

@interface DoctorManager : NSObject

- (void) addDoctorWithName: (NSString*) newName
              WithNumber: (NSString*) newNumber
               WithAddress: (NSString*) newAddress
                 WithEmail: (NSString*) newEmail;

- (NSString *) description;

//Modifiers:

- (void) deleteDoctorWithId:(int) doctorId;


- (void) setNameTo: (NSString*) newName
       OfDoctorId: (int) doctorId;

- (void) setAddressTo: (NSString*) newAddress
           OfDoctorId: (int) doctorId;

- (void) setNumberTo: (NSString *) newNumber
          OfDoctorId: (int) doctorId;

- (void) setEmailTo: (NSString*) newEmail
         OfDoctorId: (int) doctorId;


//Accessors:

- (int) numOfDoctors;

- (NSArray*) listOfDoctorIds;

- (NSString*) nameOfDoctorWithId: (int) doctorId;

- (NSString*) addressOfDoctorWithId: (int) doctorId;

- (NSString*) numberOfDoctorWithId: (int) doctorId;

- (NSString *) emailOfDoctorWithId:(int) doctorId;

- (NSString*) nameOfDoctorWithIndex: (int) index;

- (NSString*) addressOfDoctorWithIndex: (int) index;

- (NSString*) numberOfDoctorWithIndex: (int) index;

- (NSString *) emailOfDoctorWithIndex:(int) index;

@end
