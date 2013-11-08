//
//  PillManagerViewController.m
//  MediSchedule
//
//  Created by Justin Wang on 2013-11-07.
//  Copyright (c) 2013 Team 0x0A. All rights reserved.
//

#import "PillManagerViewController.h"
#import "PillManager.h"

//***************************************************************************************
// Private Interface:
//***************************************************************************************
@interface PillManagerViewController ()
{
    PillManager *myManager; // Pill Manager to be used for entire application
}

@end



//***************************************************************************************
// Implementation:
//***************************************************************************************
@implementation PillManagerViewController


// viewDidLoad:
// gets called when the view manager is created
// ****************************************
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!myManager)
    {
        myManager = [[PillManager alloc] init];
    }
    
    [self addPillWithName:@"Crack Cocaine!" WithImage:NULL WithDoctorId:0 WithNotes:@"3/4 of a page or roughly 2500 words"];
}



// addPill:
// called by CreateReminderViewController when creating new reminder
// ****************************************
- (void) addPillWithName: (NSString*) newName
               WithImage: (UIImage*) newImage
            WithDoctorId: (int) newDoctorId
               WithNotes: (NSString*) newNotes;
{
    [myManager addPillWithName:newName WithImage:newImage WithDoctorId:newDoctorId WithNotes:newNotes];
    [self addCellAt:1];
}


// ************************************************************************************************************************
// Table Methods:
// ************************************************************************************************************************

// addCellAt:
// ****************************************
- (void) addCellAt:(int)index
{
    // Convert the index to an indexPath into the table:
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    // Create a new cell at:
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    NSLog(@"PillManagerViewController: addCellAt called...");
}





// numberOfSectionsInTableView:
// ****************************************
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}




// numberOfRowsInSection:
// ****************************************
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [myManager getNumOfPills];
}




// cellForRowAtIndexPath:
// Returns the table cell at the specified index path.
// ****************************************
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PillCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //[[cell textLabel] setText:[[NSString alloc] initWithFormat:[myManager getPillNameOf:[indexPath item]]]];
    [[cell textLabel] setText:[[NSString alloc] initWithFormat:@"A Pill"]];
    //,[myManager notesAt:[indexPath item]]]];
    //[[cell detailTextLabel] setText:[[NSString alloc] initWithFormat:@"%@",[[myManager timeAt:[indexPath item]] description]]];
    
    return cell;
}





// canEditRowAtIndexPath:
// ****************************************
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}





// commitEditingStyle:
// ****************************************
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [myManager deletePill:[indexPath item]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
@end
