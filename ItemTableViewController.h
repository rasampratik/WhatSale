//
//  ItemTableViewController.h
//  WhatSale
//
//  Created by hsk5260 on 10/18/12.
//  Copyright (c) 2012 Pratik Rasam(psr5529) , Pankaj Deshmukh(pbd6595), Himanshu Kale (hsk5260@rit.edu). All rights reserved.
//

#import <UIKit/UIKit.h>
@class ItemTableViewCell;

@interface ItemTableViewController : UITableViewController

/**
 *  Post the listing created to cloudmine using the attributes specified
 **/
-(void)postItemButtonPressed;

@end
