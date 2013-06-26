//
//  WhatSaleAppDelegate.h
//  WhatSale
//
//  Created by psr5529 on 10/11/12.
//  Copyright (c) 2012 Pratik Rasam(psr5529) , Pankaj Deshmukh(pbd6595), Himanshu Kale (hsk5260@rit.edu). All rights reserved.
//

#import <UIKit/UIKit.h>

@class WhatSaleViewController;

@interface WhatSaleAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) WhatSaleViewController *viewController;
@property (retain, nonatomic) UINavigationController *navigationController;

@end
