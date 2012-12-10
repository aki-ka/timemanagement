//
//  RegisteringViewController.h
//  timemanagement
//
//  Created by AkiraYoshihara on 12/11/23.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OccasionSelectionViewController.h"
@class TimeManagementController;
@class CheckBoxButton_Time;
@protocol ResisteringViewControllerDelegate;

@interface RegisteringViewController : UIViewController

@property (weak, nonatomic) id <ResisteringViewControllerDelegate> delegate;
//配列
@property (strong,nonatomic) TimeManagementController *ManagementController;
//候補用に受け渡す配列
@property(strong,nonatomic) TimeManagementController *Controller;
//状況
@property (weak, nonatomic) IBOutlet UIButton *occasion;
@property (weak, nonatomic) IBOutlet UIButton *start;
@property (weak, nonatomic) IBOutlet UIButton *goal;
//
@property (weak, nonatomic) IBOutlet UITextField *occasion_text;
//
@property (weak, nonatomic) IBOutlet UITextField *start_text;
//
@property (weak, nonatomic) IBOutlet UITextField *goal_text;
//
@property (weak, nonatomic) IBOutlet UITextField *time_text;
//曜日を表示するラベル
@property (weak, nonatomic) IBOutlet UITextField *day_text;
//時間
@property (nonatomic, strong) NSDate *time;
//曜日
@property (nonatomic) NSInteger day;

@property (nonatomic) NSMutableArray *days;
//曜日のチェックボタン
@property (weak, nonatomic) IBOutlet CheckBoxButton_Time *day_cbv;

//cancelボタンが押されたときのメソッド
- (IBAction)pushCancel:(id)sender;
//doneボタンが押されたときのメソッド
- (IBAction)pushDone:(id)sender;
//
- (IBAction)pushOccasion:(id)sender;
//
- (IBAction)pushStart:(id)sender;
//
- (IBAction)pushGoal:(id)sender;
//曜日選択
- (IBAction)pushDay:(id)sender;

@end

@protocol ResisteringViewControllerDelegate <NSObject>
//cancel
- (void)registeringViewControllerDidCancel:(RegisteringViewController *)controller;

- (void)registeringViewControllerDidFinish:(RegisteringViewController *)controller ocassion:(NSString *)ocassion start:(NSString *)start goal:(NSString *)goal time:(NSDate *)time day:(NSInteger)day;


@end
