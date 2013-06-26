//
//  UpdateItemViewController.m
//  WhatSale
//
//  Created by hsk5260 on 11/4/12.
//  Copyright (c) 2012 Pratik Rasam(psr5529) , Pankaj Deshmukh(pbd6595), Himanshu Kale (hsk5260@rit.edu). All rights reserved.
//

#import "UpdateItemViewController.h"
#import "SlidingDatePicker.h"
#import "ImageViewWithBorder.h"
#import "Listing.h"
#import "Session.h"

@interface UpdateItemViewController ()
@property (nonatomic, strong) SlidingDatePicker *dateView;
@end

@implementation UpdateItemViewController

@synthesize itemImagePreview = _itemImagePreview;
@synthesize imageToPost=_imageToPost;
@synthesize dateTextField = _dateTextField;
@synthesize nameTextField = _nameTextField;
@synthesize priceTextField = _priceTextField;
@synthesize selectedListing = _selectedListing;
@synthesize descriptionTextView = _descriptionTextView;
@synthesize contactTextField = _contactTextField;

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
    UIBarButtonItem *cameraBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takePicture:)];
    [self.navigationItem setTitle:@"Update Item"];
    [[self navigationItem] setRightBarButtonItem:cameraBarButton];
    
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGRect startRect = CGRectMake(0.0, screenRect.origin.y + screenRect.size.height - 320.0, self.view.bounds.size.width, 320.0);
    self.dateView = [[SlidingDatePicker alloc] initWithFrame:startRect];
    [self.dateView setMode:UIDatePickerModeDate];
    [self.dateView addTargetForDoneButton:self action:@selector(doneEditingDate)];
    [self.dateView setHidden:YES animated:NO];
    [[self view] addSubview:self.dateView];
    
    self.nameTextField.text = self.selectedListing.listingName;
    self.priceTextField.text = [NSString stringWithFormat:@"%.2f", self.selectedListing.listingPrice];
    [self.itemImagePreview setImage:self.selectedListing.listingImage withBorderWidth:1.0f];
    _imageToPost = self.selectedListing.listingImage;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM / dd / yyyy"];
    self.dateTextField.text = [dateFormatter stringFromDate:self.selectedListing.listingDate];
    self.contactTextField.text = self.selectedListing.listingContact;
    self.descriptionTextView.text = self.selectedListing.listingDescription;
    
    //set notification for when keyboard shows/hides
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UITextViewTextDidBeginEditingNotification
                                               object:self.descriptionTextView];
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UITextViewTextDidEndEditingNotification
                                               object:self.descriptionTextView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(phoneKeyboardWillShow:)
                                                 name:UITextFieldTextDidBeginEditingNotification
                                               object:self.contactTextField];
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(phoneKeyboardWillHide:)
                                                 name:UITextFieldTextDidEndEditingNotification
                                               object:self.contactTextField];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setItemImagePreview:nil];
    [self setDateTextField:nil];
    [self setNameTextField:nil];
    [self setPriceTextField:nil];
    [self setDescriptionTextView:nil];
    [self setContactTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self.descriptionTextView resignFirstResponder];
    }
    return YES;
}

-(void) keyboardWillShow:(NSNotification *)note{
    // get keyboard size and loction
	CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] getValue: &keyboardBounds];
    
	// get the height since this is the main value that we need.
	NSInteger kbSizeH = keyboardBounds.size.height + 80.0f;
    
	// get a rect for the form frame
	CGRect formFrame = self.view.frame;
	formFrame.origin.y -= kbSizeH;
    
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3f];
    
	// set views with new info
	self.view.frame = formFrame;
    
	// commit animations
	[UIView commitAnimations];
}

-(void) phoneKeyboardWillShow:(NSNotification *)note{
    // get keyboard size and loction
	CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] getValue: &keyboardBounds];
    
	// get the height since this is the main value that we need.
	NSInteger kbSizeH = keyboardBounds.size.height + 205.0f;
    
	// get a rect for the form frame
	CGRect formFrame = self.view.frame;
	formFrame.origin.y -= kbSizeH;
    
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3f];
    
	// set views with new info
	self.view.frame = formFrame;
    
	// commit animations
	[UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification *)note{
    // get keyboard size and loction
	CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    
	// get the height since this is the main value that we need.
	NSInteger kbSizeH = keyboardBounds.size.height + 80.0f;
    
	// get a rect for the form frame
	CGRect formFrame = self.view.frame;
	formFrame.origin.y += kbSizeH;
    
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3f];
    
	self.view.frame = formFrame;
    
	// commit animations
	[UIView commitAnimations];
}

-(void) phoneKeyboardWillHide:(NSNotification *)note{
    // get keyboard size and loction
	CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    
	// get the height since this is the main value that we need.
	NSInteger kbSizeH = keyboardBounds.size.height + 205.0f;
    
	// get a rect for the form frame
	CGRect formFrame = self.view.frame;
	formFrame.origin.y += kbSizeH;
    
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3f];
    
	self.view.frame = formFrame;
    
	// commit animations
	[UIView commitAnimations];
}

