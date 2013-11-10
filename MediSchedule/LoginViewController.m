//
//  LoginViewController.m
//  MediSchedule
//
//  Created by Justin Wang on 10/30/13.
//  Copyright (c) 2013 Ishan Bhutani. All rights reserved.
//

#import "LoginViewController.h"


//***************************************************************************************
// Private Interface:
//***************************************************************************************
@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passWordTextField;

@end




//***************************************************************************************
// Implementation:
//***************************************************************************************
@implementation LoginViewController



// viewDidLoad:
// ****************************************
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}




// viewDidLoad:
// ****************************************
- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Set this view controller as the delegate of all the text fields
    [_userNameTextField setDelegate:self];
    [_passWordTextField setDelegate:self];

}





#pragma mark UITextFieldDelegate
// textFieldShouldReturn:
// delegated from the userNameTextField, passWordTextField:
// ****************************************
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
	[textField resignFirstResponder];
    
	return YES;
}


@end
