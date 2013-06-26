//
//  ChangePasswordViewController.h
//  WhatSale
//
//  Created by psr5529 on 11/12/12.
//  Copyright (c) 2012 Pratik Rasam(psr5529) , Pankaj Deshmukh(pbd6595), Himanshu Kale (hsk5260@rit.edu). All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CloudMine/CloudMine.h>
#import "User.h"

@interface ChangePasswordViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)submitNewPassword:(id)sender;
- (IBAction)passwordEntered:(id)sender;

@end
