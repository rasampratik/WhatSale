//
//  Listing.m
//  WhatSale
//
//  Created by psr5529 on 10/13/12.
//  Copyright (c) 2012 Pratik Rasam(psr5529) , Pankaj Deshmukh(pbd6595), Himanshu Kale (hsk5260@rit.edu). All rights reserved.
//

#import "Listing.h"

#define kListingNameKey             @"ListingNameKey"
#define kListingDateKey             @"ListingDateKey"
#define kListingPriceKey            @"ListingPriceKey"
#define kUserIDKey                  @"UserIDKey"
#define kListingLatitudeKey         @"ListingLatitudeKey"
#define kListingLongitudeKey        @"ListingLongitudeKey"
#define kListingImageFileNameKey    @"ListingImageFileNameKey"
#define kListingDescriptionKey      @"ListingDescriptionKey"
#define kListingContactKey          @"ListingContactKey"

@implementation Listing

@synthesize listingName = _listingName;
@synthesize listingDate = _listingDate;
@synthesize listingPrice = _listingPrice;
@synthesize userID = _userID;
@synthesize listingLatitude = _listingLatitude;
@synthesize listingLongitude = _listingLongitude;
@synthesize listingImage = _listingImage;
@synthesize listingImageFileName = _listingImageFileName;
@synthesize listingDescription = _listingDescription;
@synthesize listingContact = _listingContact;

-(id)initWithUserID:(NSString *)userID {
    self = [super init];
    if(self) {
        self.userID = userID;
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:self.listingName forKey:kListingNameKey];
    [aCoder encodeObject:self.listingDate forKey:kListingDateKey];
    [aCoder encodeFloat:self.listingPrice forKey:kListingPriceKey];
    [aCoder encodeObject:self.userID forKey:kUserIDKey];
    [aCoder encodeFloat:self.listingLatitude forKey:kListingLatitudeKey];
    [aCoder encodeFloat:self.listingLongitude forKey:kListingLongitudeKey];
    [aCoder encodeObject:self.listingImageFileName forKey:kListingImageFileNameKey];
    [aCoder encodeObject:self.listingDescription forKey:kListingDescriptionKey];
    [aCoder encodeObject:self.listingContact forKey:kListingContactKey];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if(self) {
        self.listingName = [aDecoder decodeObjectForKey:kListingNameKey];
        self.listingDate = [aDecoder decodeObjectForKey:kListingDateKey];
        self.listingPrice = [aDecoder decodeFloatForKey:kListingPriceKey];
        self.userID = [aDecoder decodeObjectForKey:kUserIDKey];
        self.listingLatitude = [aDecoder decodeFloatForKey:kListingLatitudeKey];
        self.listingLongitude = [aDecoder decodeFloatForKey:kListingLongitudeKey];
        self.listingImageFileName = [aDecoder decodeObjectForKey:kListingImageFileNameKey];
        self.listingDescription = [aDecoder decodeObjectForKey:kListingDescriptionKey];
        self.listingContact = [aDecoder decodeObjectForKey:kListingContactKey];
    }
    return self;
}

-(BOOL)isEqual:(id)object {
    BOOL result = NO;
    
    if([object isKindOfClass:[Listing class]]) {
        Listing *otherListing = (Listing *)object;
        if([self.listingName isEqualToString:otherListing.listingName]) {
            result = YES;
        }
    }
    return result;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"Name: %@ ExpiryDate: %@ Price: %f UserID: %@ Latitude: %f Longitude: %f", self.listingName, self.listingDate, self.listingPrice, self.userID, self.listingLatitude, self.listingLongitude];
}

@end
