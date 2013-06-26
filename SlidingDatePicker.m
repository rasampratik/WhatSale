//
//  SlidingDatePicker.m
//  WhatSale
//
//  Created by hsk5260 on 11/1/12.
//  Copyright (c) 2012 Pratik Rasam(psr5529) , Pankaj Deshmukh(pbd6595), Himanshu Kale (hsk5260@rit.edu). All rights reserved.
//

#import "SlidingDatePicker.h"

#define SlidingDatePickerPickerHeight 216
#define SlidingDatePickerToolbarHeight 44

@interface SlidingDatePicker ()

@property (nonatomic, assign, readwrite) UIDatePicker *datePicker;
@property (nonatomic, assign) CGRect originalFrame;
@property (nonatomic, assign) id doneTarget;
@property (nonatomic, assign) SEL doneSelector;

- (void) donePressed;

@end

@implementation SlidingDatePicker

@synthesize datePicker = _datePicker;
@synthesize originalFrame = _originalFrame;
@synthesize doneSelector = _doneSelector;
@synthesize doneTarget = _doneTarget;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.originalFrame = frame;
        self.backgroundColor = [UIColor clearColor];
        CGFloat width = self.bounds.size.width;
        UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, width, SlidingDatePickerPickerHeight)];
        [self addSubview:picker];
        
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame: CGRectMake(0, SlidingDatePickerPickerHeight, width, SlidingDatePickerToolbarHeight)];
        toolbar.barStyle = UIBarStyleBlackOpaque;
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle: @"Done" style: UIBarButtonItemStyleBordered target: self action: @selector(donePressed)];
        doneButton.width = width - 20;
        toolbar.items = [NSArray arrayWithObject: doneButton];
        [self addSubview: toolbar];
        
        self.datePicker = picker;
    }
    return self;
}

- (void) setMode: (UIDatePickerMode) mode {
    self.datePicker.datePickerMode = mode;
}

- (void) donePressed {
    if (self.doneTarget) {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.doneTarget performSelector: self.doneSelector];
        #pragma clang diagnostic pop
    }
}

- (void) addTargetForDoneButton: (id) target action: (SEL) action {
    self.doneTarget = target;
    self.doneSelector = action;
}

- (void) setHidden: (BOOL) hidden animated: (BOOL) animated {
    CGRect newFrame = self.originalFrame;
    newFrame.origin.y += hidden ? SlidingDatePickerPickerHeight+SlidingDatePickerToolbarHeight : 0;
    if (animated) {
        [UIView beginAnimations: @"animateDateTimePicker" context: nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve: UIViewAnimationCurveEaseOut];
        
        self.frame = newFrame;
        
        [UIView commitAnimations];
    } else {
        self.frame = newFrame;
    }
}

@end
