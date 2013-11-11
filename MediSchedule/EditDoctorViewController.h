/*
 *  EditDoctorViewController.h
 *  MediSchedule
 *
 *  Header file for EditDoctorViewController class
 *  Edit display for individual doctors
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
#import "DoctorManager.h"
#import "DoctorManagerViewController.h"

//***************************************************************************************
// Public Interface:
//***************************************************************************************
@interface EditDoctorViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) DoctorManagerViewController* callBack;
@property (strong, nonatomic) DoctorManager* doctorManager;
@property int doctorIndex;

@end
