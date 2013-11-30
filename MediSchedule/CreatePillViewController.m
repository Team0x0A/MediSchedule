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
#import "DoctorManager.h"
#import "GlobalVariables.h"

//***************************************************************************************
// Private Interface:
//***************************************************************************************
@interface CreatePillViewController ()
{
    GlobalVariables *globalVariables;
    DoctorManager *doctorManager;
    NSArray *listOfDoctorIds;
    int doctorId;
}

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *notesTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *createPillButton;
@property(nonatomic,strong) UIImagePickerController *imagePicker;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UIPickerView *doctorPicker;
@property (strong, nonatomic) IBOutlet UILabel *doctorName;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *chooseDoctorButton;

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
    
    globalVariables = [GlobalVariables getInstance];
    doctorManager =  globalVariables.doctorManager;
    
    // Set this view controller as the delegate of all the text fields:
    [_nameTextField setDelegate:self];
    [_notesTextField setDelegate:self];
    
    // Setup the createPillButton to call the createPillButtonTapped method:
    [_createPillButton setTarget:self];
    [_createPillButton setAction:@selector(createPillButtonTapped:)];
    doctorId = -1;//no doctor selected
    

    
    listOfDoctorIds = [[NSArray alloc] initWithArray:[doctorManager listOfDoctorIds]];
    
    //set the keyboard under the input text field
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}


// createPillButtonTapped:
// called by createPillButton
// ****************************************
- (void) createPillButtonTapped: (id)sender
{
    if ([[[self nameTextField] text] length] < 1 || [[[self notesTextField] text] length] < 1 || [[self imageView] image] == nil || doctorId == -1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid entry"
                                                        message:@"Please fill out all forms."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    // Get all input data from text fields:
    NSString* name = [[self nameTextField] text];
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
    else
    {
        UIAlertView *alert;
        alert = [[UIAlertView alloc] initWithTitle:@"No camera found"
                                           message:@"Please choose an existing picture."
                                          delegate:nil
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil];
        [alert show];
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

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return [listOfDoctorIds count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    return [doctorManager nameOfDoctorWithId:[[listOfDoctorIds objectAtIndex:row] integerValue]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    if([pickerView numberOfRowsInComponent:0] != 0)
    {
        self.doctorName.text = [doctorManager nameOfDoctorWithId:[[listOfDoctorIds objectAtIndex:row] integerValue]];
        doctorId = [[listOfDoctorIds objectAtIndex:row] integerValue];
    }
}

- (IBAction)displayPillPicker:(UIBarButtonItem *)sender
{
    [self pickerView:self.doctorPicker didSelectRow:[self.doctorPicker selectedRowInComponent:0] inComponent:0];
    if ([self.doctorPicker isHidden])
    {
        if ([doctorManager numOfDoctors] == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No doctors found"
                                                            message:@"Please add doctors into the application."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }
        self.chooseDoctorButton.title = @"Done";
        [self.doctorPicker setHidden:NO];
    }
    else
    {
        self.chooseDoctorButton.title = @"Choose Doctor";
        [self.doctorPicker setHidden:YES];
    }
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    //Assign new frame to your view
    //[self.view setFrame:CGRectMake(0,-70,320,460)]; //here taken -20 for example i.e. your view will be scrolled to -20. change its value according to your requirement.
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    //[self.view setFrame:CGRectMake(0,0,320,460)];
}

@end
