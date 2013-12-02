/*
 *  EditPillViewController.h
 *  MediSchedule
 *
 *  Header file for EditPillViewController class
 *  Creates display for editing individual pills
 *
 *  Programmers:
 *  Ishan Bhutani
 *  Ning Chai
 *
 *  Copyright (c) 2013 Team 0x0A
 */

#import <UIKit/UIKit.h>
#import "PillManager.h"
#import "PillManagerViewController.h"

@interface EditPillViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) PillManagerViewController* callBack;
@property (strong, nonatomic) PillManager* pillManager;
@property int pillIndex;
@end
