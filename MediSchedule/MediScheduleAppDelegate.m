/*
 *  MediScheduleAppDelegate.m
 *  MediSchedule
 *
 *  Implementation file for MediScheduleAppDelegate class
 *
 *  Programmers:
 *  Ishan Bhutani
 *  Ning Chai
 *  Zheren Lu
 *  Justin Wang
 *
 *  Copyright (c) 2013 Team 0x0A
 */

#import "MediScheduleAppDelegate.h"
#import "GlobalVariables.h"
#import "PillManager.h"
#import "ReminderManager.h"

@interface MediScheduleAppDelegate()
{
    ReminderManager *reminderManager;
    PillManager *pillManager;
    GlobalVariables *globalVariables;
}
@end

@implementation MediScheduleAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    globalVariables = [GlobalVariables getInstance];
    reminderManager = globalVariables.reminderManager;
    pillManager = globalVariables.pillManager;
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    application.applicationIconBadgeNumber = 0;
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSDictionary *infoDict = [notification userInfo];
    NSString *pillName = [pillManager nameOfPillWithId:[[infoDict objectForKey:@"pillId"] integerValue]];
    int dosage = [[infoDict objectForKey:@"dosage"] integerValue];
    UIImage *image = [pillManager imageOfPillWithId:[[infoDict objectForKey:@"pillId"] integerValue]];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(75, 150, 125, 125)];
    [imageView setImage:image];
    
    NSString *notes = [infoDict objectForKey:@"notes"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[[NSString alloc] initWithFormat:@"Take %dmg of %@", dosage, pillName]
                                                    message:notes
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert addSubview:imageView];
    [alert show];
}

@end
