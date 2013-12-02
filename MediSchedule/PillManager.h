/*
 *  PillManager.h
 *  MediSchedule
 *
 *  Header file for PillManager class
 *  Manages list of pills: creates ability to add/remove pills
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

- (NSString *) description;

// Modifiers (by ID):

- (void) removeDoctorIdsOfPillWithId: (int) pillId;

- (void) deletePillWithId: (int) pillId;

- (void) deletePillWithIndex: (int)index;

- (void) setNameTo: (NSString*) newName
          OfPillId: (int) pillId;

- (void) setImageTo: (UIImage*) newImage
           OfPillId: (int) pillId;

- (void) setDoctorIdTo: (int) newDoctorID
              OfPillId: (int) pillId;

- (void) setNotesTo: (NSString*) newNotes
           OfPillId: (int) pillId;


// Modifiers (by index):
// ****************************************


- (void) setNameTo: (NSString*) newName OfPillWithIndex: (int) index;
- (void) setImageTo: (UIImage*) newImage OfPillWithIndex: (int) index;
- (void) setDoctorIdTo: (int) newDoctorID OfPillWithIndex: (int) index;
- (void) setNotesTo: (NSString*) newNotes OfPillWithIndex: (int) index;


// Accessors:

- (int) getIdOfPillWithIndex: (int) index;

- (int) numOfPills;

- (NSArray*) listOfPillIds;

- (NSString*) nameOfPillWithId: (int) pillId;

- (UIImage*) imageOfPillWithId: (int) pillId;

- (int) doctorIdOfPillWithId: (int) pillId;

- (NSString*) notesOfPillWithId:(int) pillId;

- (NSString*) nameOfPillWithIndex: (int) index;

- (NSString*) notesOfPillWithIndex:(int) index;

- (UIImage*) imageOfPillWithIndex:(int)index;

@end
