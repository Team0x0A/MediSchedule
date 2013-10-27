//
//  Pill.m
//  MediSchedule
//
//  Created by Ishan Bhutani on 10/24/13.
//  Copyright (c) 2013 Justin Wang. All rights reserved.
//

#import "Pill.h"

@interface Pill ()

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
    }
    return self;
}
- (NSString *)description
{
    return [[NSString alloc] initWithFormat:@"%d, %@, %@, %d, %@", [self pillId], [self name], [self image], [self doctorId], [self notes]];
}
@end