//
//  ItemDetailViewController.m
//  WhatSale
//
//  Created by hsk5260 on 11/7/12.
//  Copyright (c) 2012 Pratik Rasam(psr5529) , Pankaj Deshmukh(pbd6595), Himanshu Kale (hsk5260@rit.edu). All rights reserved.
//

#import "ItemDetailViewController.h"
#import "Listing.h"
#import "ImageViewWithBorder.h"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController
@synthesize nameTextField;
@synthesize priceTextField;
@synthesize dateTextField;
@synthesize descriptionTextView;
@synthesize itemImagePreview;

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
    self.nameTextField.text = self.selectedListing.listingName;
    self.priceTextField.text = [NSString stringWithFormat:@"%.2f", self.selectedListing.listingPrice];
    [self.itemImagePreview setImage:self.selectedListing.listingImage withBorderWidth:1.0f];
    [self.navigationItem setTitle:@"Item Details"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM / dd / yyyy"];
    self.dateTextField.text = [dateFormatter stringFromDate:self.selectedListing.listingDate];
    self.descriptionTextView.text = self.selectedListing.listingDescription;
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setNameTextField:nil];
    [self setPriceTextField:nil];
    [self setDateTextField:nil];
    [self setDescriptionTextView:nil];
    [self setItemImagePreview:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)contactButtonPressed:(id)sender {
    NSString *callNumber = [NSString stringWithFormat:@"Call %@",self.selectedListing.listingContact ];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:callNumber delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Call", nil];
    [alert show];
    alert.tag = 1;
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (alertView.tag) {
        case 1:
            if (buttonIndex == 1) {
                NSString *strURL = [NSString stringWithFormat:@"tel:%@",self.selectedListing.listingContact];
                NSURL *url = [NSURL URLWithString:strURL];
                
                [[UIApplication sharedApplication] openURL:url];
            }
            break;
        default:
            break;
    }
}
@end
