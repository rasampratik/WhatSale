//
//  Session.h
//  WhatSale
//
//  Created by psr5529 on 10/13/12.
//  Copyright (c) 2012 Pratik Rasam(psr5529) , Pankaj Deshmukh(pbd6595), Himanshu Kale (hsk5260@rit.edu). All rights reserved.
//
#import "User.h"
#import <Foundation/Foundation.h>
#import <CloudMine/CloudMine.h>

@class User;

@interface Session : NSObject
{

}

+(Session *)shared;

/**
 *  Function registers a new user in the whatsale app
 *
 *  @param username - Email address of the user
 *  @param password - password to use for account
 **/
-(void)signup:(NSString *)username password:(NSString *)password;

@property(nonatomic,assign) CMUser *currentUser;
@property(nonatomic,nonatomic) User *thisUser;
@property(nonatomic,copy) CLLocation *deviceLocation;
@property(nonatomic,assign) BOOL isSet;
@property(nonatomic,assign) BOOL isUsedOnSimulator;

@end
