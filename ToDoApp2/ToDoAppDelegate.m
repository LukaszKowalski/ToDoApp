//
//  ToDoAppDelegate.m
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 8/4/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import "ToDoAppDelegate.h"
#import "DoTask.h"
#import "DoUser.h"
#import "DataStore.h"


@implementation ToDoAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    LoginViewController *viewController = [[LoginViewController alloc] init];
    UINavigationController *navCon = [[UINavigationController alloc] init];
    
//    [navCon pushViewController:friendsView animated:NO];
    [navCon pushViewController:viewController animated:NO];
    
    self.window.rootViewController = navCon;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // Parse
    
    [Parse setApplicationId:@"PJt6c9KbdOPePbHoekH29GP0IdoAoUWvmzmcP0fJ"
                  clientKey:@"A7Jfs6Fxa7z3S1UXlCk32dIzqtrECEWq3JJ6Eqfl"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    // Parse notification
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                        UIUserNotificationTypeBadge |
                                                        UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                                 categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    } else {
        // Register for Push Notifications before iOS 8
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                         UIRemoteNotificationTypeAlert |
                                                         UIRemoteNotificationTypeSound)];
    }
    
    
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
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    currentInstallation.channels = @[ @"global" ];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}

//    DoUser *user = [DoUser new];
//    user.userIdNumber = [self getRandomId];
//    user.username =@"Lucasz";
//
//    DoUser *user2 = [DoUser new];
//    user2.userIdNumber = [self getRandomId];
//    user2.username =@"Phil";
//
//    DoTask *task = [DoTask new];
//    task.idNumber = [self getRandomId];
//    task.userIdNumber = user.userIdNumber;
//    task.taskString =@"Task One";
//
//    DoTask *task2 = [DoTask new];
//    task2.idNumber = [self getRandomId];
//    task2.userIdNumber = user2.userIdNumber;
//    task2.taskString =@"Task One";
//
//    NSArray *userArray = @[user,user2];
//    NSArray *tasksArray = @[task,task2];
//
//    [[DataStore sharedInstance] saveData:userArray withKey:@"userArray"];
//    [[DataStore sharedInstance] saveData:tasksArray withKey:@"tasksArray"];
//
//



-(NSString *)getRandomId
{
    CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
    NSString * uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
    CFRelease(newUniqueId);
    return uuidString;
}


@end
