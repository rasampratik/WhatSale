//
//  MainScreenViewController.m
//  WhatSale
//
//  Created by psr5529 on 10/18/12.
//  Copyright (c) 2012 Pratik Rasam(psr5529) , Pankaj Deshmukh(pbd6595), Himanshu Kale (hsk5260@rit.edu). All rights reserved.
//

#import "MainScreenViewController.h"
#import "User.h"
#import "ItemTableViewController.h"
#import "Listing.h"
#import "NearMeViewController.h"
#import "BuyViewController.h"
#import <CloudMine/CloudMine.h>
#import "WhatSaleViewController.h"
#import "ChangePasswordViewController.h"

@interface MainScreenViewController ()

@end

@implementation MainScreenViewController

@synthesize locationManager = _locationManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
    }
    return self;
}

- (void)dealloc {
    // Set all delegates to nil in your dealloc method for the object owner
    [self.locationManager setDelegate:nil];
}

- (void)viewDidLoad
{
    [self.navigationItem setTitle:@"Home"];
    
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleBordered target:self action:@selector(logoutButtonPressed)];
    [[self navigationItem] setLeftBarButtonItem:logoutButton];
    UIBarButtonItem *changePasswordButton = [[UIBarButtonItem alloc] initWithTitle:@"Reset Password" style:UIBarButtonItemStyleBordered target:self action:@selector(changePasswordButtonPressed)];
    self.navigationItem.rightBarButtonItem = changePasswordButton;
    
    [self.sellButton addTarget:self action:@selector(sellButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.nearMeButton addTarget:self action:@selector(nearMeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.buyButton addTarget:self action:@selector(buyButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [Session shared].thisUser = [[User alloc] init];
    
    self.locationManager.delegate = self;
    
    //Get user location
    [self.locationManager startUpdatingLocation];
    
    [self.geoCoder reverseGeocodeLocation: self.locationManager.location completionHandler:
     ^(NSArray *placemarks, NSError *error) {
         
         //Get nearby address
         CLPlacemark *placemark = [placemarks objectAtIndex:0];
         
         //Store latitude and longitude of user
         [Session shared].thisUser.userRating = 10;
         [Session shared].thisUser.userLatitude = placemark.location.coordinate.latitude;
         [Session shared].thisUser.userLongitude = placemark.location.coordinate.longitude;
         if([Session shared].thisUser.userLatitude==0 && [Session shared].thisUser.userLatitude==0)
         {
             UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Simulator in Use" message:@"This application is being run in a simulator, please set the simulated location,else default location will be selected to Rochester,NY" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [errorAlert show];
             [Session shared].thisUser.userLatitude = 43.165556;
             
             [Session shared].thisUser.userLongitude = -77.611389;
         }
     }];
    // Do any additional setup after loading the view from its nib.
    
    [super viewDidLoad];
}

#pragma mark - CLLocationManagerDelegate Method

-(void)viewDidAppear:(BOOL)animated{
    [Session shared].thisUser.userListingsArray = [[NSMutableArray alloc] init];
    [self loadListingsFromCloudmine];
}
- (void)viewDidUnload
{
    [self setLocationManager:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)sellButtonPressed {
    
    ItemTableViewController *sellItemViewInstance = [ItemTableViewController new];
    [self.navigationController pushViewController:sellItemViewInstance animated:YES];
}
-(void)nearMeButtonPressed {
    
    NearMeViewController *nearMeViewInstance = [NearMeViewController new];
    nearMeViewInstance.isBuySearch=NO;
    [self.navigationController pushViewController:nearMeViewInstance animated:YES];
}
-(void)buyButtonPressed {
    
    BuyViewController *buyViewInstance = [BuyViewController new];
    [self.navigationController pushViewController:buyViewInstance animated:YES];
}
- (void)loadListingsFromCloudmine {
    CMStore *store = [CMStore defaultStore];
    
    dispatch_queue_t queue1 = dispatch_queue_create("myQueue", NULL);
    
    dispatch_async(queue1, ^{
        
        // Begin to fetch all of the inventories
        [store allObjectsOfClass:[Listing class] additionalOptions:nil callback: ^(CMObjectFetchResponse *response) {
            
            // If an error occurred, alert the user!
            if (response.error) {
                UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error fetching listings" message:[response.error localizedDescription]                delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                [errorAlert show];
            }
            
            // Replace local inventories with those loaded from the server
            if (response.objects.count) {
                if (![Session shared].thisUser.listingsArray) {
                    [Session shared].thisUser.listingsArray = [[NSMutableArray alloc] init];
                }
                else {
                    [[Session shared].thisUser.listingsArray removeAllObjects];
                }
                NSString* thisUserID = [Session shared].thisUser.userEmail;
                
                for (Listing *listing in response.objects) {
                    
                    if(![thisUserID isEqualToString:listing.userID])
                        
                        [[Session shared].thisUser addListingToArray:listing];
                    
                }//end for
            }//end outer if
            dispatch_async(dispatch_get_main_queue(), ^{
                //               [self.tableView reloadData];
            });
        }];
        
    });
}

- (void)logoutButtonPressed
{
    [[Session shared].currentUser logoutWithCallback:^(CMUserAccountResult resultCode, NSArray *messages) {
        switch(resultCode) {
            case CMUserAccountLogoutSucceeded:
                // success! the user is logged out
                
                break;
            case CMUserAccountOperationFailedUnknownAccount:
                // failed, the session token didn't correspond to any user
                break;
        }
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)changePasswordButtonPressed{
    ChangePasswordViewController *changePasswordViewInstance = [ChangePasswordViewController new];
    [self.navigationController presentModalViewController:changePasswordViewInstance animated:YES];
    //[self.navigationController pushViewController:changePasswordViewInstance animated:YES];
}

@end
