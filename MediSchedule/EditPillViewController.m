//
//  EditPillViewController.m
//  MediSchedule
//
//  Created by Ning Chai on 11/27/13.
//  Copyright (c) 2013 Team 0x0A. All rights reserved.
//

#import "EditPillViewController.h"

@interface EditPillViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *notesTextField;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end


//***************************************************************************************
// Implementation:
//***************************************************************************************


@implementation EditPillViewController

@synthesize callBack;
@synthesize pillManager;
@synthesize pillIndex;





// viewDidLoad:
// ****************************************
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [_nameTextField setDelegate:self];
    [_notesTextField setDelegate:self];
    
    [_saveButton setTarget:self];
    [_saveButton setAction:@selector(saveButtonTapped:)];
	
    [_nameTextField setText:[pillManager nameOfPillWithIndex:pillIndex]];
    [_notesTextField setText:[pillManager notesOfPillWithIndex:pillIndex]];
    
}


// saveButtonTapped:
// called by saveButton
// ****************************************
- (void) saveButtonTapped: (id)sender
{
    NSString* name = [[self nameTextField] text];
    NSString* notes = [[self notesTextField] text];
    
    [pillManager setNameTo:name OfPillWithIndex: pillIndex];
    [pillManager setNameTo:notes OfPillWithIndex: pillIndex];
    
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
