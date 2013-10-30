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
#import "ReminderViewController.h"
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
@property (strong, nonatomic) IBOutlet ReminderManagerTableView *table;

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
    
    
    // Create a button to add reminders to the table:
    UIBarButtonItem *addReminderButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd // This is the plus sign icon
                                                                               target: self
                                                                               action: @selector(addReminderButtonTapped:)]; // This is linking the button to method addTapped
    self.navigationItem.rightBarButtonItem = addReminderButton;
     
    
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
        
        ReminderViewController *detailController = segue.destinationViewController;
        detailController.detailItem = myManager;
        detailController.callBack = self;
    }
}






- (void) testReminderManager
{
    int index;
    index = [myManager addReminderWithTime:[[Time alloc] initWithString:@"6:00"] WithPillId:0 WithDosage:0 WithNotes:@"Was added 1st"];
    [self.table addCellAt:index];
    
    index = [myManager addReminderWithTime:[[Time alloc] initWithString:@"12:00"] WithPillId:0 WithDosage:0 WithNotes:@"Was added 2nd"];
    [self.table addCellAt:index];
    
    index = [myManager addReminderWithTime:[[Time alloc] initWithString:@"3:20"] WithPillId:0 WithDosage:0 WithNotes:@"Was added 3rd"];
    [self.table addCellAt:index];
}

@end
