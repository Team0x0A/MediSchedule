/*
 *  CreatePillViewController.h
 *  MediSchedule
 *
 *  Header file for CreatePillViewController class
 *  Creates display for individual pills
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
#import "PillManagerViewController.h"

//***************************************************************************************
// Public Interface:
//***************************************************************************************
@interface CreatePillViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) PillManagerViewController* callBack;

@end
