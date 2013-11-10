/*
 *  CreateReminderViewController.h
 *  MediSchedule
 *
 *  Header file for ReminderViewController class
 *  Inherits from UIViewController
 *  Manages display for each individual reminder in the GUI
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
#import "ReminderManagerViewController.h"

//***************************************************************************************
// Public Interface:
//***************************************************************************************
@interface CreateReminderViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) ReminderManagerViewController* callBack;

@end
