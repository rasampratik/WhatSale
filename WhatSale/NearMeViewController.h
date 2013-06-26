//
//  NearMeViewController.h
//  WhatSale
//
//  Created by psr5529 on 10/30/12.
//  Copyright (c) 2012 Pratik Rasam(psr5529) , Pankaj Deshmukh(pbd6595), Himanshu Kale (hsk5260@rit.edu). All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Mapkit/Mapkit.h>

@interface NearMeViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *nearByMapView;
@property (nonatomic, assign) BOOL isBuySearch;
@property (strong, nonatomic) NSMutableArray *buyArray;

@end
