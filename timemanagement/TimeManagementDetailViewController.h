//
//  TimeManagementDetailViewController.h
//  timemanagement
//
//  Created by 有山 祐平 on 12/12/10.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TimeManagement;

@interface TimeManagementDetailViewController : UITableViewController

@property (nonatomic, copy) NSArray *sectionDatas;

@property (strong, nonatomic) TimeManagement *timeManagement;

@end
