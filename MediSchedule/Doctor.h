//
//  MediSchedule.h
//  MediSchedule
//
//  Created by Ning Chai on 10/30/13.
//  Copyright (c) 2013 Ishan Bhutani. All rights reserved.
//

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

@end
