//
//  DoctorManagerViewController.h
//  MediSchedule
//
//  Created by Justin Wang on 11/8/13.
//  Copyright (c) 2013 Team 0x0A. All rights reserved.
//

#import <UIKit/UIKit.h>


//***************************************************************************************
// Public Interface:
//***************************************************************************************
@interface DoctorManagerViewController : UITableViewController

// called by CreateDoctorViewController when creating a new doctor:
- (void) addDoctorWithName: (NSString*) newName
                WithNumber: (NSString*) newNumber
               WithAddress: (NSString*) newAddress
                 WithEmail: (NSString*) newEmail;

@end
