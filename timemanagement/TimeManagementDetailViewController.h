//
//  TimeManagementDetailViewController.h
//  timemanagement
//
//  Created by 有山 祐平 on 12/12/10.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TimeManagement;
@protocol DetailViewControllerDelegate;

@interface TimeManagementDetailViewController : UITableViewController

@property (weak, nonatomic) id <DetailViewControllerDelegate> delegate;

@property (nonatomic, copy) NSArray *sectionDatas;

@property (strong, nonatomic) TimeManagement *timeManagement;

- (IBAction)didBack:(id)sender;

@end

@protocol DetailViewControllerDelegate <NSObject>

- (void)detailViewControllerDidCalcel:(TimeManagementDetailViewController *)controller;

@end
