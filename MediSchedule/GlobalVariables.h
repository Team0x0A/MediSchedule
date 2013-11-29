/*
 *  GlobalVariables.h
 *  MediSchedule
 *
 *  Header file for GlobalVariables class
 *  Manages all global data structures for application
 *
 *  Programmers:
 *  Ishan Bhutani
 *
 *  Copyright (c) 2013 Team 0x0A
 */

#import <Foundation/Foundation.h>

#import "DoctorManager.h"
#import "PillManager.h"
#import "ReminderManager.h"

@interface GlobalVariables : NSObject

@property DoctorManager *doctorManager;
@property PillManager *pillManager;
@property ReminderManager *reminderManager;

+ (GlobalVariables*) getInstance;

@end
