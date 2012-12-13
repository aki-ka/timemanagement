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
//状況
@property (weak, nonatomic) IBOutlet UIButton *occasion;
//出発地
@property (weak, nonatomic) IBOutlet UIButton *start;
//目的地
@property (weak, nonatomic) IBOutlet UIButton *goal;
//状況を表示するラベル
@property (weak, nonatomic) IBOutlet UITextField *occasion_text;
//出発地を表示するラベル
@property (weak, nonatomic) IBOutlet UITextField *start_text;
//ゴールを表示するラベル
@property (weak, nonatomic) IBOutlet UITextField *goal_text;
//時間を表示するラベル
@property (weak, nonatomic) IBOutlet UITextField *time_text;
//曜日を表示するラベル
@property (weak, nonatomic) IBOutlet UITextField *day_text;
//時間
@property (nonatomic, strong) NSDate *time;
//曜日（リスト）
@property (nonatomic) NSMutableArray *days;
//曜日のチェックボタン
@property (weak, nonatomic) IBOutlet CheckBoxButton_Time *day_cbv;

//状況履歴表示用
@property(nonatomic) NSMutableArray *o_ideal;
//出発地履歴表示用
@property(nonatomic) NSMutableArray *s_ideal;
//目的地履歴表示用
@property(nonatomic) NSMutableArray *g_ideal;


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

- (void)registeringViewControllerDidFinish:(RegisteringViewController *)controller ocassion:(NSString *)ocassion start:(NSString *)start goal:(NSString *)goal time:(NSDate *)time day:(NSMutableArray *)day;


@end
