//
//  CreateDoctorViewController.h
//  MediSchedule
//
//  Created by Justin Wang on 11/8/13.
//  Copyright (c) 2013 Team 0x0A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoctorManagerViewController.h"

//***************************************************************************************
// Public Interface:
//***************************************************************************************
@interface CreateDoctorViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) DoctorManagerViewController* callBack;

@end
