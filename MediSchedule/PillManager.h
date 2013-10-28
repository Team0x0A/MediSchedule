/*
 *  PillManager.h
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

#import <Foundation/Foundation.h>

@interface PillManager : NSObject

- (void) addPillWithName: (NSString*) newName
               WithImage: (UIImage*) newImage
            WithDoctorId: (int) newDoctorId
               WithNotes: (NSString*) newNotes;

- (void) deletePill: (int) pillId;

- (int) getNumOfPills;

- (NSArray*) getListOfPillsIds;

- (NSString*) getPillNameOf: (int) pillId;

- (void) setPillNameTo: (NSString*) newName
                    Of: (int) pillId;

- (UIImage*) getPillImageOf: (int) pillId;

- (void) setPillImageTo: (UIImage*) newImage
                     Of: (int) pillId;

- (int) getDoctorIdOf: (int) pillId;

- (void) setDoctorIdOf: (int) pillId
                    To: (int) newDoctorID;

- (NSString *) getPillNotesOf:(int) pillId;

- (void) setPillNotesTo: (NSString*) newNotes
                     Of: (int) pillId;

@end
