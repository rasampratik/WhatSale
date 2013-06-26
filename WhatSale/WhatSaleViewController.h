//
//  WhatSaleViewController.h
//  WhatSale
//
//  Created by psr5529 on 10/11/12.
//  Copyright (c) 2012 Pratik Rasam(psr5529) , Pankaj Deshmukh(pbd6595), Himanshu Kale (hsk5260@rit.edu). All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CloudMine/CloudMine.h>

@interface WhatSaleViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak,nonatomic) IBOutlet UITextField *loginTextfield;
@property (weak,nonatomic) IBOutlet UITextField *passwordTextfield;
@property (weak,nonatomic) IBOutlet UILabel *statusTextfield;

- (IBAction)emailEntered:(id)sender;
- (IBAction)signup:(id)sender;
- (IBAction)passwordEntered:(id)sender;

/**
 *  The login function for logging into whatsale app
 **/
-(void)login;

@end
