//
//  Pill.h
//  MediSchedule
//
//  Created by Ishan Bhutani on 10/24/13.
//  Copyright (c) 2013 Justin Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pill : NSObject

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
