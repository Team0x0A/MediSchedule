//
//  EditPillViewController.h
//  MediSchedule
//
//  Created by Ning Chai on 11/27/13.
//  Copyright (c) 2013 Team 0x0A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PillManager.h"
#import "PillManagerViewController.h"

@interface EditPillViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic)
    PillManagerViewController* callBack;
@property (strong, nonatomic) PillManager* pillManager;
@property int pillIndex;
@end
