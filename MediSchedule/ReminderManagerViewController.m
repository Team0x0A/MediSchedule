//
//  MediScheduleMasterViewController.m
//  MediSchedule
//
//  Created by Ishan Bhutani on 10/26/13.
//  Copyright (c) 2013 Ishan Bhutani. All rights reserved.
//

#import "ReminderManagerViewController.h"
#import "ReminderViewController.h"
#import "ReminderManager.h"
#import "Reminder.h"


@interface ReminderManagerViewController ()
{
    ReminderManager *myManager;// Reminder Manager to be used for entire application
    NSMutableArray *_objects;
    
}

-(void) testReminderManager;

@end

@implementation ReminderManagerViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // The reminder manager is initialized the first time the application loads
    // Note: there is not file system support as of now. Each time the application is loaded, myManager is re-initialized
    
    if (!myManager)
    {
        myManager = [[ReminderManager alloc] init];
    }
    
    [self testReminderManager];
    
    
    
	// Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    // Add new Reminder button:
    //UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //self.navigationItem.rightBarButtonItem = addButton;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTapped:)];
    self.navigationItem.rightBarButtonItem = addButton;
      
}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) addCellAt:(int)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}



- (void)insertNewObject:(id)sender
{
    static int somecount = 0;
    int index = [myManager addReminderWithTime:[[Time alloc] initWithHour:rand()%24 WithMin:00 WithSec:0]
                                    WithPillId:52
                                    WithDosage:5000
                                     WithNotes:[[NSString alloc] initWithFormat:@"%d", somecount]
                 ];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
     /*
      if (!_objects) {
    _objects = [[NSMutableArray alloc] init];
     }
     [
     _objects insertObject:[NSDate date] atIndex:0];
     NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
     [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
     */
    somecount++;
}






- (void)addTapped:(id)sender {
    
    /*
    int index = [myManager addReminderWithTime:[[Time alloc] initWithHour:rand()%24 WithMin:00 WithSec:0]
                                    WithPillId:52
                                    WithDosage:5000
                                     WithNotes:[[NSString alloc] initWithFormat:@"%d", 12345]];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];*/
    [self performSegueWithIdentifier:@"MySegue" sender:self];
}






#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}








- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [myManager numOfReminders];
}









- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ReminderCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    [[cell textLabel] setText:[[NSString alloc] initWithFormat:@"Pill: Default Pill"]]; //,[myManager notesAt:[indexPath item]]]];
    [[cell detailTextLabel] setText:[[NSString alloc] initWithFormat:@"%@",[[myManager timeAt:[indexPath item]] description]]];
    return cell;
}








- (BOOL)tableView:(UITableView *)tableView
canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}








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






/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    /*
     if ([[segue identifier] isEqualToString:@"showDetail"]) {
     NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
     NSDate *object = _objects[indexPath.row];
     [[segue destinationViewController] setDetailItem:object];
     }
     */
    
    /*
    MediScheduleDetailViewController *detailController = segue.destinationViewController;
    Reminder* editReminder = [[Reminder alloc] initWithTime:
                              [myManager timeAt: self.tableView.indexPathForSelectedRow.row]
                                                 WithPillId:[myManager pillIdAt: self.tableView.indexPathForSelectedRow.row]
                                                 WithDosage:[myManager dosageAt: self.tableView.indexPathForSelectedRow.row]
                                                  WithNotes:[myManager notesAt: self.tableView.indexPathForSelectedRow.row]
                              ];
    
    //ScaryBugDoc *bug = [self.bugs objectAtIndex:self.tableView.indexPathForSelectedRow.row];*/

    ReminderViewController *detailController = segue.destinationViewController;
    detailController.detailItem = myManager;
    detailController.callBack = self;
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
    
    index = [myManager addReminderWithTime:[[Time alloc] initWithString:@"9:00"] WithPillId:0 WithDosage:0 WithNotes:@"Was added 4th"];
    [self addCellAt:index];
    
    index = [myManager addReminderWithTime:[[Time alloc] initWithString:@"1:45"] WithPillId:0 WithDosage:0 WithNotes:@"Was added 5th"];
    [self addCellAt:index];
    
    index = [myManager addReminderWithTime:[[Time alloc] initWithString:@"5:30"] WithPillId:0 WithDosage:0 WithNotes:@"Was added 6th"];
    [self addCellAt:index];
    
    index = [myManager addReminderWithTime:[[Time alloc] initWithString:@"4:45"] WithPillId:0 WithDosage:0 WithNotes:@"Was added 5th"];
    [self addCellAt:index];
    
    index = [myManager addReminderWithTime:[[Time alloc] initWithString:@"12:30"] WithPillId:0 WithDosage:0 WithNotes:@"Was added 6th"];
    [self addCellAt:index];
    
    [myManager deleteReminderWith:0];
    [myManager deleteReminderWith:0];
    [myManager deleteReminderWith:0];
    [myManager deleteReminderWith:0];
}

@end
