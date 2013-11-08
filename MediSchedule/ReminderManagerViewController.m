/*
 *  ReminderManagerViewController.h
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


//***************************************************************************************
// Private Interface:
//***************************************************************************************
@interface ReminderManagerViewController ()
{
    ReminderManager *myManager;// Reminder Manager to be used for entire application
    NSMutableArray *_objects;
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
    if (!myManager)
    {
        myManager = [[ReminderManager alloc] init];
    }
    
    // This calls some tests on the reminder manager
    [self testReminderManager];
    
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
    
    if([[destination title] isEqual: @"CreateReminder"])
    {
        
        CreateReminderViewController *detailController = segue.destinationViewController;
        detailController.callBack = self;
    }
}




// addReminderWithTime:
// called by CreateReminderViewController when creating new reminder
// ****************************************
-(void) addReminderWithTime:(Time*) time
                 WithPillId:(int) pillId
                 WithDosage:(int) dosage
                  WithNotes:(NSString *) notes
{
    int index;
    index = [myManager addReminderWithTime:time WithPillId:pillId WithDosage:dosage WithNotes:notes];
    [self addCellAt:index];
}



// testReminderManager:
// ****************************************
- (void) testReminderManager
{
    /*
    [self addReminderWithTime:[[Time alloc] initWithString:@"6:00"] WithPillId:0 WithDosage:0 WithNotes:@"Was added 1st"];
    [self addReminderWithTime:[[Time alloc] initWithString:@"12:00"] WithPillId:0 WithDosage:0 WithNotes:@"Was added 2nd"];
    [self addReminderWithTime:[[Time alloc] initWithString:@"3:20"] WithPillId:0 WithDosage:0 WithNotes:@"Was added 3rd"];*/
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
    
    [[cell textLabel] setText:[[NSString alloc] initWithFormat:@"Pill: Default Pill"]];
    [[cell detailTextLabel] setText:[[NSString alloc] initWithFormat:@"%@",[[myManager timeAtIndex:[indexPath item]] description]]];
    
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
    return [myManager numOfReminders];
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
        [myManager deleteReminderAtIndex:[indexPath item]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
