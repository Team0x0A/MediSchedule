/*
 *  CreateReminderViewController.m
 *  MediSchedule
 *
 *  Implementation file for CreateReminderViewController class
 *
 *  Programmers:
 *  Ishan Bhutani
 *  Ning Chai
 *  Zheren Lu
 *  Justin Wang
 *
 *  Copyright (c) 2013 Team 0x0A
 */


#import "CreateReminderViewController.h"
#import "PillManager.h"

//***************************************************************************************
// Private Interface:
//***************************************************************************************
@interface CreateReminderViewController ()
{
    PillManager *myManager;
    NSArray *listOfPillIds;
    int pillId;
}

@property (strong, nonatomic) IBOutlet UITextField *timeTextField;
@property (strong, nonatomic) IBOutlet UITextField *dosageTextField;
@property (strong, nonatomic) IBOutlet UITextField *notesTextField;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *createReminderButton;
@property (strong, nonatomic) IBOutlet UIPickerView *pillPicker;
@property (strong, nonatomic) IBOutlet UILabel *pillName;
@property (strong, nonatomic) IBOutlet UIImageView *imageOfPill;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *choosePillButton;


- (void)configureView;

@end




//***************************************************************************************
// Implementation:
//***************************************************************************************
@implementation CreateReminderViewController

@synthesize callBack;




// configureView:
// ****************************************
- (void)configureView
{
    // Update the user interface for the detail item.
    /*
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }*/
}





// viewDidLoad:
// ****************************************
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
    
    // Set this view controller as the delegate of all the text fields
    [_timeTextField setDelegate:self];
    [_dosageTextField setDelegate:self];
    [_notesTextField setDelegate:self];
    
    // Setup the createReminderButton to call the createReminderButtonTapped method:
    [_createReminderButton setTarget:self];
    [_createReminderButton setAction:@selector(createReminderButtonTapped:)];
    myManager =  [[PillManager alloc] init];
    listOfPillIds = [[NSArray alloc] initWithArray:[myManager listOfPillIds]];
    
    //set the keyboard under the input text field
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];

}





// createReminderButtonTapped:
// called by createReminderButton
// ****************************************
- (void)createReminderButtonTapped: (id)sender
{
    // Get time from field:
    // This needs to be read from the text field:
    Time* time = [[Time alloc] init];
    
    // Get dosage from field:
    int dosage = [[[self dosageTextField] text] integerValue];
    
    // Get notes from field:
    NSString *notes = [[self notesTextField] text];
    
    // Add the reminder to the reminder manager:
    [callBack addReminderWithTime:time
                       WithPillId:pillId
                       WithDosage:dosage
                        WithNotes:notes];
    
    // Pop CreateReminderViewController off of the navigationController view stack:
    [[self navigationController] popViewControllerAnimated:YES];
}




#pragma mark UITextFieldDelegate
// textFieldShouldReturn:
// delegated from the time, pillId, dosage and notes text fields:
// ****************************************
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return [listOfPillIds count];
}


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    return [myManager nameOfPillWithId:[[listOfPillIds objectAtIndex:row] integerValue]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    if([pickerView numberOfRowsInComponent:0] != 0)
    {
        self.pillName.text = [myManager nameOfPillWithId:[[listOfPillIds objectAtIndex:row] integerValue]];
        pillId = [[listOfPillIds objectAtIndex:row] integerValue];
        [self.imageOfPill setImage:[myManager imageOfPillWithId:[[listOfPillIds objectAtIndex:row] integerValue]]];
        [[self imageOfPill] setHidden:YES];
    }
}

- (IBAction)displayPillPicker:(UIBarButtonItem *)sender
{
    [self pickerView:self.pillPicker didSelectRow:[self.pillPicker selectedRowInComponent:0] inComponent:0];
    if ([self.pillPicker isHidden])
    {
        if ([myManager numOfPills] == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No pills found"
                                               message:@"Please add medications into the application."
                                              delegate:nil
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
            [alert show];
            return;
        }
        self.choosePillButton.title = @"Done";
        [self.pillPicker setHidden:NO];
        [self.imageOfPill setHidden:YES];
    }
    else
    {
        self.choosePillButton.title = @"Choose Pill";
        [self.pillPicker setHidden:YES];
        [self.imageOfPill setHidden:NO];
    }
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    //Assign new frame to your view
    [self.view setFrame:CGRectMake(0,-20,320,460)]; //here taken -20 for example i.e. your view will be scrolled to -20. change its value according to your requirement.
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    [self.view setFrame:CGRectMake(0,0,320,460)];
}



@end
