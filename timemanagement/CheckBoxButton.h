//
//  CheckBoxButton.h
//  timemanagement
//
//  Created by AkiraYoshihara on 12/11/30.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckBoxButton : UIButton
@property (nonatomic, assign) BOOL checkBoxSelected;

- (void)checkboxPush:(CheckBoxButton*) button;
- (void)setState:(CheckBoxButton*) button;
@end
