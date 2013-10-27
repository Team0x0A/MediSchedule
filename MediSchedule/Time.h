//
//  Time.h
//  MediSchedule
//
//  Created by Justin Wang on 10/24/13.
//  Copyright (c) 2013 Justin Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Time : NSObject
- initWithHour:(int) hour
       WithMin:(int) min
       WithSec:(int) sec;

- (NSString *)description;
- (int) hour;
- (int) min;
- (int) sec;
- (int) intValue;
@end
