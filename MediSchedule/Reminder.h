//
//  Reminder.h
//  Reminder
//
//  Created by Justin Wang on 10/24/13.
//  Copyright (c) 2013 Justin Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Time.h"

@interface Reminder : NSObject

@property Time* time;
@property int pillId;
@property int dosage;
@property NSString *notes;

- (id)initWithTime:(Time *)time
        WithPillId:(int)pillId
        WithDosage:(int)dosage
         WithNotes:(NSString *)notes;

@end
