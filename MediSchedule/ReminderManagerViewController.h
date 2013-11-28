/*
 *  ReminderManagerViewController.h
 *  MediSchedule
 *
 *  Header file for ReminderManagerViewController class
 *  Inherits from UITableViewController
 *  Manages display for every reminder from ReminderManager
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
#import "Time.h"

//***************************************************************************************
// Public Interface:
//***************************************************************************************
@interface ReminderManagerViewController : UITableViewController

// called by CreateReminderViewController when creating new reminder:
-(void) addReminderWithTime:(NSDate*) time
                 WithPillId:(int) pillId
                 WithDosage:(int) dosage
                  WithNotes:(NSString *) notes;

@end
