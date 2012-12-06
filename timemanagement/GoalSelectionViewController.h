//
//  GoalSelectionViewController.h
//  timemanagement
//
//  Created by AkiraYoshihara on 12/12/06.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TimeManagementController;
@protocol GoalSelectionViewControllerDelegate;

@interface GoalSelectionViewController : UITableViewController
@property (nonatomic) id <GoalSelectionViewControllerDelegate> delegate;
@property (nonatomic) TimeManagementController *managementController;
@property(weak,nonatomic) UITextField *txtfield;

- (IBAction)buttonBack:(id)sender;
- (IBAction)buttonDone:(id)sender;
- (void) removeDuplicatedObjects;

@end

@protocol GoalSelectionViewControllerDelegate <NSObject>

-(void) pushBack_g:(GoalSelectionViewController *) controller;
-(void) pushDone_g:(GoalSelectionViewController *) controller goal:(NSString *) goal;

@end
