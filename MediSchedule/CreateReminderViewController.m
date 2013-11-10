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

//***************************************************************************************
// Private Interface:
//***************************************************************************************
@interface CreateReminderViewController ()
{
    
}

@property (strong, nonatomic) IBOutlet UITextField *timeTextField;
@property (strong, nonatomic) IBOutlet UITextField *pillIdTextField;
@property (strong, nonatomic) IBOutlet UITextField *dosageTextField;
@property (strong, nonatomic) IBOutlet UITextField *notesTextField;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *createReminderButton;


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
    [_pillIdTextField setDelegate:self];
    [_dosageTextField setDelegate:self];
    [_notesTextField setDelegate:self];
    
    // Setup the createReminderButton to call the createReminderButtonTapped method:
    [_createReminderButton setTarget:self];
    [_createReminderButton setAction:@selector(createReminderButtonTapped:)];
}





// createReminderButtonTapped:
// called by createReminderButton
// ****************************************
- (void)createReminderButtonTapped: (id)sender
{
    // Get time from field:
    // This needs to be read from the text field:
    Time* time = [[Time alloc] init];
    
    // Get pillId from field:
    int pillid = [[[self pillIdTextField] text] integerValue];
    
    // Get dosage from field:
    int dosage = [[[self dosageTextField] text] integerValue];
    
    // Get notes from field:
    NSString *notes = [[self notesTextField] text];
    
    // Add the reminder to the reminder manager:
    [callBack addReminderWithTime:time
                       WithPillId:pillid
                       WithDosage:dosage
                        WithNotes:notes];
    
    // Pop CreateReminderViewController off of the navigationController view stack:
    [[self navigationController] popViewControllerAnimated:YES];
}




#pragma mark UITextFieldDelegate
// textFieldShouldReturn:
// delegated from the time, pillId, dosage and notes text fields:
// ****************************************
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
	[textField resignFirstResponder];
    
	return YES;
    
}


@end
