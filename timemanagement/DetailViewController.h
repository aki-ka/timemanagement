//
//  DetailViewController.h
//  timemanagement
//
//  Created by AkiraYoshihara on 12/12/01.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckBoxButton.h"
@class ToDoElement;
@protocol DetailViewControllerDelegate;


@interface DetailViewController : UIViewController

@property (weak,nonatomic) id <DetailViewControllerDelegate> delegate;
//todoを格納するtextfield
@property (weak, nonatomic) IBOutlet UITextField *todoField;
//日付を表示するラベル
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
//時間を表示するラベル
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
//日付のチェックボックス
@property (weak, nonatomic) IBOutlet CheckBoxButton *cbv_date;
//時間のチェックボックス
@property (weak, nonatomic) IBOutlet CheckBoxButton *cbv_time;
//通知をするかのチェックボックス
@property (weak, nonatomic) IBOutlet CheckBoxButton *cbv_info;
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

//詳細を表示するToDoElement
@property(nonatomic) ToDoElement *element;
//詳細を表示するToDoListのindex
@property(nonatomic) NSInteger index;
//何もせずに戻る
- (IBAction)backButton:(id)sender;
//編集完了
- (IBAction)doneButton:(id)sender;
//キーボードを隠す
- (IBAction)endButton:(id)sender;
// 日付を選択
- (IBAction)dateButton:(id)sender;
//時間を選択
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

@end

@protocol DetailViewControllerDelegate <NSObject>
//back
-(void) detailViewControllerDidBack:(DetailViewController *)controller;
//done
-(void) detailViewControllerDidFinish:(DetailViewController *)controller todo:(NSString *)todo time:(NSString *)time infomation:(BOOL)  information repeat:(BOOL) repeat day:(int) day min:(int) min index:(NSInteger) index;

@end