//
//  SlidingDatePicker.h
//  WhatSale
//
//  Created by hsk5260 on 11/1/12.
//  Copyright (c) 2012 Pratik Rasam(psr5529) , Pankaj Deshmukh(pbd6595), Himanshu Kale (hsk5260@rit.edu). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlidingDatePicker : UIView {
    
}

@property (nonatomic, assign, readonly) UIDatePicker *datePicker;

/**
 *  The following function sets the mode of the date picker
 *
 *  @param Date picker mode
 **/
- (void)setMode:(UIDatePickerMode)mode;

/**
 *  Sets whether the date picker should be hidden or not
 *
 *  @param hidden - If date picker should be hidden
 *  @param animated - Whether date picker should be animated in
 **/
- (void)setHidden:(BOOL)hidden animated:(BOOL) animated;

/**
 *  Add the target function when the done button will be pressed
 *
 *  @param target - The target object
 *  @param action - The selector which will be the action which will be executed on button press
 **/
- (void)addTargetForDoneButton:(id)target action:(SEL) action;

@end
