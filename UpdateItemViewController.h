//
//  UpdateItemViewController.h
//  WhatSale
//
//  Created by hsk5260 on 11/4/12.
//  Copyright (c) 2012 Pratik Rasam(psr5529) , Pankaj Deshmukh(pbd6595), Himanshu Kale (hsk5260@rit.edu). All rights reserved.
//

#import <UIKit/UIKit.h>
@class Listing;

@interface UpdateItemViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *itemImagePreview;
@property(nonatomic, strong) UIImage *imageToPost;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (nonatomic, strong) Listing *selectedListing;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UITextField *contactTextField;

- (IBAction)dateTextFieldPressed:(id)sender;
- (IBAction)postImageToCloudMine:(id)sender;
- (IBAction)nameEntered:(id)sender;
- (IBAction)priceEntered:(id)sender;
- (IBAction)contactEntered:(id)sender;

/**
 *  The function that will be called after done button is pressed on date picker
 **/
- (void)doneEditingDate;

/**
 *  Fetch the specified image from cloudmine
 *
 *  @param fileName - The name of the image file to fetch from cloudmine
 **/
-(void)fetchImageFromCloudMine:(NSString *)fileName;

@end
