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


// ************************************************************************************************************************
// View Controller Methods:
// ************************************************************************************************************************
- (void)awakeFromNib
{
    [super awakeFromNib];
}




// viewDidLoad:
// gets called when the view manager is created?
// ****************************************
- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.table setDelegate:self];
    //[self.table setDataSource:self];
    NSLog(@"viewDidLoad called...");
    // The reminder manager is initialized the first time the application loads
    // Note: there is not file system support as of now. Each time the application is loaded, myManager is re-initialized
    if (!myManager)
    {
        myManager = [[ReminderManager alloc] init];
    }
    
    // This calls some tests on the reminder manager
    [self testReminderManager];
    
    
    /*
    // Create a button to add reminders to the table:
    UIBarButtonItem *addReminderButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd // This is the plus sign icon
                                                                               target: self
                                                                               action: @selector(addReminderButtonTapped:)]; // This is linking the button to method addTapped
    self.navigationItem.rightBarButtonItem = addReminderButton;
    */
    
    [_addReminderButton setTarget:self];
    [_addReminderButton setAction:@selector(addReminderButtonTapped:)];
}






// addReminderButtonTapped:
// This method is called by addButton
// ****************************************
- (void)addReminderButtonTapped:(id)sender
{
    
    [self performSegueWithIdentifier:@"ReminderManagerToCreateReminderSegue" sender:self];
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
        detailController.detailItem = myManager;
        detailController.callBack = self;
    }
}






- (void) testReminderManager
{
    
    int index;
    index = [myManager addReminderWithTime:[[Time alloc] initWithString:@"6:00"] WithPillId:0 WithDosage:0 WithNotes:@"Was added 1st"];
    [self addCellAt:index];
    
    index = [myManager addReminderWithTime:[[Time alloc] initWithString:@"12:00"] WithPillId:0 WithDosage:0 WithNotes:@"Was added 2nd"];
    [self addCellAt:index];
    
    index = [myManager addReminderWithTime:[[Time alloc] initWithString:@"3:20"] WithPillId:0 WithDosage:0 WithNotes:@"Was added 3rd"];
    [self addCellAt:index];
    
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
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ReminderCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    [[cell textLabel] setText:[[NSString alloc] initWithFormat:@"Pill: Default Pill"]]; //,[myManager notesAt:[indexPath item]]]];
    [[cell detailTextLabel] setText:[[NSString alloc] initWithFormat:@"%@",[[myManager timeAt:[indexPath item]] description]]];
    
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
        [myManager deleteReminderWith:[indexPath item]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
