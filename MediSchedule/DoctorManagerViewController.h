/*
 *  DoctorManagerViewController.h
 *  MediSchedule
 *
 *  Header file for DoctorManagerViewController class
 *  Inherits from UITableViewController
 *  Manages display for every doctor from DoctorManager
 *
 *  Programmers:
 *  Ishan Bhutani
 *  Ning Chai
 *  Zheren Lu
 *  Justin Wang
 *
 *  Copyright (c) 2013 Team 0x0A
 */

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

