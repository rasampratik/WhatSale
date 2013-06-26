//
//  NearMeViewController.m
//  WhatSale
//
//  Created by psr5529 on 10/30/12.
//  Copyright (c) 2012 Pratik Rasam(psr5529) , Pankaj Deshmukh(pbd6595), Himanshu Kale (hsk5260@rit.edu). All rights reserved.
//

#import "NearMeViewController.h"
#import <Mapkit/Mapkit.h>
#import "Annotation.h"
#import "Session.h"
#import "Listing.h"
@interface NearMeViewController ()

@end

@implementation NearMeViewController
@synthesize nearByMapView,isBuySearch,buyArray;

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
    [self.navigationItem setTitle:@"Whats Near Me"];
    [super viewDidLoad];
    // [self.navigationItem setTitle:@"Whats near me!"];
   //Region for Map
    MKCoordinateRegion myRegion;
    CLLocationCoordinate2D center;
    center.latitude= [[Session shared].thisUser userLatitude];
    center.longitude=[[Session shared].thisUser userLongitude];
   //Span
    MKCoordinateSpan span;
    span.latitudeDelta= 0.10f;
    span.longitudeDelta= 0.10f;
    myRegion.center=center;
    myRegion.span=span;
    [nearByMapView setZoomEnabled:YES];
    [nearByMapView setRegion:myRegion animated:YES];
    //Array for Annotations
     NSMutableArray *tempArray=[[NSMutableArray alloc] init];
     NSMutableArray *locations=[[NSMutableArray alloc] init];
    if([self isBuySearch]==NO)
   {
   
    //Annotation
    User *tempUser= [[Session shared] thisUser];
  
    tempArray =[tempUser listingsArray];
    int count = tempArray.count;
   
    for(int i=0;i<count;i++){
    
    if((([[tempArray objectAtIndex:i] listingLatitude]- tempUser.userLatitude)<=0.5) &&
       (([[tempArray objectAtIndex:i] listingLongitude]- tempUser.userLongitude)<=0.5))
    {
        Annotation *tempAnnot=[[Annotation alloc] init];
        CLLocationCoordinate2D currloc;
        currloc.latitude = [[tempArray objectAtIndex:i] listingLatitude];
        currloc.longitude = [[tempArray objectAtIndex:i] listingLongitude];
        tempAnnot.coordinate=currloc;
        tempAnnot.title = [[tempArray objectAtIndex:i] listingName];
        tempAnnot.subtitle=[NSString stringWithFormat:@"%.2f",[[tempArray objectAtIndex:i] listingPrice]];
        [locations addObject: tempAnnot];
    }
    }
    
    [self.nearByMapView addAnnotations:locations];
   }
    else
    {
        tempArray =[self buyArray];
        int count = tempArray.count;
        
        for(int i=0;i<count;i++){
            
                Annotation *tempAnnot=[[Annotation alloc] init];
                CLLocationCoordinate2D currloc;
                currloc.latitude = [[tempArray objectAtIndex:i] listingLatitude];
                currloc.longitude = [[tempArray objectAtIndex:i] listingLongitude];
                tempAnnot.coordinate=currloc;
                tempAnnot.title = [[tempArray objectAtIndex:i] listingName];
                tempAnnot.subtitle=[NSString stringWithFormat:@"%.2f",[[tempArray objectAtIndex:i] listingPrice]];
                [locations addObject: tempAnnot];
            
        }
        
        [self.nearByMapView addAnnotations:locations];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setNearByMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
