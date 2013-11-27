/*
 *  PillManagerViewController.m
 *  MediSchedule
 *
 *  Implementation file for PillManagerViewController class
 *
 *  Programmers:
 *  Ishan Bhutani
 *  Ning Chai
 *  Zheren Lu
 *  Justin Wang
 *
 *  Copyright (c) 2013 Team 0x0A
 */

#import "PillManagerViewController.h"
#import "PillManager.h"
#import "CreatePillViewController.h"
#import "ReminderManager.h"

//***************************************************************************************
// Private Interface:
//***************************************************************************************
@interface PillManagerViewController ()
{
    PillManager *myManager; // Pill Manager to be used for entire application
    ReminderManager *listOfReminders;
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
    
    if (!listOfReminders)
    {
        listOfReminders = [[ReminderManager alloc] init];
    }
    
     //Uncomment to perform tests:
    //[self testPillManager];
    
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
// called by CreatePillViewController when creating new pill
// ****************************************
- (void) addPillWithName: (NSString*) newName
               WithImage: (UIImage*) newImage
            WithDoctorId: (int) newDoctorId
               WithNotes: (NSString*) newNotes;
{
    [myManager addPillWithName:newName WithImage:newImage WithDoctorId:newDoctorId WithNotes:newNotes];
    [self addCellAt:[myManager numOfPills] - 1];
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
    
    [[cell textLabel] setText:[[NSString alloc] initWithFormat:@"%@",[myManager nameOfPillWithIndex:[indexPath item]]]];
    [[cell detailTextLabel] setText:[[NSString alloc] initWithFormat:@"%@",[myManager notesOfPillWithIndex:[indexPath item]]]];
    
    return cell;
}





// canEditRowAtIndexPath:
// ****************************************
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}





// commitEditingStyle:
// ****************************************
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //[listOfReminders deleteReminderWithId:[myManager getIdOfPillWithIndex:[indexPath item]]];
        [myManager deletePillWithIndex:[indexPath item]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


// testPillManager:
// Note: This will delete all elements in myManager beforehand, so do not run if there is an instance saved that you need access to!
// ****************************************
- (void) testPillManager
{
    while ([myManager numOfPills] > 0)
    {
        [myManager deletePillWithIndex:0];
    }
    
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
    
    NSLog(@"PillMangager pillids: %@",[[myManager listOfPillIds] description]);
    
    assert([myManager numOfPills] == 5);
    
    [myManager deletePillWithId:0];
    assert([myManager numOfPills] == 4);
    
    NSLog(@"PillMangager description: %@",[myManager description]);
    
    assert([[myManager nameOfPillWithId:1] isEqualToString:@"Advil"]);
    NSLog(@"PillManager test succeeded!");
}
@end
