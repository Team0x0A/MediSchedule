/*
 *  GlobalVariables.m
 *  MediSchedule
 *
 *  Implementation file for GlobalVariables class
 *
 *  Programmers:
 *  Ishan Bhutani
 *
 *  Copyright (c) 2013 Team 0x0A
 */

#import "GlobalVariables.h"

@implementation GlobalVariables

@synthesize doctorManager;
@synthesize pillManager;
@synthesize reminderManager;

- (id)init
{
    self = [super init];
    if (self) {
        self.doctorManager = [[DoctorManager alloc] init];
        self.pillManager = [[PillManager alloc] init];
        self.reminderManager = [[ReminderManager alloc] init];
    }
    return self;
}

+ (GlobalVariables *) getInstance
{
    static GlobalVariables *instance = nil;
    
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance = [GlobalVariables new];
        }
    }
    return instance;
}

@end
