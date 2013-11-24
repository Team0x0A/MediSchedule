/*
 *  CreatePillViewController.m
 *  MediSchedule
 *
 *  Implementation file for CreatePillViewController class
 *
 *  Programmers:
 *  Ishan Bhutani
 *  Ning Chai
 *  Zheren Lu
 *  Justin Wang
 *
 *  Copyright (c) 2013 Team 0x0A
 */

#import "CreatePillViewController.h"

//***************************************************************************************
// Private Interface:
//***************************************************************************************
@interface CreatePillViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *doctorIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *notesTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *createPillButton;
@property(nonatomic,strong)UIImagePickerController *imagePicker;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

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
- (void) createPillButtonTapped: (id)sender
{
    // Get all input data from text fields:
    NSString* name = [[self nameTextField] text];
    int doctorId = [[[self doctorIdTextField] text] integerValue];
    NSString* notes = [[self notesTextField] text];
    UIImage *image = [[self imageView] image];
    // add new pill to pillManager:
    [callBack addPillWithName:name WithImage:image WithDoctorId:doctorId WithNotes:notes];
    
    // Pop CreatePillViewController off of the navigationController view stack:
    [[self navigationController] popViewControllerAnimated:YES];
}


#pragma mark UITextFieldDelegate
// textFieldShouldReturn:
// delegated from the name, doctorId and notes text fields:
// ****************************************
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
	[textField resignFirstResponder];
    
	return YES;
    
}

// picFromPhotos:
// Get new image from photo library on phone
// *************************************************
- (IBAction)picFromPhotos:(UIButton *)sender
{
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.imagePicker setAllowsEditing:YES];
    [self.imagePicker setDelegate:(id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)self];
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

// picFromCamera:
// Get new image from camera on phone
// *************************************************
- (IBAction)picFromCamera:(UIButton *)sender
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        self.imagePicker = [[UIImagePickerController alloc]init];
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.imagePicker setDelegate:(id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)self];
        [self.imagePicker setAllowsEditing:YES];
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }
}

// imagePickerController: pickerDidFinishPickingMediaWithInfo:
// Called when picture has been selected; adds picture into pill
// **********************************************************************
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    self.imageView.image = img;
}


@end
