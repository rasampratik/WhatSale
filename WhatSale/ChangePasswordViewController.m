//
//  ChangePasswordViewController.m
//  WhatSale
//
//  Created by psr5529 on 11/12/12.
//  Copyright (c) 2012 Pratik Rasam(psr5529) , Pankaj Deshmukh(pbd6595), Himanshu Kale (hsk5260@rit.edu). All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "Session.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController
@synthesize passwordTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    UINavigationBar *naviBar =[[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButtonPressed)];
    UINavigationItem *naviItem = [[UINavigationItem alloc] initWithTitle:@"Reset Password"];
    [naviItem setLeftBarButtonItem:cancelButton];
    naviBar.items = [NSArray arrayWithObject:naviItem];
    [self.view addSubview:naviBar];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setPasswordTextField:nil];
    [self setPasswordTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)submitNewPassword:(id)sender {
    
    CMUser *user = [Session shared].currentUser;

    [user changePasswordTo:self.passwordTextField.text
                      from:user.password
                  callback:^(CMUserAccountResult resultCode, NSArray *messages) {
                      switch(resultCode) {
                          case CMUserAccountPasswordChangeSucceeded:
                              [self showMessage:@"Password Reset Successfully"];
                              // success!
                              break;
                          case CMUserAccountPasswordChangeFailedInvalidCredentials:
                              // the users credentials were invalid
                              break;
                          case CMUserAccountOperationFailedUnknownAccount:
                              // this account doesn't exist
                              break;
                      }
                  }];
}

-(void)showMessage:(NSString *) message{
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Message" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
    [self dismissModalViewControllerAnimated:YES];
}

-(void)cancelButtonPressed {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)passwordEntered:(id)sender {
    [self.passwordTextField resignFirstResponder];
}
@end
