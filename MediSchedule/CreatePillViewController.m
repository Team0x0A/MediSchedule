//
//  CreatePillViewController.m
//  MediSchedule
//
//  Created by Justin Wang on 2013-11-07.
//  Copyright (c) 2013 Team 0x0A. All rights reserved.
//

#import "CreatePillViewController.h"

//***************************************************************************************
// Private Interface:
//***************************************************************************************
@interface CreatePillViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *doctorIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *notesTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *createPillButton;

@end


//***************************************************************************************
// Implementation:
//***************************************************************************************
@implementation CreatePillViewController

@synthesize callBack;




// viewDidLoad:
// ****************************************
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Set this view controller as the delegate of all the text fields:
    [_nameTextField setDelegate:self];
    [_doctorIdTextField setDelegate:self];
    [_notesTextField setDelegate:self];
    
    // Setup the createPillButton to call the createPillButtonTapped method:
    [_createPillButton setTarget:self];
    [_createPillButton setAction:@selector(createPillButtonTapped:)];
    
}


// createPillButtonTapped:
// called by createPillButton
// ****************************************
- (void) createPillButton: (id)sender
{
    
    // Get the pill name from the text field:
    NSString* name = [[self nameTextField] text];
    
    // Get the doctorId from the text field:
    int doctorId = [[[self doctorIdTextField] text] integerValue];
    
    NSString* notes = [[self notesTextField] text];
    
    [callBack addPillWithName:name WithImage:NULL WithDoctorId:doctorId WithNotes:notes];
    
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
