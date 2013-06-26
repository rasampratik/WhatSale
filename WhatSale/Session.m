//
//  Session.m
//  WhatSale
//
//  Created by psr5529 on 10/13/12.
//  Copyright (c) 2012 Pratik Rasam(psr5529) , Pankaj Deshmukh(pbd6595), Himanshu Kale (hsk5260@rit.edu). All rights reserved.
//

#import "Session.h"
#import "User.h"
static Session * shared;

@implementation Session

@synthesize currentUser=currentUser;
@synthesize isSet = _isSet;
@synthesize thisUser = _thisUser;

+(Session *)shared{
    if(!shared)
    {
        shared = [[Session alloc] init];
        //  shared->inventories=[[NSMutableArray alloc] init];
    }
    
    return  shared;
}

-(void)signup:(NSString *)username password:(NSString *)password{
    CMUser *user;
    user = [[CMUser alloc] initWithUserId:username andPassword:password];
    [user createAccountAndLoginWithCallback:^(CMUserAccountResult result, NSArray *messages) {
        
        switch(result){
            case CMUserAccountLoginSucceeded:
                [Session shared].isSet = YES;
                break;
            case CMUserAccountPasswordChangeFailedInvalidCredentials:
                [Session shared].isSet = NO;
                break;
            default:
                [Session shared].isSet = NO;
                break;
        }
    }];
}


@end
