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

//Testing purposes only: (DELETE THIS AFTER)
#import "DoctorManager.h"


//***************************************************************************************
// Private Interface:
//***************************************************************************************
@interface PillManagerViewController ()
{
    PillManager *myManager; // Pill Manager to be used for entire application
    //Testing purposes only: (DELETE THIS AFTER)
    DoctorManager *doctorManager;
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
    
    //Testing purposes only: (DELETE THIS AFTER)
    if (!doctorManager)
    {
        doctorManager = [[DoctorManager alloc] init];
    }
    //[self testPillManager];
    //[self testDoctorManager];
    // Setup the addPillButton:
    [_addPillButton setTarget:self];
    [_addPillButton setAction:@selector(addPillButtonTapped:)];
}


- (void) testDoctorManager
{
    [doctorManager addDoctorWithName:@"HT" WithNumber:@"420" WithAddress:@"123 fake street" WithEmail:@"doctor@doctor.com"];
    [doctorManager addDoctorWithName:@"HT1" WithNumber:@"4201" WithAddress:@"123 fake street1" WithEmail:@"doctor@doctor.com1"];
    [doctorManager addDoctorWithName:@"HT2" WithNumber:@"4202" WithAddress:@"123 fake street2" WithEmail:@"doctor@doctor.com2"];
    [doctorManager addDoctorWithName:@"HT3" WithNumber:@"4203" WithAddress:@"123 fake street3" WithEmail:@"doctor@doctor.com3"];
    [doctorManager addDoctorWithName:@"HT4" WithNumber:@"4204" WithAddress:@"123 fake street4" WithEmail:@"doctor@doctor.com4"];
    [doctorManager addDoctorWithName:@"HT5" WithNumber:@"4205" WithAddress:@"123 fake street5" WithEmail:@"doctor@doctor.com5"];
    NSLog(@"%@", [doctorManager description]);
    NSLog(@"%@",[doctorManager listOfDoctorIds]);
    assert([doctorManager numOfDoctors] == 6);
    assert([[doctorManager nameOfDoctorWithId:0] isEqualToString:@"HT"]);
    assert([[doctorManager nameOfDoctorWithId:5] isEqualToString:@"HT5"]);
    [doctorManager deleteDoctorWithId:0];
    assert([doctorManager numOfDoctors] == 5);
    assert([[doctorManager nameOfDoctorWithId:5] isEqualToString:@"HT5"]);
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
    
    [[cell textLabel] setText:[[NSString alloc] initWithFormat:[myManager nameOfPillWithIndex:[indexPath item]]]];
    [[cell detailTextLabel] setText:[[NSString alloc] initWithFormat:[myManager notesOfPillWithIndex:[indexPath item]]]];

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
        [myManager deletePillWithIndex:[indexPath item]];
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
    /*
    NSURL *documentDirectory = [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory
                                                                      inDomains:NSUserDomainMask] lastObject];
    NSURL *fileLocation = [NSURL URLWithString:@"PillManager"
                  relativeToURL:documentDirectory];
    NSMutableArray *emptyArray = [[NSMutableArray alloc] init];
    NSData* dataToSave = [NSKeyedArchiver archivedDataWithRootObject:emptyArray];
    
    [dataToSave writeToURL:fileLocation atomically:YES];
    */
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
