//
//  MainScreenViewController.h
//  WhatSale
//
//  Created by psr5529 on 10/18/12.
//  Copyright (c) 2012 Pratik Rasam(psr5529) , Pankaj Deshmukh(pbd6595), Himanshu Kale (hsk5260@rit.edu). All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "User.h"
#import "Session.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@class User;

@interface MainScreenViewController : UIViewController<CLLocationManagerDelegate>{
    
}

@property (weak, nonatomic) IBOutlet UIButton *sellButton;
@property (weak, nonatomic) IBOutlet UIButton *nearMeButton;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (strong, nonatomic) IBOutlet CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet CLGeocoder *geoCoder;

/**
 *  Function which will move to the seller view
 **/
-(void)sellButtonPressed;

/**
 * function which will move to the near me view
 **/
-(void)nearMeButtonPressed;

/**
 *  Function which will move to the buy view
 **/
-(void)buyButtonPressed;

/**
 *  Function which will log out the user and move back to the welcome screen
 **/
- (void)logoutButtonPressed;

@end
