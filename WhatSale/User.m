//
//  User.m
//  WhatSale
//
//  Created by psr5529 on 10/13/12.
//  Copyright (c) 2012 Pratik Rasam(psr5529) , Pankaj Deshmukh(pbd6595), Himanshu Kale (hsk5260@rit.edu). All rights reserved.
//

#import "User.h"
#import "Listing.h"
#import "Session.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CloudMine/CloudMine.h>

#define kUserEmailKey       @"UserEmailKey"
#define kUserRatingKey      @"UserRatingKey"
#define kUserIDKey          @"UserIDKey"
#define kUserLatitudeKey    @"UserLatitudeKey"
#define kUserLongitudeKey   @"UserLongitudeKey"

@implementation User

@synthesize userEmail = _userEmail;
@synthesize userRating = _userRating;
@synthesize listingsArray = _listingsArray;
@synthesize userLatitude = _userLatitude;
@synthesize userLongitude = _userLongitude;
@synthesize userListingsArray = _userListingsArray;
-(id)init{
    self = [super init];
    if(self) {
        self.userEmail = [Session shared].currentUser.userId;
        self.listingsArray = [[NSMutableArray alloc] init];
        self.userListingsArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:self.userEmail forKey:kUserEmailKey];
    [aCoder encodeInteger:self.userRating forKey:kUserRatingKey];
    [aCoder encodeFloat:self.userLatitude forKey:kUserLatitudeKey];
    [aCoder encodeFloat:self.userLongitude forKey:kUserLongitudeKey];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if(self) {
        self.userEmail = [aDecoder decodeObjectForKey:kUserEmailKey];
        self.userRating = [aDecoder decodeIntegerForKey:kUserRatingKey];
        self.userLatitude = [aDecoder decodeFloatForKey:kUserLatitudeKey];
        self.userLongitude = [aDecoder decodeFloatForKey:kUserLongitudeKey];
    }
    return self;
}

-(BOOL)isEqual:(id)object {
    BOOL result = NO;
    
    if([object isKindOfClass:[User class]]) {
        User *otherUser = (User *)object;
        if([self.userEmail isEqualToString:otherUser.userEmail]) {
            result = YES;
        }
    }
    return result;
}

-(void)addListingToArray:(Listing *)listing {
    [self.listingsArray addObject:listing];
}

-(id)listingAtIndex:(NSInteger)index {
      return [self.userListingsArray objectAtIndex:index];
   
}

@end
