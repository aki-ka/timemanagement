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
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
//時間
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet CheckBoxButton *date_cbv;

@property (weak, nonatomic) IBOutlet CheckBoxButton *time_cbv;

@property (weak, nonatomic) IBOutlet CheckBoxButton *info_cbv;

//チェックがされたときのみ日付選択
- (IBAction)dateButton:(id)sender;
//チェックがされたときのみ時間選択
- (IBAction)timeButton:(id)sender;

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
- (void)additionToDoViewControllerDidFinish:(AdittionToDoViewController *)controller todo:(NSString *)todo time:(NSString *)time information:(BOOL) information;

@end