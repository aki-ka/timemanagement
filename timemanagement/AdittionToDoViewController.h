//
//  AdittionToDoViewController.h
//  timemanagement
//
//  Created by AkiraYoshihara on 12/11/29.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DateSelectionViewController.h"
#import "TimeSelectionViewController.h"
@class CheckBoxButton;
@protocol AdittionToDoViewControllerDelegate;

@interface AdittionToDoViewController : UIViewController<DateSelectionViewControllerDelegate,TimeSelectionViewControllerDelegate>
//
@property(nonatomic) DateSelectionViewController *dateSelectionViewController;
//
@property (weak, nonatomic) id <AdittionToDoViewControllerDelegate> delegate;
//ToDoが書き込まれるTextField
@property (weak, nonatomic) IBOutlet UITextField *toDoLabel;
//DateSelectionViewControllerで選択された日付を表示するラベル
@property (weak, nonatomic) IBOutlet UITextField *dateLabel;
//時間
@property (weak, nonatomic) IBOutlet UITextField *timeLabel;

//日付のチェックボタン
@property (weak, nonatomic) IBOutlet CheckBoxButton *date_cbv;
//時間のチェックボタン
@property (weak, nonatomic) IBOutlet CheckBoxButton *time_cbv;
//通知のチェックボタン
@property (weak, nonatomic) IBOutlet CheckBoxButton *info_cbv;
//何分前に通知をするか、を入力するtextfield
@property (weak, nonatomic) IBOutlet UITextField *infoText;
//「分前」と書かれたラベル
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
//「繰り返し」と書かれたラベル
@property (weak, nonatomic) IBOutlet UILabel *repeatLabel;
//繰り返し通知のチェックボタン
@property (weak, nonatomic) IBOutlet CheckBoxButton *repeat_cbv;
//「毎日」と書かれたラベル
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
//「毎日」のチェックボタン
@property (weak, nonatomic) IBOutlet CheckBoxButton *day_cbv;
//「毎週」と書かれたラベル
@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
//「毎週」のチェックボタン
@property (weak, nonatomic) IBOutlet CheckBoxButton *week_cbv;
//「毎月」と書かれたラベル
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
//「毎月」のチェックボタン
@property (weak, nonatomic) IBOutlet CheckBoxButton *month_cbv;

//チェックがされたときのみ日付選択
- (IBAction)dateButton:(id)sender;
//チェックがされたときのみ時間選択
- (IBAction)timeButton:(id)sender;
//チェックがされると繰り返しと何分前に通知するかを選択できるようにする
- (IBAction)infoButton:(id)sender;
//チェックがされるとどの周期で通知するか選択できるようにする
- (IBAction)repeatButton:(id)sender;
//毎日にチェックされると他の２つのチェックを外す
- (IBAction)dayButton:(id)sender;
//毎週にチェックされると他の２つのチェックを外す
- (IBAction)weekButton:(id)sender;
//毎月にチェックされると他の２つのチェックを外す
- (IBAction)monthButton:(id)sender;


//キーボードを消す
- (IBAction)endEdit:(id)sender;
//ToDoリストへ追加
- (IBAction)ButtonDone:(id)sender;
//追加をキャンセル
- (IBAction)ButtonCancel:(id)sender;
//編集終了のボタン
- (IBAction)clearKeyBoard:(id)sender;

@end

@protocol AdittionToDoViewControllerDelegate <NSObject>
//cancel
- (void)additionToDoViewControllerDidCancel:(AdittionToDoViewController *)controller;
//done
- (void)additionToDoViewControllerDidFinish:(AdittionToDoViewController *)controller todo:(NSString *)todo time:(NSString *)time information:(BOOL) information repeat:(BOOL)repeat day:(int) day min:(int)min;

@end