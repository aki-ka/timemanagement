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

@protocol ResisteringViewControllerDelegate;

@interface RegisteringViewController : UIViewController

@property (weak, nonatomic) id <ResisteringViewControllerDelegate> delegate;
//配列
@property (strong,nonatomic) TimeManagementController *ManagementController;
//状況
@property (weak, nonatomic) IBOutlet UIButton *occasion;


@property (weak, nonatomic) IBOutlet UITextField *ooccasion;

//キーボードを隠す為のボタン
@property (weak, nonatomic) IBOutlet UIButton *buttonClearKeyboard;
//時間
@property (nonatomic, strong) NSDate *time;
//曜日
@property (nonatomic) NSInteger day;
//状況選択の画面
//@property (strong,nonatomic) OccasionSelectionViewController *OccasionController;

//キーボードを隠す
- (IBAction)clearKeybord:(id)sender;


//cancelボタンが押されたときのメソッド
- (IBAction)pushCancel:(id)sender;
//doneボタンが押されたときのメソッド
- (IBAction)pushDone:(id)sender;
- (IBAction)pushOccasion:(id)sender;
- (IBAction)pushStart:(id)sender;
- (IBAction)pushGoal:(id)sender;

@end

@protocol ResisteringViewControllerDelegate <NSObject>
//cancel
- (void)registeringViewControllerDidCancel:(RegisteringViewController *)controller;

- (void)registeringViewControllerDidFinish:(RegisteringViewController *)controller ocassion:(NSString *)ocassion start:(NSString *)start goal:(NSString *)goal time:(NSDate *)time day:(NSInteger)day;


@end
