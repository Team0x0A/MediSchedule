//
//  EditDoctorViewController.m
//  MediSchedule
//
//  Created by Justin Wang on 11/10/13.
//  Copyright (c) 2013 Team 0x0A. All rights reserved.
//

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
    
    [_nameTextField setText:[doctorManager nameOfDoctorWithIndex:doctorIndex]];
    [_addressTextField setText:[doctorManager addressOfDoctorWithIndex:doctorIndex]];
    [_phoneNumberTextField setText:[doctorManager numberOfDoctorWithIndex:doctorIndex]];
    [_emailTextField setText:[doctorManager emailOfDoctorWithIndex:doctorIndex]];
}



// saveButtonTapped:
// called by saveButton
// ****************************************
- (void) saveButtonTapped: (id)sender
{
    // Get all input data from text fields:
    NSString* name = [[self nameTextField] text];
    NSString* address = [[self addressTextField] text];
    NSString* phoneNumber = [[self phoneNumberTextField] text];
    NSString* email = [[self emailTextField] text];
    
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
@end
