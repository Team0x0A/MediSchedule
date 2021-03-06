/*
 *  EditDoctorViewController.m
 *  MediSchedule
 *
 *  Implementation file for EditDoctorViewController class
 *
 *  Programmers:
 *  Ishan Bhutani
 *  Ning Chai
 *  Zheren Lu
 *  Justin Wang
 *
 *  Copyright (c) 2013 Team 0x0A
 */

#import "EditDoctorViewController.h"

//***************************************************************************************
// Private Interface:
//***************************************************************************************
@interface EditDoctorViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

//***************************************************************************************
// Implementation:
//***************************************************************************************
@implementation EditDoctorViewController

@synthesize callBack;
@synthesize doctorManager;
@synthesize doctorIndex;



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
	
    // Setup the saveButton to call the saveButtonTapped method:
    [_saveButton setTarget:self];
    [_saveButton setAction:@selector(saveButtonTapped:)];
    
    // set all fields according to the doctor we are editing:
    [_nameTextField setText:[doctorManager nameOfDoctorWithIndex:doctorIndex]];
    [_addressTextField setText:[doctorManager addressOfDoctorWithIndex:doctorIndex]];
    [_phoneNumberTextField setText:[doctorManager numberOfDoctorWithIndex:doctorIndex]];
    [_emailTextField setText:[doctorManager emailOfDoctorWithIndex:doctorIndex]];
    
    //To hide keyboard when something outside the keyboard is tapped
    //only for phone number since it doesnt have a done key
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}



// saveButtonTapped:
// called by saveButton
// ****************************************
- (void) saveButtonTapped: (id)sender
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
    NSString* name          = [[self nameTextField] text];
    NSString* address       = [[self addressTextField] text];
    NSString* phoneNumber   = [[self phoneNumberTextField] text];
    NSString* email         = [[self emailTextField] text];
    
    // update the doctor:
    [doctorManager setNameTo:name OfDoctorWithIndex:doctorIndex];
    [doctorManager setAddressTo:address OfDoctorWithIndex:doctorIndex];
    [doctorManager setNumberTo:phoneNumber OfDoctorWithIndex:doctorIndex];
    [doctorManager setEmailTo:email OfDoctorWithIndex:doctorIndex];
    
    // Pop ViewDoctorViewController off of the navigationController view stack:
    [callBack loadView];
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

-(void) dismissKeyboard
{
    [self.phoneNumberTextField resignFirstResponder];
}
@end
