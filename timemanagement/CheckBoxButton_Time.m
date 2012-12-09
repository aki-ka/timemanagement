//
//  CheckBoxButton_Time.m
//  timemanagement
//
//  Created by AkiraYoshihara on 12/12/09.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import "CheckBoxButton_Time.h"

@implementation CheckBoxButton_Time

@synthesize checkBoxSelected = _checkBoxSelected;

- (void)awakeFromNib
{
    [super awakeFromNib];
    UIImage* nocheck = [UIImage imageNamed:@"cb_glossy_off.png"];
    UIImage* checked = [UIImage imageNamed:@"cb_glossy_on.png"];
    [self setBackgroundImage:nocheck forState:UIControlStateNormal];
    [self setBackgroundImage:checked forState:UIControlStateSelected];
    [self setBackgroundImage:checked forState:UIControlStateHighlighted];
    [self addTarget:self action:@selector(checkboxPush:) forControlEvents:UIControlEventTouchUpInside];
    [self setState:self];
}

- (id)initWithFrame:(CGRect)frame
{
    NSLog(@"initWithFrame");
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImage* nocheck = [UIImage imageNamed:@"cb_glossy_off.png"];
        UIImage* checked = [UIImage imageNamed:@"cb_glossy_on.png"];
        [self setBackgroundImage:nocheck forState:UIControlStateNormal];
        [self setBackgroundImage:checked forState:UIControlStateSelected];
        [self setBackgroundImage:checked forState:UIControlStateHighlighted];
        [self addTarget:self action:@selector(checkboxPush:) forControlEvents:UIControlEventTouchUpInside];
        [self setState:self];
    }
    return self;
}

- (void)checkboxPush:(CheckBoxButton_Time*) button {
    button.checkBoxSelected = !button.checkBoxSelected;
    [button setState:button];
}

- (void)setState:(CheckBoxButton_Time*) button
{
    if (button.checkBoxSelected) {
        [button setSelected:YES];
    } else {
        [button setSelected:NO];
    }
}

@end
