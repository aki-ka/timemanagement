//
//  TimeManagementMasterViewController.h
//  timemanagement
//
//  Created by 有山 祐平 on 12/12/03.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TimeManagementController.h"

@interface TimeManagementMasterViewController : UITableViewController

@property (strong, nonatomic) TimeManagementController *dataController;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *EditButton;

@property (nonatomic, copy) NSArray *sectionDatas;

@property (nonatomic) NSInteger flag;
//状況履歴表示用
@property(nonatomic) NSMutableArray *o_ideal;
//出発地履歴表示用
@property(nonatomic) NSMutableArray *s_ideal;
//目的地履歴表示用
@property(nonatomic) NSMutableArray *g_ideal;

- (IBAction)buttonPush:(id)sender;

-(void)actionSheet:(UIActionSheet*)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
