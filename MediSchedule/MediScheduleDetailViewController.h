//
//  MediScheduleDetailViewController.h
//  MediSchedule
//
//  Created by Ishan Bhutani on 10/26/13.
//  Copyright (c) 2013 Ishan Bhutani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReminderManager.h"
#import "MediScheduleMasterViewController.h"

@interface MediScheduleDetailViewController : UIViewController

@property (strong, nonatomic) ReminderManager* detailItem;
@property (strong, nonatomic) MediScheduleMasterViewController* callBack;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
