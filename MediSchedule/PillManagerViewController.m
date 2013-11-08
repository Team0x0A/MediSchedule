//
//  PillManagerViewController.m
//  MediSchedule
//
//  Created by Justin Wang on 2013-11-07.
//  Copyright (c) 2013 Team 0x0A. All rights reserved.
//

#import "PillManagerViewController.h"
#import "PillManager.h"
#import "CreatePillViewController.h"

//***************************************************************************************
// Private Interface:
//***************************************************************************************
@interface PillManagerViewController ()
{
    PillManager *myManager; // Pill Manager to be used for entire application
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addPillButton;

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
    
    // Tests:
    [self addPillWithName:@"Crack Cocaine!" WithImage:NULL WithDoctorId:0 WithNotes:@"3/4 of a page or roughly 2500 words"];
    
    // Setup the addPillButton:
    [_addPillButton setTarget:self];
    [_addPillButton setAction:@selector(addPillButtonTapped:)];
}






// addPillButtonTapped:
// This method is called by addPillButton
// ****************************************
- (void)addPillButtonTapped:(id)sender
{
    [self performSegueWithIdentifier:@"PillManagerToCreatePillSegue" sender:self];
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
    [self addCellAt:0];
}





// prepareForSegue:
// gets called before seguing to another view controller
// ****************************************
- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    UIViewController* destination = [segue destinationViewController];
    
    if([[destination title] isEqual: @"CreatePill"])
    {
        
        CreatePillViewController *detailController = segue.destinationViewController;
        detailController.callBack = self;
    }
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
    return [myManager numOfPills];
}




// cellForRowAtIndexPath:
// Returns the table cell at the specified index path.
// ****************************************
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PillCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    [[cell textLabel] setText:[[NSString alloc] initWithFormat:[myManager nameOfPillWithId:[indexPath item]]]];
    [[cell detailTextLabel] setText:[[NSString alloc] initWithFormat:[myManager notesOfPillWithId:[indexPath item]]]];
    
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
        [myManager deletePillWithId:[indexPath item]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


// testPillManager:
// ****************************************
- (void) testPillManager
{
    [myManager addPillWithName:@"Tylenol"
                         WithImage:[[UIImage alloc] init]
                      WithDoctorId:1
                         WithNotes:@"First pill added"];
    
    [myManager addPillWithName:@"Advil"
                         WithImage:[[UIImage alloc] init]
                      WithDoctorId:1
                         WithNotes:@"Second pill added"];
    
    [myManager addPillWithName:@"Benelyn"
                         WithImage:[[UIImage alloc] init]
                      WithDoctorId:1
                         WithNotes:@"Third pill added"];
    
    [myManager addPillWithName:@"Some more drugs"
                         WithImage:[[UIImage alloc] init]
                      WithDoctorId:2
                         WithNotes:@"Fourth pill added"];
    
    [myManager addPillWithName:@"Even more drugs"
                         WithImage:[[UIImage alloc] init]
                      WithDoctorId:2
                         WithNotes:@"Fifth pill added"];
    
    NSLog(@"PillMangager description: %@",[myManager description]);
    
    NSLog(@"PillMangager pillids: %@",[[myManager listOfPillsIds] description]);
    
    assert([myManager numOfPills] == 5);
    
    [myManager deletePillWithId:0];
    assert([myManager numOfPills] == 4);
    
    NSLog(@"PillMangager description: %@",[myManager description]);
    
    assert([[myManager nameOfPillWithId:1] isEqualToString:@"Advil"]);
    
}
@end
