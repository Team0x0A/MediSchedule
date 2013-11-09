/*
 *  PillManagerViewController.h
 *  MediSchedule
 *
 *  Header file for PillManagerViewController class
 *  Inherits from UITableViewController
 *  Manages display for every pill from PillManager
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
@interface PillManagerViewController : UITableViewController
- (void) addPillWithName: (NSString*) newName
               WithImage: (UIImage*) newImage
            WithDoctorId: (int) newDoctorId
               WithNotes: (NSString*) newNotes;
@end
