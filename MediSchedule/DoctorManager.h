///Users/nchai/Documents/MediSchedule/MediSchedule.xcodeproj
//  MediSchedule.h
//  MediSchedule
//
//  Created by Ning Chai on 10/30/13.
//  Copyright (c) 2013 Ishan Bhutani. All rights reserved.
//

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
