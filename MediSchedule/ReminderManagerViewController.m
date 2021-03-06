/*
 *  ReminderManagerViewController.m
 *  MediSchedule
 *
 *  Implementation file for ReminderManagerViewController class
 *
 *  Programmers:
 *  Ishan Bhutani
 *  Ning Chai
 *  Zheren Lu
 *  Justin Wang
 *
 *  Copyright (c) 2013 Team 0x0A
 */

#import "ReminderManagerViewController.h"
#import "CreateReminderViewController.h"
#import "ReminderManager.h"
#import "Reminder.h"
#import "PillManager.h"
#import "GlobalVariables.h"
#import "EditReminderViewController.h"

//***************************************************************************************
// Private Interface:
//***************************************************************************************
@interface ReminderManagerViewController ()
{
    GlobalVariables *globalVariables;
    ReminderManager *reminderManager;// Reminder Manager to be used for entire application
    PillManager *pillManager;
    NSMutableArray *_objects;
    int indexOfCurrentlySelectedCell;
}
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addReminderButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *viewPillsButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *viewDoctorsButton;

-(void) testReminderManager;
@end




//***************************************************************************************
// Implementation:
//***************************************************************************************
@implementation ReminderManagerViewController


- (void)awakeFromNib
{
    [super awakeFromNib];
}

// viewDidLoad:
// gets called when the view manager is created
// ****************************************
- (void)viewDidLoad
{
    [super viewDidLoad];

    // The reminder manager is initialized the first time the application loads
    globalVariables = [GlobalVariables getInstance];
    reminderManager = globalVariables.reminderManager;
    pillManager = globalVariables.pillManager;
    
    
    // This calls some tests on the reminder manager
    // [self testReminderManager];
    
    // Setup the addReminderButton to call the addReminderButtonTapped method:
    [_addReminderButton setTarget:self];
    [_addReminderButton setAction:@selector(addReminderButtonTapped:)];
    
    // Setup the viewPillsButton to call the viewPillsButtonTapped method:
    [_viewPillsButton setTarget:self];
    [_viewPillsButton setAction:@selector(veiwPillsButtonTapped:)];
    
    // Setup the viewDoctorButton to call the viewDoctorButtonTapped method:
    [_viewDoctorsButton setTarget:self];
    [_viewDoctorsButton setAction:@selector(viewDoctorButtonTapped:)];
}






// addReminderButtonTapped:
// This method is called by addReminderButton
// ****************************************
- (void)addReminderButtonTapped:(id)sender
{
    [self performSegueWithIdentifier:@"ReminderManagerToCreateReminderSegue" sender:self];
}




// viewPillsButtonTapped:
// This method is called by viewPillsButton
// ****************************************
- (void)veiwPillsButtonTapped:(id)sender
{
    [self performSegueWithIdentifier:@"ReminderManagerToPillManagerSegue" sender:self];
}




// viewDoctorButtonTapped:
// This method is called by viewDoctorButton
// ****************************************
- (void)viewDoctorButtonTapped:(id)sender
{
    [self performSegueWithIdentifier:@"ReminderManagerToDoctorManagerSegue" sender:self];
}




// prepareForSegue:
// gets called before seguing to another view controller
// ****************************************
- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    UIViewController* destination = [segue destinationViewController];
    
    // Prepare to segue to the CreateReminder view controller:
    if([[destination title] isEqual: @"CreateReminder"])
    {
        CreateReminderViewController *detailController = segue.destinationViewController;
        detailController.callBack = self;
    }
    // Prepare to segue to the EditReminder view controller:
    else if ([[destination title] isEqual: @"EditReminder"])
    {
        EditReminderViewController *editReminderViewController = segue.destinationViewController;
        editReminderViewController.reminderManager = reminderManager;
        editReminderViewController.reminderIndex = indexOfCurrentlySelectedCell;
        editReminderViewController.callBack = self;
    }
}




// addReminderWithTime:
// called by CreateReminderViewController when creating new reminder
// ****************************************
-(void) addReminderWithTime:(NSDate*) time
                 WithPillId:(int) pillId
                 WithDosage:(int) dosage
                  WithNotes:(NSString *) notes
{
    int index;
    index = [reminderManager addReminderWithTime:time WithPillId:pillId WithDosage:dosage WithNotes:notes];
    [self addCellAt:index];
}



// testReminderManager:
// Note: This will delete all elements in myManager beforehand, so do not run if there is an instance saved that you need access to!
// ****************************************
- (void) testReminderManager
{
    while ([reminderManager numOfReminders] > 0)
    {
        [reminderManager deleteReminderAtIndex:0];
    }
}





// ************************************************************************************************************************
// Table Methods:
// ************************************************************************************************************************
#pragma mark - Table View



// addCellAt:
// ****************************************
- (void) addCellAt:(int)index
{
    // Convert the index to an indexPath into the table:
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    // Create a new cell at:
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    NSLog(@"addCellAt called...");
}




// cellForRowAtIndexPath
// Returns the table cell at the specified index path.
// ****************************************
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ReminderCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    [[cell textLabel] setText:[pillManager nameOfPillWithId:[reminderManager pillIdAtIndex:[indexPath item]]]];
    
    //[[cell textLabel] setText:@"blah"];
    NSString *localDate = [NSDateFormatter localizedStringFromDate: [reminderManager timeAtIndex:[indexPath item]]
                                                         dateStyle:NSDateFormatterNoStyle
                                                         timeStyle:NSDateFormatterShortStyle];
    [[cell detailTextLabel] setText:[[NSString alloc] initWithFormat:@"%@",localDate]];
    
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
    return [reminderManager numOfReminders];
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
        [reminderManager deleteReminderAtIndex:[indexPath item]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


// accessoryButtomTappedForRowWithIndexPath
// ****************************************
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    indexOfCurrentlySelectedCell = [indexPath item];
    [self performSegueWithIdentifier:@"ReminderManagerToEditReminderSegue" sender:self];
}

@end
