//
//  AdittionToDoViewController.m
//  timemanagement
//
//  Created by AkiraYoshihara on 12/11/29.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import "AdittionToDoViewController.h"
#import "DateSelectionViewController.h"
#import "TimeSelectionViewController.h"
#import "CheckBoxButton.h"
@interface AdittionToDoViewController ()<DateSelectionViewControllerDelegate,TimeSelectionViewControllerDelegate>

@end

@implementation AdittionToDoViewController
@synthesize dateSelectionViewController = _dateSelectionViewController;
@synthesize delegate = _delegate;
@synthesize toDoLabel =_toDoLabel;
@synthesize dateLabel =_dateLabel;
@synthesize timeLabel =_timeLabel;
@synthesize date_cbv = _date_cbv;
@synthesize time_cbv = _time_cbv;
@synthesize info_cbv = _info_cbv;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//選択された日付をラベルに表示する
-(void) dateSelectionViewControllerDidOK:(DateSelectionViewController *)controller date:(NSString *)date{
    [_dateLabel setText:date];
    [self dismissViewControllerAnimated:YES completion:nil];
}
//選択された日付をラベルに表示する
-(void) timeSelectionBiewControllerDidOK:(TimeSelectionViewController *)controller time:(NSString *)time{
    [_timeLabel setText:time];
    [self dismissViewControllerAnimated:YES completion:nil];
}
//キーボードを消す
- (IBAction)endEdit:(id)sender {
}

//toDoリストへ追加
- (IBAction)ButtonDone:(id)sender {
    int textLength = [self.toDoLabel.text length];
    if (textLength ==0) {
        UIAlertView *alert = [
                              [UIAlertView alloc]
                              initWithTitle:@"warining"
                              message:@"ToDoを入力してください"
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil
                              ];
        [alert show];
    }
    else{
    //選択した時間
    
    //日付と時間を結合
    NSString *time = [NSString stringWithFormat:@"%@%@ ",self.dateLabel.text,self.timeLabel.text];
    [[self delegate] additionToDoViewControllerDidFinish:self todo:self.toDoLabel.text time:time information:self.info_cbv.checkBoxSelected];
    }
}
//キャンセル
- (IBAction)ButtonCancel:(id)sender {
    [[self delegate] additionToDoViewControllerDidCancel:self];
}

- (IBAction)clearKeyBoard:(id)sender {
    [self.view endEditing:YES];
}

//チェックされれば日付選択
- (IBAction)dateButton:(id)sender {
    if(self.date_cbv.checkBoxSelected){
        [self.dateLabel setText:@""];
    }
    else{
    DateSelectionViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"todo_date"];
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
    }
}
//チェックされれば時間選択
- (IBAction)timeButton:(id)sender {
    if(self.time_cbv.checkBoxSelected){
        [self.timeLabel setText:@""];
    }
    else{
    TimeSelectionViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"todo_time"];
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
    }
}
@end
