//
//  ToDoViewController.h
//  timemanagement
//
//  Created by AkiraYoshihara on 12/11/27.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@class ToDo;
@interface ToDoViewController : UITableViewController
//ToDo（すること）を格納するリスト
@property(nonatomic,strong) ToDo *ToDoList;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonEdit;
@property (retain,nonatomic) DetailViewController *detailviewController;
- (IBAction)buttonEdit:(id)sender;
@end
