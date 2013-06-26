//
//  WhatSaleAppDelegate.m
//  WhatSale
//
//  Created by psr5529 on 10/11/12.
//  Copyright (c) 2012 Pratik Rasam(psr5529) , Pankaj Deshmukh(pbd6595), Himanshu Kale (hsk5260@rit.edu). All rights reserved.
//

#import "WhatSaleAppDelegate.h"
#import "WhatSaleViewController.h"
#import <CloudMine/CloudMine.h>

@implementation WhatSaleAppDelegate

@synthesize navigationController;

static NSString * const kAppIdentifier = @"58b4026e88f645029f8f0399ae82c48d";
static NSString * const kAppSecret = @"c04ccf8995364be7b02860acb445dbaa";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  //Cloudmine Credentials
    [[CMAPICredentials sharedInstance] setAppIdentifier:kAppIdentifier];
    [[CMAPICredentials sharedInstance] setAppSecret:kAppSecret];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    self.viewController = [[WhatSaleViewController alloc] initWithNibName:@"WhatSaleViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    
    navigationController= [[UINavigationController alloc] initWithRootViewController:self.viewController];
    [self.window addSubview:[navigationController view]];
    [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:0.45f green:0.45f blue:0.45f alpha:1.0f]];
    
    [self.window makeKeyAndVisible];
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

@end
