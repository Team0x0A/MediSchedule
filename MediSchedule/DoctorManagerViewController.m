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
#import "EditDoctorViewController.h"

//***************************************************************************************
// Private Interface:
//***************************************************************************************
@interface DoctorManagerViewController ()
{
    DoctorManager *myManager; // Doctor manager to be used for entire applocation
    int indexOfCurrentlySelectedCell;
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
    //Uncomment to perform tests:
    //[self testDoctorManager];
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
    else if ([[destination title] isEqual: @"EditDoctor"])
    {
        EditDoctorViewController *editDoctorViewController = segue.destinationViewController;
        editDoctorViewController.doctorManager = myManager;
        editDoctorViewController.doctorIndex = indexOfCurrentlySelectedCell;
        editDoctorViewController.callBack = self;
        
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
    indexOfCurrentlySelectedCell = [indexPath item];
    [self performSegueWithIdentifier:@"DoctorManagerToEditDoctorSegue" sender:self];
}


// Test doctor manager:
// *****************************
- (void) testDoctorManager
{
    
    while ([myManager numOfDoctors] > 0)
    {
        [myManager deleteDoctorWithIndex:0];
    }
    [myManager addDoctorWithName:@"HT" WithNumber:@"420" WithAddress:@"123 fake street" WithEmail:@"doctor@doctor.com"];
    [myManager addDoctorWithName:@"HT1" WithNumber:@"4201" WithAddress:@"123 fake street1" WithEmail:@"doctor@doctor.com1"];
    [myManager addDoctorWithName:@"HT2" WithNumber:@"4202" WithAddress:@"123 fake street2" WithEmail:@"doctor@doctor.com2"];
    [myManager addDoctorWithName:@"HT3" WithNumber:@"4203" WithAddress:@"123 fake street3" WithEmail:@"doctor@doctor.com3"];
    [myManager addDoctorWithName:@"HT4" WithNumber:@"4204" WithAddress:@"123 fake street4" WithEmail:@"doctor@doctor.com4"];
    [myManager addDoctorWithName:@"HT5" WithNumber:@"4205" WithAddress:@"123 fake street5" WithEmail:@"doctor@doctor.com5"];
    
    NSLog(@"%@", [myManager description]);
    NSLog(@"%@",[myManager listOfDoctorIds]);
    assert([myManager numOfDoctors] == 6);
    assert([[myManager nameOfDoctorWithId:0] isEqualToString:@"HT"]);
    assert([[myManager nameOfDoctorWithId:5] isEqualToString:@"HT5"]);
    [myManager deleteDoctorWithId:0];
    assert([myManager numOfDoctors] == 5);
    assert([[myManager nameOfDoctorWithId:5] isEqualToString:@"HT5"]);
    NSLog(@"Doctor Manager test succeeded!");
    
}

@end
