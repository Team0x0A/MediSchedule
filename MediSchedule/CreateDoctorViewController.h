/*
 *  CreateDoctorViewController.h
 *  MediSchedule
 *
 *  Header file for CreateDoctorViewController class
 *  Creates display for individual doctors
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
#import "DoctorManagerViewController.h"

//***************************************************************************************
// Public Interface:
//***************************************************************************************
@interface CreateDoctorViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) DoctorManagerViewController* callBack;

@end
