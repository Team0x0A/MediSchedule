//
//  Reminder.m
//  Reminder
//
//  Created by Justin Wang on 10/24/13.
//  Copyright (c) 2013 Justin Wang. All rights reserved.
//

#import "Reminder.h"

@interface Reminder ()

@end

@implementation Reminder

@synthesize time;
@synthesize pillId;
@synthesize dosage;
@synthesize notes;

-(id)initWithTime:(Time *)newTime
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

- (NSString *)description
{
    return [[NSString alloc] initWithFormat:@"%@, %d, %d, %@", [self time], [self pillId], [self dosage], [self notes]];
}


@end
