//
//  OccasionSelectionViewController.h
//  timemanagement
//
//  Created by AkiraYoshihara on 12/12/05.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TimeManagementController;
@protocol  OccasionSelectionViewControllerDelegate;

@interface OccasionSelectionViewController : UITableViewController

@property (nonatomic) id <OccasionSelectionViewControllerDelegate> delegate;
@property (nonatomic) NSMutableArray *ideal;
@property (weak,nonatomic) UITextField *txtField;
- (IBAction)buttonBack:(id)sender;
- (IBAction)buttonDone:(id)sender;
@end

@protocol OccasionSelectionViewControllerDelegate <NSObject>
//cancel
-(void) pushBack:(OccasionSelectionViewController *) controller;
//done
-(void) pushDone:(OccasionSelectionViewController *)controller occasion:(NSString *)occasion;

@end