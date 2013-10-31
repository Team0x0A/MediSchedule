/*
 *  ReminderViewController.m
 *  MediSchedule
 *
 *  Implementation file for ReminderViewController class
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
}





#pragma mark - Managing the detail item
// setDetailItem:
// ****************************************
/* - (void)setDetailItem:(id)newDetailItem
 {
 if (_detailItem != newDetailItem) {
 _detailItem = newDetailItem;
 
 // Update the view.
 [self configureView];
 }
 }*/




// detailItem:
// ****************************************
/*{- (ReminderManager*) detailItem
return _detailItem;
} */

@end