-(void)takePicture:(id) sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    else {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    [imagePicker setDelegate:self];
    imagePicker.allowsEditing = YES;
    [self presentModalViewController:imagePicker animated:YES];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *itemImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    _imageToPost=itemImage;
    [self.itemImagePreview setImage:itemImage withBorderWidth:1.0f];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)dateTextFieldPressed:(id)sender {
    [self.dateTextField resignFirstResponder];
    [self.dateView setHidden:NO animated:YES];
}

-(void)fetchImageFromCloudMine:(NSString *)fileName
{
    
    CMStore *store=[CMStore defaultStore];
    [store fileWithName:fileName additionalOptions:nil callback:^(CMFileFetchResponse *response) {
        NSData *imageData = response.file.fileData;
        
        UIImage *listingImage= [UIImage imageWithData:imageData];
        [self.itemImagePreview setImage:listingImage];
        
        
    }];
}

- (IBAction)postImageToCloudMine:(id)sender {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM / dd / yyyy"];
    
    if(![self.nameTextField.text isEqualToString:@""]&&![self.contactTextField.text isEqualToString:@""]&&![self.priceTextField.text isEqualToString:@""]&&![self.descriptionTextView.text isEqualToString:@""])
    {
        
        self.selectedListing.listingDate= [dateFormatter dateFromString:self.dateTextField.text];
        self.selectedListing.listingContact = self.contactTextField.text;
        self.selectedListing.listingName= self.nameTextField.text;
        self.selectedListing.listingPrice=self.priceTextField.text.floatValue;
        self.selectedListing.listingLatitude= [Session shared].thisUser.userLatitude;
        self.selectedListing.listingLongitude=[Session shared].thisUser.userLongitude;
        self.selectedListing.listingImage = _imageToPost;
        self.selectedListing.listingDescription = self.descriptionTextView.text;
        
        NSString *imageFileName= [[Session shared].thisUser.objectId stringByAppendingString:[self.selectedListing.objectId stringByAppendingString:@".jpg"]];
        self.selectedListing.listingImageFileName = imageFileName;
        
        
        if(_imageToPost != NULL)
        {
            NSData *imageData= [[NSData alloc]init];
            imageData=UIImageJPEGRepresentation(_imageToPost, 0.0);
            
            
            CMStore *store = [CMStore defaultStore];
            
            [store saveFileWithData:imageData
                              named:imageFileName
                  additionalOptions:nil
                           callback:^(CMFileUploadResponse *response) {
                               switch(response.result) {
                                   case CMFileCreated:
                                       [self showMessage:@"Image Saved"];
                                       break;
                                   case CMFileUpdated:
                                       [self showMessage:@"Image Updated"];
                                       break;
                                   case CMFileUploadFailed:
                                       [self showMessage:@"Error: Could not upload image"];
                                       break;
                               }
                           }
             ];
            [self.selectedListing save:^(CMObjectUploadResponse *response) {
                if ((![[response.uploadStatuses objectForKey:self.selectedListing.objectId] isEqualToString:@"updated"])) {
                    
                    // Alert the user
                    NSString *message = @"The listing could not be updated";
                    if (response.error)
                        message = [response.error localizedDescription];
                    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error: listing could not be updated" message:[response.error localizedDescription] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                    [errorAlert show];
                }
                else
                {
                    //update listing array
                    [self showMessage:@"Item Listing Updated"];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
            
            
            
        }//end of outer if
        else
        {
            [self showMessage:@"Error: Image not selected"];
            
        }
    }
    else {
        [self showMessage:@"Error: Please enter all item details"];
    }
}

- (void)doneEditingDate {
    
    [self.dateView setHidden:YES animated:YES];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM / dd / yyyy"];
    [self.dateTextField setText:[dateFormatter stringFromDate:self.dateView.datePicker.date]];
}

- (IBAction)nameEntered:(id)sender {
    [self.nameTextField resignFirstResponder];
}

- (IBAction)priceEntered:(id)sender {
    [self.priceTextField resignFirstResponder];
}

- (IBAction)contactEntered:(id)sender {
    [self.contactTextField resignFirstResponder];
    
    self.contactTextField.text = [self.contactTextField.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    if(self.contactTextField.text.length == 10) {
        NSRange range;
        range.length = 3;
        range.location = 3;
        
        self.contactTextField.text = [NSString stringWithFormat:@"%@-%@-%@", [self.contactTextField.text substringToIndex:3], [self.contactTextField.text substringWithRange:range], [self.contactTextField.text substringFromIndex:6]];
    }
    else {
        [self showMessage:@"Error: Phone number must be 10 digits"];
    }
}

-(void)showMessage:(NSString *) message{
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Message" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

@end
