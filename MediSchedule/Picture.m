//
//  Picture.m
//  MediSchedule
//
//  Created by Ning Chai on 11/20/13.
//  Copyright (c) 2013 Team 0x0A. All rights reserved.
//

#import "Picture.h"

@interface Picture ()

@end

@implementation Picture
@synthesize imagePicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ButPic:(id)sender {
    self.imagePicker = [[UIImagePickerController alloc]init];
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.imagePicker setAllowsEditing:YES];
    self.imagePicker.delegate = self;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *img = [info objectForKey: UIImagePickerControllerEditedImage];
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    self.ImageView.image = img;
    
}


- (IBAction)ButCamero:(id)sender {
    self.imagePicker = [[UIImagePickerController alloc]init];
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
}
@end
