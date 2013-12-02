/*
 *  EditReminderViewController.h
 *  MediSchedule
 *
 *  Header file for EditReminderViewController class
 *  Edits reminders
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
#import "ReminderManager.h"

//***************************************************************************************
// Public Interface:
//***************************************************************************************
@interface EditReminderViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) ReminderManagerViewController* callBack;
@property (strong, nonatomic) ReminderManager* reminderManager;
@property int reminderIndex;
@end
