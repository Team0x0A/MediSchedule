/*
 *  Reminder.m
 *  MediSchedule
 *
 *  Implementation file for Reminder class
 *
 *  Programmers:
 *  Ishan Bhutani
 *  Ning Chai
 *  Zheren Lu
 *  Justin Wang
 *
 *  Copyright (c) 2013 Team 0x0A
 */

#import "Reminder.h"
#import "GlobalVariables.h"
#import "PillManager.h"
@interface Reminder ()
{
    PillManager *pillManager;
    GlobalVariables *globalVariables;
    UILocalNotification *notification;
}

@end

@implementation Reminder

@synthesize time = _time;
@synthesize pillId;
@synthesize dosage;
@synthesize notes;

-(id)initWithTime:(NSDate *)newTime
       WithPillId:(int)newPillId
       WithDosage:(int)newDosage
        WithNotes:(NSString *)newNotes
{
    self = [super init];
    if (self)
    {
        globalVariables = [GlobalVariables getInstance];
        pillManager = globalVariables.pillManager;
        [self setTime:newTime];
        [self setPillId:newPillId];
        [self setDosage:newDosage];
        if (newNotes)
        {
            [self setNotes:newNotes];
        }
        else
        {
            [self setNotes:@""];
        }
        notification = [[UILocalNotification alloc] init];
        [self initializeNotification:notification];
    }
    return self;
}

- (void) initializeNotification:(UILocalNotification *) newNotification
{
    NSLog(@"initializing notification");
    newNotification.fireDate = self.time;
    newNotification.timeZone = [NSTimeZone localTimeZone];
    newNotification.repeatInterval = NSDayCalendarUnit;
    newNotification.alertBody = [[NSString alloc] initWithFormat:@"Take %dmg of %@", self.dosage, [pillManager nameOfPillWithId:self.pillId]];
    newNotification.alertAction = @"View";
    newNotification.soundName = UILocalNotificationDefaultSoundName;
    NSDictionary *infoDict = [NSDictionary dictionaryWithObjects:@[[[NSNumber alloc] initWithInt:[self pillId]], [[NSNumber alloc] initWithInt:[self dosage]], [self notes] ] forKeys:@[@"pillId", @"dosage", @"notes"]];
    newNotification.userInfo = infoDict;
    newNotification.applicationIconBadgeNumber = 1;
    [[UIApplication sharedApplication] scheduleLocalNotification:newNotification];
}

- (void) dealloc
{
    if (notification) [[UIApplication sharedApplication] cancelLocalNotification:notification];
}

- (void) setTime:(NSDate *)time
{
    if (notification) notification.fireDate = time;
    _time = time;
}

- (NSDate *) time
{
    return _time;
}

// Initialize Reminder object with unarchived data from aDecoder
- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        [self setTime:[aDecoder decodeObjectForKey:@"time"]];
        [self setPillId:[aDecoder decodeIntegerForKey:@"pillid"]];
        [self setDosage:[aDecoder decodeIntegerForKey:@"dosage"]];
        [self setNotes:[aDecoder decodeObjectForKey:@"notes"]];
    }
    return self;
}

// Writes archived variable instances to aCoder
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.time forKey:@"time"];
    [aCoder encodeInt:pillId forKey:@"pillid"];
    [aCoder encodeInt:dosage forKey:@"dosage"];
    [aCoder encodeObject:self.notes forKey:@"notes"];
}

- (NSString *)description
{
    return [[NSString alloc] initWithFormat:@"%@, %d, %d, %@", [self time], [self pillId], [self dosage], [self notes]];
}


@end
