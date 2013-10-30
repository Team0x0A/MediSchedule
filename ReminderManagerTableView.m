//
//  ReminderManagerTableView.m
//  MediSchedule
//
//  Created by Justin Wang on 10/30/13.
//  Copyright (c) 2013 Ishan Bhutani. All rights reserved.
//

#import "ReminderManagerTableView.h"

@implementation ReminderManagerTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



/*
- (void)insertNewObject:(id)sender
{
    static int somecount = 0;
    
    
    int index = [myManager addReminderWithTime:[[Time alloc] initWithHour:rand()%24 WithMin:00 WithSec:0]
                                    WithPillId:52
                                    WithDosage:5000
                                     WithNotes:[[NSString alloc] initWithFormat:@"%d", somecount]
                 ];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    somecount++;
}
*/




// cellForRowAtIndexPath
// Returns the table cell at the specified index path.
// ****************************************
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ReminderCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    [[cell textLabel] setText:[[NSString alloc] initWithFormat:@"Pill: Default Pill"]]; //,[myManager notesAt:[indexPath item]]]];
    //[[cell detailTextLabel] setText:[[NSString alloc] initWithFormat:@"%@",[[myManager timeAt:[indexPath item]] description]]];
    return cell;
}






// numberOfSectionsInTableView:
// ****************************************
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}





// numberOfRowsInSections:
// ****************************************
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    //return [myManager numOfReminders];
    return 3;
}






// canEditRowAtIndexPath:
// ****************************************
- (BOOL)tableView:(UITableView *)tableView
canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}





// commitEditingStyle:
// ****************************************
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //[myManager deleteReminderWith:[indexPath item]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
