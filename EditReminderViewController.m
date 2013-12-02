/*
 *  EditReminderViewController.m
 *  MediSchedule
 *
 *  Implementation file for EditReminderViewController class
 *
 *  Programmers:
 *  Ishan Bhutani
 *  Ning Chai
 *  Zheren Lu
 *  Justin Wang
 *
 *  Copyright (c) 2013 Team 0x0A
 */


#import "EditReminderViewController.h"
#import "PillManager.h"
#import "GlobalVariables.h"

//***************************************************************************************
// Private Interface:
//***************************************************************************************
@interface EditReminderViewController ()
{
    GlobalVariables *globalVariables;
    PillManager *pillManager;
    NSArray *listOfPillIds;
    int pillId;
}

@property (strong, nonatomic) IBOutlet UITextField      *dosageTextField;
@property (strong, nonatomic) IBOutlet UITextField      *notesTextField;
@property (strong, nonatomic) IBOutlet UIBarButtonItem  *saveButton;
@property (strong, nonatomic) IBOutlet UIPickerView     *pillPicker;
@property (strong, nonatomic) IBOutlet UILabel          *pillName;
@property (strong, nonatomic) IBOutlet UIImageView      *imageOfPill;
@property (strong, nonatomic) IBOutlet UIBarButtonItem  *choosePillButton;
@property (strong, nonatomic) IBOutlet UIDatePicker     *timePicker;

@end




//***************************************************************************************
// Implementation:
//***************************************************************************************
@implementation EditReminderViewController

@synthesize callBack;
@synthesize reminderManager;
@synthesize reminderIndex;


// viewDidLoad:
// ****************************************
- (void)viewDidLoad
{
    NSLog(@"Editing reminder with index: %d", reminderIndex);
    [super viewDidLoad];

    globalVariables = [GlobalVariables getInstance];
    pillManager = globalVariables.pillManager;
    reminderManager = globalVariables.reminderManager;
    listOfPillIds = [[NSArray alloc] initWithArray:[pillManager listOfPillIds]];
    
 
    // Set this view controller as the delegate of all the text fields
    [_dosageTextField setDelegate:self];
    [_notesTextField setDelegate:self];
    
    // Setup the saveButton to call the saveButtonTapped method:
    [self.saveButton setTarget:self];
    [self.saveButton setAction:@selector(saveButtonTapped:)];
    
    //set the keyboard under the input text field
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    
    // set all the fields according to the reminder we are editing:
    [self.dosageTextField setText: [NSString stringWithFormat:@"%d",[reminderManager dosageAtIndex:reminderIndex]]];
    [self.notesTextField setText: [reminderManager notesAtIndex:reminderIndex]];
    [self.timePicker setDate: [reminderManager timeAtIndex:reminderIndex]];
    pillId = [reminderManager pillIdAtIndex:reminderIndex];
    self.pillName.text = [pillManager nameOfPillWithId:pillId];
    
    //To hide keyboard when something outside the keyboard is tapped
    //only for dosage
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}





// saveButtonTapped:
// called by createReminderButton
// ****************************************
- (void)saveButtonTapped: (id)sender
{
    // Gurantee that all reminders contain a dosage and pillId (they must have a time by default):
    if ([[[self dosageTextField] text] length] < 1 || pillId == -1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid entry"
                                                        message:@"Please choose a pill and a dosage."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    
    // Get all input:
    int dosage      = [[[self dosageTextField] text] integerValue];
    NSString *notes = [[self notesTextField] text];
    NSDate *date    = [self.timePicker date];
    
    // update the reminder:
    [reminderManager setDosageTo:dosage AtIndex:reminderIndex];
    [reminderManager setNotesTo:notes AtIndex:reminderIndex];
    [reminderManager setTimeTo:date AtIndex:reminderIndex];
    [reminderManager setPillIdTo:pillId AtIndex:reminderIndex];
    
    // Pop CreateReminderViewController off of the navigationController view stack:
    [callBack loadView];
    [[self navigationController] popViewControllerAnimated:YES];
}




#pragma mark UITextFieldDelegate
// textFieldShouldReturn:
// delegated from the pillId, dosage and notes text fields:
// ****************************************
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}



// numberOfComponentsInPickerView:
// returns the number of 'columns' to display.
// ****************************************
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}




// numberOfRowsInComponent:
// returns the # of rows in each component..
// ****************************************
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return [listOfPillIds count];
}



// titleforRow:
// returns the name of the pill located at the row
// ****************************************
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    return [pillManager nameOfPillWithId:[[listOfPillIds objectAtIndex:row] integerValue]];
}




// didSelectRow:
// ****************************************
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    if([pickerView numberOfRowsInComponent:0] != 0)
    {
        self.pillName.text = [pillManager nameOfPillWithId:[[listOfPillIds objectAtIndex:row] integerValue]];
        pillId = [[listOfPillIds objectAtIndex:row] integerValue];
        [self.imageOfPill setImage:[pillManager imageOfPillWithId:[[listOfPillIds objectAtIndex:row] integerValue]]];
        [[self imageOfPill] setHidden:YES];
    }
}


// displayPillPicker:
// ****************************************
- (IBAction)displayPillPicker:(UIBarButtonItem *)sender
{
    [self pickerView:self.pillPicker didSelectRow:[self.pillPicker selectedRowInComponent:0] inComponent:0];
    if ([self.pillPicker isHidden])
    {
        if ([pillManager numOfPills] == 0)
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
        [self.timePicker setHidden:YES];
        [self.imageOfPill setHidden:YES];
    }
    else
    {
        self.choosePillButton.title = @"Choose Pill";
        [self.pillPicker setHidden:YES];
        [self.timePicker setHidden:NO];
        [self.imageOfPill setHidden:NO];
    }
}


// keyBoardDidShow:
// ****************************************
- (void)keyboardDidShow:(NSNotification *)notification
{
    //Assign new frame to your view
    //[self.view setFrame:CGRectMake(0,-50,320,460)]; //here taken -20 for example i.e. your view will be scrolled to -20. change its value according to your requirement.
    
}



// keyBoardDidHide:
// ****************************************
-(void)keyboardDidHide:(NSNotification *)notification
{
    //[self.view setFrame:CGRectMake(0,0,320,460)];
}



// dismissKeyboard:
// ****************************************
-(void) dismissKeyboard
{
    [self.dosageTextField resignFirstResponder];
}


@end
