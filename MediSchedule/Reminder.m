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

@interface Reminder ()
{
    UILocalNotification *notification;
}

@end

@implementation Reminder

@synthesize time;
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
        [self setTime:newTime];
        [self setPillId:newPillId];
        [self setDosage:newDosage];
        [self setNotes:newNotes];
        //notification = [[UILocalNotification alloc] init];
        //[self initializeNotification:notification];
    }
    return self;
}

- (void) initializeNotification:(UILocalNotification *) newNotification
{
    NSLog(@"initializing notification");
    newNotification.fireDate = time;
    newNotification.timeZone = [NSTimeZone localTimeZone];
    newNotification.repeatInterval = NSDayCalendarUnit;
    newNotification.alertBody = @"Take your medication now!";
    newNotification.alertAction = @"View";
    newNotification.soundName = UILocalNotificationDefaultSoundName;
    NSDictionary *infoDict = [NSDictionary dictionaryWithObjects:@[[[NSNumber alloc] initWithInt:[self pillId]], [[NSNumber alloc] initWithInt:[self dosage]], [self notes] ] forKeys:@[@"pillId", @"dosage", @"notes"]];
    newNotification.userInfo = infoDict;
    newNotification.applicationIconBadgeNumber = 1;
    [[UIApplication sharedApplication] scheduleLocalNotification:newNotification];
}

- (void) dealloc
{
    //[[UIApplication sharedApplication] cancelLocalNotification:notification];
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
