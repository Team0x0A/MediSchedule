/*
 *  Pill.h
 *  MediSchedule
 *
 *  Header file for Pill class
 *  Manages list of reminders: creates ability to add/remove pills.
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

@interface Pill : NSObject <NSCoding>

@property int pillId;
@property NSString *name;
@property UIImage *image;
@property int doctorId;
@property NSString *notes;

-(id)initWithId:(int) newId
       WithName:(NSString*) newName
      WithImage: (UIImage*) newImage
   WithDoctorId: (int) newDoctorId
      WithNotes: (NSString*) newNotes;


@end
