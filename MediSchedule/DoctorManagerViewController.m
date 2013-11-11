/*
 *  DoctorManagerViewController.m
 *  MediSchedule
 *
 *  Implementation file for DoctorManagerViewController class
 *
 *  Programmers:
 *  Ishan Bhutani
 *  Ning Chai
 *  Zheren Lu
 *  Justin Wang
 *
 *  Copyright (c) 2013 Team 0x0A
 */

#import "DoctorManagerViewController.h"
#import "DoctorManager.h"
#import "CreateDoctorViewController.h"

//***************************************************************************************
// Private Interface:
//***************************************************************************************
@interface DoctorManagerViewController ()
{
    DoctorManager *myManager; // Doctor manager to be used for entire applocation
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addDoctorButton;

@end



//***************************************************************************************
// Implementation:
//***************************************************************************************
@implementation DoctorManagerViewController


// viewDidLoad:
// gets called when the view manager is created
// ****************************************
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(!myManager)
    {
        myManager = [[DoctorManager alloc] init];
    }

    // Setup the addDoctorButton:
    [_addDoctorButton setTarget:self];
    [_addDoctorButton setAction:@selector(addDoctorButtonTapped:)];
}




// addDoctorButtonTapped:
// This method is called by addDoctorButton
// ****************************************
- (void)addDoctorButtonTapped:(id)sender
{
    [self performSegueWithIdentifier:@"DoctorManagerToCreateDoctorSegue" sender:self];
}




// addDoctor:
// called by CreateDoctorViewController when creating new doctor
// ****************************************
- (void) addDoctorWithName: (NSString*) newName
                WithNumber: (NSString*) newNumber
               WithAddress: (NSString*) newAddress
                 WithEmail: (NSString*) newEmail
{
    NSLog(@"addDoctor called...");
    [myManager addDoctorWithName:newName WithNumber:newNumber WithAddress:newAddress WithEmail:newEmail];
    [self addCellAt:[myManager numOfDoctors] - 1];
}



// prepareForSegue:
// gets called before seguing to another view controller
// ****************************************
- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    
    UIViewController* destination = [segue destinationViewController];
    
    if([[destination title] isEqual: @"CreateDoctor"])
    {
        
        CreateDoctorViewController *detailController = segue.destinationViewController;
        detailController.callBack = self;
    }
}


//***************************************************************************************
// Table Methods:
//***************************************************************************************

// addCellAt:
// ****************************************
- (void) addCellAt:(int)index
{
    // Convert the index to an indexPath into the table:
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    // Create a new cell at:
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    NSLog(@"DoctorManagerViewController: addCellAt called...");
}



// numberOfSectionsInTableView:
// ****************************************
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



// numberOfRowsInSections:
// ****************************************
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [myManager numOfDoctors];
}



// cellForRowAtIndexPath
// Returns the table cell at the specified index path.
// ****************************************
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DoctorCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    [[cell textLabel] setText: [myManager nameOfDoctorWithIndex:[indexPath item]]];
    [[cell detailTextLabel] setText: [myManager numberOfDoctorWithIndex:[indexPath item]]];
    
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
        [myManager deleteDoctorWithIndex:[indexPath item]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *) indexPath
{
    NSLog(@"shit just got detailed view tapped...");
    [self performSegueWithIdentifier:@"DoctorManagerToEditDoctorSegue" sender:self];
}


@end
