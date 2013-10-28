/*
 *  MediScheduleTests.m
 *  MediSchedule
 *
 *  Implementation file for MediScheduleTests class
 *
 *  Programmers:
 *  Ishan Bhutani
 *  Ning Chai
 *  Zheren Lu
 *  Justin Wang
 *
 *  Copyright (c) 2013 Team 0x0A
 */

#import "MediScheduleTests.h"
#import "ReminderManager.h"
#import "Time.h"

@implementation MediScheduleTests



- (void)setUp
{
    [super setUp];
    
    ReminderManager* testManager = [[ReminderManager alloc] init];
    
    // Add 10 reminders in order:
    for(int i = 0; i < 10; i++)
    {
        [testManager addReminderWithTime:[[Time alloc] initWithHour:i WithMin:i WithSec:i] WithPillId:i WithDosage:i WithNotes:@"Some Notes"];
    }
    
    // Test that the values were set correctly:
    for(int i = 0; i < 10; i++)
    {
        if( [[testManager timeAt:i] hour] != i
        ||  [[testManager timeAt:i] min] != i
        ||  [[testManager timeAt:i] sec] != i)
        {
            STFail(@"Reminder Manager Failed...");
        }
    }
         

    [testManager deleteReminderWith:0];
    [testManager deleteReminderWith:0];
    [testManager deleteReminderWith:0];
    [testManager deleteReminderWith:0];
}



- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}



- (void)testExample
{
    STFail(@"Unit tests are not implemented yet in MediScheduleTests");
}

@end
