/*
 *  LoginViewController.m
 *  MediSchedule
 *
 *  Implementation file for LoginViewController class
 *
 *  Programmers:
 *  Ishan Bhutani
 *  Ning Chai
 *  Zheren Lu
 *  Justin Wang
 *
 *  Copyright (c) 2013 Team 0x0A
 */
#import "LoginViewController.h"


//***************************************************************************************
// Private Interface:
//***************************************************************************************
@interface LoginViewController ()
{
    NSMutableDictionary *userProfile;
}
@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passWordTextField;

@end




//***************************************************************************************
// Implementation:
//***************************************************************************************
@implementation LoginViewController



// initWithNibName:
// ****************************************
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


// viewDidLoad:
// ****************************************
- (void)viewDidLoad
{
    [super viewDidLoad];
    userProfile = [[NSMutableDictionary alloc] initWithContentsOfURL:[self fileLocation]];
    if (!userProfile)//If file was empty (i.e no username/password saved)
    {
        userProfile = [[NSMutableDictionary alloc] initWithObjects:@[@"",@""]
                                                           forKeys:@[@"username", @"password"]];
    }
    
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


- (IBAction)createAccount:(UIBarButtonItem *)sender
{
    //Alerts will be displayed with needed information to guide user through set up screens
    UIAlertView *alert;
    
    if ([[userProfile objectForKey:@"username"] isEqualToString:@""] && [[userProfile objectForKey:@"password"] isEqualToString:@""])//Empty fields
    {
        if ([[self.userNameTextField text] length] == 0 || [[self.passWordTextField text] length] == 0)
        {
            alert = [[UIAlertView alloc] initWithTitle:@"Invalid Entry"
                                               message:@"Please fill out all fields."
                                              delegate:nil
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            alert = [[UIAlertView alloc] initWithTitle:@"New Account"
                                               message:@"Created successfully"
                                              delegate:nil
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
            [alert show];
            
            //Add username and password to NSDictionary, and save to file on device
            [userProfile setValue:[[self userNameTextField] text] forKey:@"username"];
            [userProfile setValue:[[self passWordTextField] text] forKey:@"password"];
            [userProfile writeToURL:[self fileLocation] atomically:YES];
            
            //Reset fields
            [[self userNameTextField] setText:@""];
            [[self passWordTextField] setText:@""];
            
            //Push ReminderManager onto navigation controller
            [self performSegueWithIdentifier:@"login" sender:self];
        }
    }
    else
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Account Exists"
                                           message:@"There is already an account created. Please log in with the correct credentials."
                                          delegate:nil
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)logIn:(UIBarButtonItem *)sender
{
    UIAlertView *alert;
    if ([[userProfile objectForKey:@"username"] isEqualToString:@""] && [[userProfile objectForKey:@"password"] isEqualToString:@""])
    {
        alert = [[UIAlertView alloc] initWithTitle:@"No account found"
                                           message:@"Please create an account before logging in."
                                          delegate:nil
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        if ([[[self userNameTextField] text] isEqualToString:[userProfile objectForKey:@"username"]] && [[[self passWordTextField] text] isEqualToString:[userProfile objectForKey:@"password"]])//Username and password matched
        {
            [[self userNameTextField] setText:@""];
            [[self passWordTextField] setText:@""];
            
            //Push ReminderManager onto navigation controller
            [self performSegueWithIdentifier:@"login" sender:self];
        }
        else
        {
            alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                               message:@"Incorrect username or password."
                                              delegate:nil
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
            [alert show];
            [[self userNameTextField] setText:@""];
            [[self passWordTextField] setText:@""];
        }
    }
}

//Returns the location of the file saved on the device
- (NSURL *) fileLocation
{
    NSURL *documentDirectory = [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory
                                                                      inDomains:NSUserDomainMask] lastObject];
    return [NSURL URLWithString:@"UserProfile"
                  relativeToURL:documentDirectory];
}

@end
