//
//  BuyViewController.m
//  WhatSale
//
//  Created by psr5529 on 11/3/12.
//  Copyright (c) 2012 Pratik Rasam(psr5529) , Pankaj Deshmukh(pbd6595), Himanshu Kale (hsk5260@rit.edu). All rights reserved.
//

#import "BuyViewController.h"
#import "Session.h"
#import "Listing.h"
#import "NearMeViewController.h"
#import "ItemTableViewCell.h"
#import "ImageViewWithBorder.h"
#import "ItemDetailViewController.h"

@interface BuyViewController ()
{
    NSMutableArray *totalListings;
    NSMutableArray *fileteredListings;
    bool isFilterd;
}
@end

@implementation BuyViewController
@synthesize searchCriteriaBar;
@synthesize buySearchBar;
@synthesize buyTableView;

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
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Buy Item"];

    self.buySearchBar.delegate = self;
    self.buyTableView.delegate = self;
    self.buyTableView.dataSource = self;
    totalListings = [NSMutableArray alloc];
    totalListings = [[Session shared].thisUser listingsArray];
}

//This method is called when something is typed inside the search bar
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{

}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if(searchBar.text.length == 0) {
        isFilterd = NO;
    }
    else
    {
        isFilterd = YES;
        if(self.searchCriteriaBar.selectedSegmentIndex == 0) {
            fileteredListings = [[NSMutableArray alloc] init];
            for(Listing *list in totalListings) {
                NSString * temp;
                temp = [list listingName];
                NSRange searchRange = [temp rangeOfString:searchBar.text options:NSCaseInsensitiveSearch];
                if(searchRange.location != NSNotFound){
                    [fileteredListings addObject:list];
                }
            }
        }
        else if (self.searchCriteriaBar.selectedSegmentIndex == 1) {
            fileteredListings = [[NSMutableArray alloc] init];
            for(Listing *list in totalListings) {
                CGFloat price;
                price = [list listingPrice];
                if(price < searchBar.text.floatValue) {
                    [fileteredListings addObject:list];
                }
            }
        }
    }
    [self.buyTableView reloadData];
    [self.buySearchBar resignFirstResponder];
}

//table view delegate methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(isFilterd)
    {
        return [fileteredListings count];
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ItemTableViewCell";
    ItemTableViewCell *cell = (ItemTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ItemTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    } if(isFilterd)
    {
        Listing *list ;
        list = [fileteredListings objectAtIndex:indexPath.row];
        
        // Code for tap gesture on table cell
        if([cell.gestureRecognizers count] == 0) {
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
            singleTap.numberOfTapsRequired = 1;
            singleTap.numberOfTouchesRequired = 1;
            [cell addGestureRecognizer:singleTap];
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.itemNameLabel.text = list.listingName;
        cell.itemCostLabel.text = [NSString stringWithFormat:@"%0.2f", list.listingPrice];
        NSString* fileName = list.listingImageFileName;
        CMStore *store=[CMStore defaultStore];
        
            [store fileWithName:fileName additionalOptions:nil callback:^(CMFileFetchResponse *response) {
                NSData *imageData = response.file.fileData;
                
                UIImage* listingImage= [UIImage imageWithData:imageData];
                [cell.itemImageView setImage:listingImage withBorderWidth:1.0f];
                list.listingImage = listingImage;
            }];

    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 107.0;
}

-(void)singleTap:(UITapGestureRecognizer *)tap {
    
    if(UIGestureRecognizerStateEnded == tap.state) {
        UITableViewCell *cell = (UITableViewCell *)tap.view;
        UITableView *tableView = (UITableView *)cell.superview;
        NSIndexPath *indexPath = [tableView indexPathForCell:cell];
        Listing *tempListing = [fileteredListings objectAtIndex:indexPath.row];
        ItemDetailViewController *itemViewInstance = [ItemDetailViewController new];
        itemViewInstance.selectedListing = tempListing;
        [self.navigationController pushViewController:itemViewInstance animated:YES];
    }
}

- (void)viewDidUnload
{
    [self setBuySearchBar:nil];
    [self setBuyTableView:nil];
    [self setSearchCriteriaBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)searchCriteriaChanged:(id)sender {
    switch (self.searchCriteriaBar.selectedSegmentIndex) {
        case 0:
            [self.buySearchBar resignFirstResponder];
            self.buySearchBar.text = @"";
            self.buySearchBar.placeholder = @"Enter Item Name";
            break;
        case 1:
            [self.buySearchBar resignFirstResponder];
            self.buySearchBar.text = @"";
            self.buySearchBar.placeholder = @"Enter Maximum Price";
            break;
        default:
            break;
    }
}

- (IBAction)locateButtonPressed:(id)sender {
    NearMeViewController *nearMeViewInstance = [NearMeViewController new];
    nearMeViewInstance.isBuySearch=YES;
    nearMeViewInstance.buyArray = fileteredListings ;
    [self.navigationController pushViewController:nearMeViewInstance animated:YES];
}
@end
