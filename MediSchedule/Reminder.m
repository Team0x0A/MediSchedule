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
        
    }
    return self;
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
