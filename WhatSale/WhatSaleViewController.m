//
//  WhatSaleViewController.m
//  WhatSale
//
//  Created by psr5529 on 10/11/12.
//  Copyright (c) 2012 Pratik Rasam(psr5529) , Pankaj Deshmukh(pbd6595), Himanshu Kale (hsk5260@rit.edu). All rights reserved.
//

#import "WhatSaleViewController.h"
#import "MainScreenViewController.h"
#import "Session.h"
@interface WhatSaleViewController ()

@end

@implementation WhatSaleViewController
@synthesize loginTextfield=_loginTextfield;
@synthesize passwordTextfield=_passwordTextfield;
@synthesize statusTextfield=_statusTextfield;
@synthesize loginButton=_loginButton;
- (void)viewDidLoad
{
    [super viewDidLoad];
	 [self.navigationItem setTitle:@"Welcome"];
  [self.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.loginTextfield.text = @"";
    self.passwordTextfield.text = @"";
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
- (void)login{
    
    dispatch_queue_t queue= dispatch_queue_create("SessionQueue", nil);
    //bool success=NO;
    //[[Session shared] login:_loginTextfield.text password:_passwordTextfield.text];
    
    NSString *userID= _loginTextfield.text ;
    NSString *password=_passwordTextfield.text;
    
    
    dispatch_async(queue,^{
        
        CMUser *user;
        user = [[CMUser alloc] initWithUserId:userID andPassword:password];
        
        [user loginWithCallback:^(CMUserAccountResult resultCode, NSArray *messages) {
            switch(resultCode) {
                case CMUserAccountLoginSucceeded:
                    [Session shared].isSet=YES;
                    [Session shared].currentUser=user;
                    [Session shared].currentUser.password = password;
                    break;
                case CMUserAccountLoginFailedIncorrectCredentials:
                    // the users credentials were invalid
                    [Session shared].isSet=NO;
                    break;
                case CMUserAccountOperationFailedUnknownAccount:
                    // this account doesn't exist
                    break;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if([[Session shared] isSet]==YES){
                    // _statusTextfield.text=@"Login Successfull";
                    MainScreenViewController *mainView=[MainScreenViewController new];
                    [self.navigationController pushViewController:mainView animated:YES];
                    
                }
                else{
                    [self showMessage:@"Login Failed"];
                }
                
                
            });//main queue ends
            
        }];//innner block ends
        
        
        
    });//queue ends
}

-(IBAction)signup:(id)sender{
   [[Session shared] signup:_loginTextfield.text password:_passwordTextfield.text];
    if([Session shared].isSet) {
        [self showMessage:@"Registration Successful"];
    }
    else {
        [self showMessage:@"Registration Failed!"];
    }
}

- (IBAction)emailEntered:(id)sender {
    [self.loginTextfield resignFirstResponder];
}

- (IBAction)passwordEntered:(id)sender {
    [self.passwordTextfield resignFirstResponder];
}

-(void)showMessage:(NSString *) message{
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Message" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}
@end
