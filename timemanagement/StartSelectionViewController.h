//
//  StartSelectionViewController.h
//  timemanagement
//
//  Created by AkiraYoshihara on 12/12/06.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TimeManagementController;
@protocol StartSelectionViewControllerDelegate;

@interface StartSelectionViewController : UITableViewController

@property (nonatomic) id <StartSelectionViewControllerDelegate> delegate;
@property(nonatomic) TimeManagementController *managementController;
@property(weak,nonatomic) UITextField *txtField;
- (IBAction)buttonDone:(id)sender;
- (IBAction)buttonBack:(id)sender;
-(void) removeDuplicatedObjects;
@end

@protocol StartSelectionViewControllerDelegate <NSObject>
//back
-(void) pushBack_s:(StartSelectionViewController *)controller;
//Done
-(void) pushDone_s:(StartSelectionViewController *)controller start:(NSString *)start;

@end
