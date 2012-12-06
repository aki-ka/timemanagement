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


@end

@protocol DetailViewControllerDelegate <NSObject>
//back
-(void) detailViewControllerDidBack:(DetailViewController *)controller;
//done
-(void) detailViewControllerDidFinish:(DetailViewController *)controller todo:(NSString *)todo time:(NSString *)time infomation:(BOOL) information index:(NSInteger) index;

@end