//
//  Listing.h
//  WhatSale
//
//  Created by psr5529 on 10/13/12.
//  Copyright (c) 2012 Pratik Rasam(psr5529) , Pankaj Deshmukh(pbd6595), Himanshu Kale (hsk5260@rit.edu). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MainScreenViewController.h"

@interface Listing : CMObject
{
    
}

@property(nonatomic, strong) NSString *listingName;
@property(nonatomic, assign) float listingPrice;
@property(nonatomic, strong) NSDate *listingDate;
@property(nonatomic, strong) NSString *userID;
@property(nonatomic, assign) CGFloat listingLatitude;
@property(nonatomic, assign) CGFloat listingLongitude;
@property(nonatomic, strong) UIImage *listingImage;
@property(nonatomic, strong) NSString *listingImageFileName;
@property(nonatomic, strong) NSString *listingDescription;
@property(nonatomic, assign) NSString *listingContact;

-(id)initWithUserID:(NSString *)userID;

@end
