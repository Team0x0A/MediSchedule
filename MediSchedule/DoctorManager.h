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
               WithPhonenum: (NSString*) newPhonenum
            WithAddress: (NSString*) newAddress
               WithEmail: (NSString*) newEmail;



- (void) deleteDoctor: (int) doctorId;

- (int) getNumOfDoctors;

- (NSArray*) getListOfDoctorIds;

- (NSString*) getDoctorName: (int) doctorId;

- (void) setDoctorNameTo: (NSString*) newName
                    Of: (int) doctorId;

- (NSString*) getDoctorAddress: (int) doctorId;

- (void) setDoctorAddressTo: (NSString*) newAddress
                      Of: (int) doctorId;

- (NSString*) getDoctorPhonenum: (int) doctorId;

- (void) setDoctorPhonenumOf: (int) doctorId
                    To: (NSString *) newPhonenum;

- (NSString *) getDoctorEmail:(int) doctorId;

- (void) setDoctorEmailTo: (NSString*) newEmail
                     Of: (int) doctorId;

@end
