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



// createPillButtonTapped:
// called by createPillButton
// ****************************************
- (void) createDoctorButtonTapped: (id)sender
{
    /*
    // Get the doctor name from the text field:
    NSString* name = [[self nameTextField] text];
    
    // Get the doctorId from the text field:
    int doctorId = [[[self doctorIdTextField] text] integerValue];
    
    NSString* notes = [[self notesTextField] text];
    
    [callBack addPillWithName:name WithImage:NULL WithDoctorId:doctorId WithNotes:notes];
    */
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
