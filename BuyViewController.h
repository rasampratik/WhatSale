//
//  BuyViewController.h
//  WhatSale
//
//  Created by psr5529 on 11/3/12.
//  Copyright (c) 2012 Pratik Rasam(psr5529) , Pankaj Deshmukh(pbd6595), Himanshu Kale (hsk5260@rit.edu). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyViewController : UIViewController<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UISearchBar *buySearchBar;
@property (weak, nonatomic) IBOutlet UITableView *buyTableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *searchCriteriaBar;

- (IBAction)searchCriteriaChanged:(id)sender;
- (IBAction)locateButtonPressed:(id)sender;

@end
