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

// Modifiers:

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


// Accessors:

- (int) numOfPills;

- (NSArray*) listOfPillsIds;

- (NSString*) nameOfPillWithId: (int) pillId;

- (UIImage*) imageOfPillWithId: (int) pillId;

- (int) doctorIdOfPillWithId: (int) pillId;

- (NSString*) notesOfPillWithId:(int) pillId;

- (NSString*) nameOfPillWithIndex: (int) index;

- (NSString*) notesOfPillWithIndex:(int) index;

@end
