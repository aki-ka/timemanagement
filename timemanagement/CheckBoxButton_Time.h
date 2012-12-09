//
//  CheckBoxButton_Time.h
//  timemanagement
//
//  Created by AkiraYoshihara on 12/12/09.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckBoxButton_Time : UIButton
@property (nonatomic, assign) BOOL checkBoxSelected;

- (void)checkboxPush:(CheckBoxButton_Time*) button;
- (void)setState:(CheckBoxButton_Time*) button;
@end
