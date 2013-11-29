/*
 *  Pill.m
 *  MediSchedule
 *
 *  Implementation file for Pill class
 *
 *  Programmers:
 *  Ishan Bhutani
 *  Ning Chai
 *  Zheren Lu
 *  Justin Wang
 *
 *  Copyright (c) 2013 Team 0x0A
 */

#import "Pill.h"
#import "GlobalVariables.h"

@interface Pill ()
{
    GlobalVariables *globalVariables;
    ReminderManager *reminderManager;
}
@end

@implementation Pill

@synthesize pillId;
@synthesize name;
@synthesize image;
@synthesize doctorId;
@synthesize notes;

-(id)initWithId:(int)newId
       WithName:(NSString *)newName
      WithImage:(UIImage *)newImage
   WithDoctorId:(int)newDoctorId
      WithNotes:(NSString *)newNotes
{
    self = [super init];
    if (self) {
        [self setPillId:newId];
        [self setName:newName];
        [self setImage:newImage];
        [self setDoctorId:newDoctorId];
        [self setNotes:newNotes];
        globalVariables = [GlobalVariables getInstance];
        reminderManager = globalVariables.reminderManager;
    }
    return self;
}

- (void) dealloc
{
    [reminderManager deleteReminderWithPillId:self.pillId];
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        [self setPillId:[aDecoder decodeIntegerForKey:@"pillid"]];
        [self setName:[aDecoder decodeObjectForKey:@"name"]];
        [self setImage:[aDecoder decodeObjectForKey:@"image"]];
        [self setDoctorId:[aDecoder decodeIntegerForKey:@"doctorid"]];
        [self setNotes:[aDecoder decodeObjectForKey:@"notes"]];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:self.pillId forKey:@"pillid"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.image forKey:@"image"];
    [aCoder encodeInt:self.doctorId forKey:@"doctorid"];
    [aCoder encodeObject:self.notes forKey:@"notes"];
}

- (NSString *)description
{
    return [[NSString alloc] initWithFormat:@"%d, %@, %@, %d, %@", [self pillId], [self name], [self image], [self doctorId], [self notes]];
}
@end