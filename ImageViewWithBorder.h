//
//  ImageViewWithBorder.h
//  WhatSale
//
//  Created by hsk5260 on 10/19/12.
//  Copyright (c) 2012 Pratik Rasam(psr5529) , Pankaj Deshmukh(pbd6595), Himanshu Kale (hsk5260@rit.edu). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImageView (ImageViewBorder)\

/**
 *  Set the image with the border specified for a UIImageView
 *
 *  @param image - The image to set
 *  @param borderWidth - Set the border width for the image
 **/
-(void)setImage:(UIImage *)image withBorderWidth:(CGFloat)borderWidth;

@end
