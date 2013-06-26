//
//  ItemDetailViewController.h
//  WhatSale
//
//  Created by hsk5260 on 11/7/12.
//  Copyright (c) 2012 Pratik Rasam(psr5529) , Pankaj Deshmukh(pbd6595), Himanshu Kale (hsk5260@rit.edu). All rights reserved.
//

#import <UIKit/UIKit.h>

@class Listing;

@interface ItemDetailViewController : UIViewController

@property (nonatomic, strong) Listing *selectedListing;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIImageView *itemImagePreview;

- (IBAction)contactButtonPressed:(id)sender;

@end
