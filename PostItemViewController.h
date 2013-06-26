//
//  PostItemViewController.h
//  WhatSale
//
//  Created by hsk5260 on 10/18/12.
//  Copyright (c) 2012 Pratik Rasam(psr5529) , Pankaj Deshmukh(pbd6595), Himanshu Kale (hsk5260@rit.edu). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostItemViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *itemImagePreview;
@property(nonatomic, strong) UIImage *imageToPost;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UITextField *contactTextField;

- (IBAction)dateTextFieldPressed:(id)sender;
- (IBAction)postImageToCloudMine:(id)sender;
- (IBAction)nameEntered:(id)sender;
- (IBAction)priceEntered:(id)sender;
- (IBAction)contactEntered:(id)sender;

/**
 *  Function which displays a UIAlertView using the given string message
 *
 *  @param message - The string to be displayed as message
 **/
-(void)showMessage:(NSString *) message;

/**
 *  Function which will be called when the done button is pressed on the date picker
 **/
- (void)doneEditingDate;

/**
 *  Function which fetches the image file specified from cloudmine
 *
 *  @param fileName - name of the image file to be fetched
 **/
-(void)fetchImageFromCloudMine:(NSString *)fileName;

@end
