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


#import "ReminderViewController.h"

@interface ReminderViewController ()
@property (strong, nonatomic) IBOutlet UITextField *timeTextField;
@property (strong, nonatomic) IBOutlet UITextField *pillIdTextField;
@property (strong, nonatomic) IBOutlet UITextField *dosageTextField;
@property (strong, nonatomic) IBOutlet UITextField *notesTextField;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;
- (void)configureView;
@end

@implementation ReminderViewController

#pragma mark - Managing the detail item
@synthesize detailItem;
@synthesize callBack;

//- (void)setDetailItem:(id)newDetailItem
//{
//    if (_detailItem != newDetailItem) {
//        _detailItem = newDetailItem;
//        
//        // Update the view.
//        [self configureView];
//    }
//}
//
//- (ReminderManager*) detailItem
//{
//    return _detailItem;
//}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)createReminder:(UIBarButtonItem *)sender
{
    NSLog(@"THIS IS CALLED");
    Time* time = [[Time alloc] init];
    int pillid = [[[self pillIdTextField] text] integerValue];
    int dosage = [[[self dosageTextField] text] integerValue];
    NSString *notes = [[self notesTextField] text];
    
    int index = [[self detailItem] addReminderWithTime:time
                                WithPillId:pillid
                                WithDosage:dosage
                                 WithNotes:notes];
    
    [callBack addCellAt:index];
}




@end
