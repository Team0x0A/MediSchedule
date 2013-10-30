/*
 *  ReminderManagerViewController.h
 *  MediSchedule
 *
 *  Header file for ReminderManagerViewController class
 *  Inherits from UITableViewController
 *  Manages display for every reminders from ReminderViewController
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
@interface ReminderManagerViewController : UITableViewController

- (void) addCellAt:(int)index;
@end
