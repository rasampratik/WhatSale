//
//  ItemTableViewController.m
//  WhatSale
//
//  Created by hsk5260 on 10/18/12.
//  Copyright (c) 2012 Pratik Rasam(psr5529) , Pankaj Deshmukh(pbd6595), Himanshu Kale (hsk5260@rit.edu). All rights reserved.
//

#import "ItemTableViewController.h"
#import "ItemTableViewCell.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "PostItemViewController.h"
#import "Session.h"
#import "Listing.h"
#import "ImageViewWithBorder.h"
#import "UpdateItemViewController.h"

@interface ItemTableViewController ()

@end

@implementation ItemTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self.navigationItem setTitle:@"Listings"];
    UIBarButtonItem *postItemButton = [[UIBarButtonItem alloc] initWithTitle:@"Post" style:UIBarButtonItemStyleBordered target:self action:@selector(postItemButtonPressed)];
    
    [[self navigationItem] setRightBarButtonItem:postItemButton];
    [self loadListingsFromCloudmine];
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewDidAppear:(BOOL)animated {
    
    // Reload the table after it returns from another view
    [super viewDidAppear:animated];
    [Session shared].thisUser.userListingsArray = [[NSMutableArray alloc] init];
    [self loadListingsFromCloudmine];
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [[Session shared].thisUser.userListingsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ItemTableViewCell";
    Listing *tempListing = [[Session shared].thisUser listingAtIndex:indexPath.row];
    ItemTableViewCell *cell = (ItemTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ItemTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    // Code for tap gesture on table cell
    if([cell.gestureRecognizers count] == 0) {
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        singleTap.numberOfTapsRequired = 1;
        singleTap.numberOfTouchesRequired = 1;
        [cell addGestureRecognizer:singleTap];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.itemNameLabel.text = tempListing.listingName;
    
    cell.itemCostLabel.text = [NSString stringWithFormat:@"%0.2f", tempListing.listingPrice];
    NSString* fileName = tempListing.listingImageFileName;
    CMStore *store=[CMStore defaultStore];
    
    if(tempListing.listingImage == NULL) {
        [store fileWithName:fileName additionalOptions:nil callback:^(CMFileFetchResponse *response) {
            NSData *imageData = response.file.fileData;
            
            UIImage* listingImage= [UIImage imageWithData:imageData];
            [cell.itemImageView setImage:listingImage withBorderWidth:1.0f];
            tempListing.listingImage = listingImage;
            
        }];
    }
    
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 107.0;
}

-(void)postItemButtonPressed {
    PostItemViewController *postItemViewInstance = [PostItemViewController new];
    [self.navigationController pushViewController:postItemViewInstance animated:YES];
}

-(void)singleTap:(UITapGestureRecognizer *)tap {
    if(UIGestureRecognizerStateEnded == tap.state) {
        UITableViewCell *cell = (UITableViewCell *)tap.view;
        UITableView *tableView = (UITableView *)cell.superview;
        NSIndexPath *indexPath = [tableView indexPathForCell:cell];
        Listing *tempListing = [[Session shared].thisUser listingAtIndex:indexPath.row];
        UpdateItemViewController *updateItemViewInstance = [UpdateItemViewController new];
        updateItemViewInstance.selectedListing = tempListing;
        [self.navigationController pushViewController:updateItemViewInstance animated:YES];
    }
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/**
 * Download complete listings from Cloudmine and reload it into the array
 */
- (void)loadListingsFromCloudmine {
    CMStore *store = [CMStore defaultStore];
    
    dispatch_queue_t queue1 = dispatch_queue_create("myQueue", NULL);
    
    dispatch_async(queue1, ^{
        
        // Begin to fetch all of the inventories
        [store allObjectsOfClass:[Listing class] additionalOptions:nil callback: ^(CMObjectFetchResponse *response) {
            
            // If an error occurred, alert the user!
            if (response.error) {
                UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error fetching listings" message:[response.error localizedDescription]                delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                [errorAlert show];
            }
            
            // Replace local inventories with those loaded from the server
            if (response.objects.count) {
                if (![Session shared].thisUser.listingsArray) {
                    [Session shared].thisUser.listingsArray = [[NSMutableArray alloc] init];
                }
                else {
                    [[Session shared].thisUser.listingsArray removeAllObjects];
                }
                
                NSString* thisUserID = [Session shared].thisUser.userEmail;
                
                for (Listing *listing in response.objects) {
                    
                    if([thisUserID isEqualToString:listing.userID])
                        [[Session shared].thisUser.userListingsArray addObject:listing];
                    
                    
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }];
        
    });
    
}

@end
