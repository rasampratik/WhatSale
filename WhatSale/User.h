//
//  User.h
//  WhatSale
//
//  Created by psr5529 on 10/13/12.
//  Copyright (c) 2012 Pratik Rasam(psr5529) , Pankaj Deshmukh(pbd6595), Himanshu Kale (hsk5260@rit.edu). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MainScreenViewController.h"
#import "Session.h"
#import <CloudMine/CloudMine.h>

@class Listing;

@interface User : CMObject <CLLocationManagerDelegate>
{

}

@property(nonatomic,copy) NSString *userEmail;
@property(nonatomic, assign) NSInteger userRating;
@property(nonatomic, assign) CGFloat userLatitude;
@property(nonatomic, assign) CGFloat userLongitude;
@property(nonatomic, strong) NSMutableArray *listingsArray;
@property(nonatomic, strong) NSMutableArray *userListingsArray;
-(id)init;
-(void)addListingToArray:(Listing *)listing;
-(id)listingAtIndex:(NSInteger)index;

@end
