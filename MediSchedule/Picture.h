//
//  Picture.h
//  MediSchedule
//
//  Created by Ning Chai on 11/20/13.
//  Copyright (c) 2013 Team 0x0A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Picture : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
- (IBAction)ButPic:(id)sender;
- (IBAction)ButCamero:(id)sender;
@property (nonatomic, strong)UIImagePickerController *imagePicker;

@end
