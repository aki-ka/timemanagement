//
//  RegisteringViewController.h
//  timemanagement
//
//  Created by AkiraYoshihara on 12/11/23.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TimeManagementController;

@protocol ResisteringViewControllerDelegate;

@interface RegisteringViewController : UIViewController

@property (weak, nonatomic) id <ResisteringViewControllerDelegate> delegate;
//配列
@property (strong,nonatomic) TimeManagementController *ManagementController;
//状況
@property (weak, nonatomic) IBOutlet UITextField *occasion;
//出発地
@property (weak, nonatomic) IBOutlet UITextField *start;
//目的地
@property (weak, nonatomic) IBOutlet UITextField *goal;
//キーボードを隠す為のボタン
@property (weak, nonatomic) IBOutlet UIButton *buttonClearKeyboard;
//時間
@property (nonatomic, strong) NSDate *time;
//曜日
@property (nonatomic) NSInteger day;
//情報を登録
- (IBAction)registerData:(id)sender;
//キーボードを隠す
- (IBAction)clearKeybord:(id)sender;
//状況、出発地、目的地の編集完了
- (IBAction)occasion_end:(id)sender;
- (IBAction)start_end:(id)sender;
- (IBAction)goal_end:(id)sender;
//デバッグ用
- (IBAction)list:(id)sender;
//cancelボタンが押されたときのメソッド
- (IBAction)pushCancel:(id)sender;


@end

@protocol ResisteringViewControllerDelegate <NSObject>
//cancel
- (void)registeringViewControllerDidCancel:(RegisteringViewController *)controller;


@end
