//
//  CheckBoxButton.m
//  timemanagement
//
//  Created by AkiraYoshihara on 12/11/30.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import "CheckBoxButton.h"

@implementation CheckBoxButton

@synthesize checkBoxSelected = _checkBoxSelected;

- (void)awakeFromNib
{
    [super awakeFromNib];
    UIImage* nocheck = [UIImage imageNamed:@"cb_dark_off.png"];
    UIImage* checked = [UIImage imageNamed:@"cb_dark_on.png"];
    UIImage* disable = [UIImage imageNamed:@"disable_check.png"];
    [self setBackgroundImage:nocheck forState:UIControlStateNormal];
    [self setBackgroundImage:checked forState:UIControlStateSelected];
    [self setBackgroundImage:checked forState:UIControlStateHighlighted];
    [self setBackgroundImage:disable forState:UIControlStateDisabled];
    [self addTarget:self action:@selector(checkboxPush:) forControlEvents:UIControlEventTouchUpInside];
    [self setState:self];
}

- (id)initWithFrame:(CGRect)frame
{
    NSLog(@"initWithFrame");
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImage* nocheck = [UIImage imageNamed:@"cb_dark_off.png"];
        UIImage* checked = [UIImage imageNamed:@"cb_dark_on.png"];
        UIImage* disable = [UIImage imageNamed:@"disable_check.png"];
        [self setBackgroundImage:nocheck forState:UIControlStateNormal];
        [self setBackgroundImage:checked forState:UIControlStateSelected];
        [self setBackgroundImage:checked forState:UIControlStateHighlighted];
        [self setBackgroundImage:disable forState:UIControlStateDisabled];
        [self addTarget:self action:@selector(checkboxPush:) forControlEvents:UIControlEventTouchUpInside];
        [self setState:self];
    }
    return self;
}

- (void)checkboxPush:(CheckBoxButton*) button {
    button.checkBoxSelected = !button.checkBoxSelected;
    [button setState:button];
}

- (void)setState:(CheckBoxButton*) button
{
    if (button.checkBoxSelected) {
        [button setSelected:YES];
    } else {
        [button setSelected:NO];
    }
}
@end
