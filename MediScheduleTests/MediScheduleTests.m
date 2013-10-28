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
    

}



- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}



- (void)testExample
{
    ReminderManager* testManager = [[ReminderManager alloc] init];
    
    // Add 10 reminders in order:
    for(int i = 0; i < 10; i++)
    {
        [testManager addReminderWithTime:[[Time alloc] initWithHour:i WithMin:i WithSec:i] WithPillId:i WithDosage:i WithNotes:@"Some Notes"];
    }
    
    if([testManager numOfReminders] != 10)
    {
        STFail(@"Added 10 reminders but numOfReminders was not set correctly...");
    }
    
    // Test that the values were set correctly:
    for(int i = 0; i < 10; i++)
    {
        if( [[testManager timeAt:i] hour] != i
           ||  [[testManager timeAt:i] min] != i
           ||  [[testManager timeAt:i] sec] != i)
        {
            STFail(@"Time was not set correctly when adding new reminder...");
        }
        
        if( [testManager pillIdAt:i] != i)
        {
            STFail(@"pillId was not set correctly when adding new reminder...");
        }
        
        if( [testManager dosageAt:i] != i)
        {
            STFail(@"dosage was not set correctly when adding new reminder...");
        }
    }
    
    
    [testManager deleteReminderWith:0];
    [testManager deleteReminderWith:0];
    [testManager deleteReminderWith:0];
    [testManager deleteReminderWith:0];
}

@end
