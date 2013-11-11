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
}





// createDoctorButtonTapped:
// called by createDoctorButton
// ****************************************
- (void) createDoctorButtonTapped: (id)sender
{
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
@end
