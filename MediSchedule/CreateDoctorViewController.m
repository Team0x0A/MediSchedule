/*
 *  CreateDoctorViewController.m
 *  MediSchedule
 *
 *  Implementation file for CreateDoctorViewController class
 *
 *  Programmers:
 *  Ishan Bhutani
 *  Ning Chai
 *  Zheren Lu
 *  Justin Wang
 *
 *  Copyright (c) 2013 Team 0x0A
 */

#import "CreateDoctorViewController.h"

//***************************************************************************************
// Private Interface:
//***************************************************************************************
@interface CreateDoctorViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *createDoctorButton;

@end

//***************************************************************************************
// Implementation:
//***************************************************************************************
@implementation CreateDoctorViewController

@synthesize callBack;




// viewDidLoad:
// ****************************************
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set this view controller as the delegate of all the text fields:
    [_nameTextField setDelegate:self];
    [_addressTextField setDelegate:self];
    [_phoneNumberTextField setDelegate:self];
    [_emailTextField setDelegate:self];
	
    // Setup the createDoctorButton to call the createDoctorButtonTapped method:
    [_createDoctorButton setTarget:self];
    [_createDoctorButton setAction:@selector(createDoctorButtonTapped:)];
    
    //set the keyboard under the input text field
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    //To hide keyboard when something outside the keyboard is tapped
    //only for phone number since it doesnt have a done key
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}





// createDoctorButtonTapped:
// called by createDoctorButton
// ****************************************
- (void) createDoctorButtonTapped: (id)sender
{
    // Gurantee that the doctor has at least a name:
    if ([[[self nameTextField] text] length] < 1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid entry"
                                                        message:@"Please fill out name."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    // Get all input data from text fields:
    NSString* name = [[self nameTextField] text];
    NSString* address = [[self addressTextField] text];
    NSString* phoneNumber = [[self phoneNumberTextField] text];
    NSString* email = [[self emailTextField] text];
    
    // Add new doctor to doctorManager:
    [callBack addDoctorWithName:name WithNumber:phoneNumber WithAddress:address WithEmail:email];
    
    NSLog(@"createDoctorButtonTapped called...");
    
    // Pop CreatePillViewController off of the navigationController view stack:
    [[self navigationController] popViewControllerAnimated:YES];
}





#pragma mark UITextFieldDelegate
// textFieldShouldReturn:
// delegated from the name, doctorId and notes text fields:
// ****************************************
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
	[textField resignFirstResponder];
    
	return YES;
    
}




- (void)keyboardDidShow:(NSNotification *)notification
{
    //Assign new frame to your view
    [self.view setFrame:CGRectMake(0,-30,320,460)]; //here taken -20 for example i.e. your view will be scrolled to -20. change its value according to your requirement.
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    [self.view setFrame:CGRectMake(0,0,320,460)];
}



-(void) dismissKeyboard
{
    [self.phoneNumberTextField resignFirstResponder];
}
@end
