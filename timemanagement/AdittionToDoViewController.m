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
@synthesize infoText = _infoText,infoLabel=_infoLabel;
@synthesize repeatLabel = _repeatLabel,repeat_cbv = _repeat_cbv;
@synthesize dayLabel = _dayLabel,day_cbv = _day_cbv;
@synthesize weekLabel = _weekLabel,week_cbv = _week_cbv;
@synthesize monthLabel = _monthLabel,month_cbv = _month_cbv;

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
    [self.day_cbv checkboxPush:self.day_cbv];
    self.infoText.keyboardType = UIKeyboardTypeNumberPad;
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
//選択された時間をラベルに表示する
-(void) timeSelectionBiewControllerDidOK:(TimeSelectionViewController *)controller time:(NSString *)time{
    [_timeLabel setText:time];
    if(self.info_cbv.checkBoxSelected){
        [self.infoLabel setEnabled:YES];
        [self.infoText setEnabled:YES];
    }

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
        int day = 0;
        if(self.day_cbv){
            day = 1;
        }
        else if (self.week_cbv){
            day = 2;
        }
        else if (self.month_cbv){
            day =  3;
        }
        int min = [self.infoText.text intValue];
    //日付と時間を結合
    NSString *time = [NSString stringWithFormat:@"%@ %@",self.dateLabel.text,self.timeLabel.text];
    [[self delegate] additionToDoViewControllerDidFinish:self todo:self.toDoLabel.text time:time information:self.info_cbv.checkBoxSelected repeat:self.repeat_cbv.checkBoxSelected day:day min:min];
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
        [self.infoLabel setEnabled:NO];
        [self.infoText setEnabled:NO];
    }
    else{
    TimeSelectionViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"todo_time"];
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
    }
}
//チェックがされると繰り返しと何分前に通知するかを選択できるようにする
- (IBAction)infoButton:(id)sender {
    if(self.info_cbv.checkBoxSelected){
        self.repeat_cbv.checkBoxSelected = NO;
        [self.repeat_cbv setState:self.repeat_cbv];
        [self.repeatLabel setEnabled:NO];
        [self.repeat_cbv setEnabled:NO];
        [self.infoLabel setEnabled:NO];
        [self.infoText setEnabled:NO];
        [self.dayLabel setEnabled:NO];
        [self.day_cbv setEnabled:NO];
        [self.weekLabel setEnabled:NO];
        [self.week_cbv setEnabled:NO];
        [self.monthLabel setEnabled:NO];
        [self.month_cbv setEnabled:NO];
        self.infoText.textColor =[UIColor whiteColor];

    }
    else{
    //繰り返しを選択可能に
    [self.repeatLabel setEnabled:YES];
    [self.repeat_cbv setEnabled:YES];
    //時間が選択されていれば、何分前に通知するかを選択可能に
    if([self.timeLabel.text length] !=0){
        [self.infoLabel setEnabled:YES];
        [self.infoText setEnabled:YES];
        self.infoText.textColor =[UIColor blackColor];
    }
    }
}
//チェックがされるとどの周期で通知するか選択できるようにする
- (IBAction)repeatButton:(id)sender {
    if(self.repeat_cbv.checkBoxSelected){
        [self.dayLabel setEnabled:NO];
        [self.day_cbv setEnabled:NO];
        [self.weekLabel setEnabled:NO];
        [self.week_cbv setEnabled:NO];
        [self.monthLabel setEnabled:NO];
        [self.month_cbv setEnabled:NO];
    }
    else{
    [self.dayLabel setEnabled:YES];
    [self.day_cbv setEnabled:YES];
    [self.weekLabel setEnabled:YES];
    [self.week_cbv setEnabled:YES];
    [self.monthLabel setEnabled:YES];
    [self.month_cbv setEnabled:YES];
    }
}
//毎日にチェックされると他の２つのチェックを外す
- (IBAction)dayButton:(id)sender {
    //チェックされていたら、押されてもチェックされたままにする
    if(self.day_cbv.checkBoxSelected){
        [self.day_cbv checkboxPush:self.day_cbv];
    }
    //チェックがされていなかったら、他の2つのチェックを外す
    else{
        self.week_cbv.checkBoxSelected = NO;
        self.month_cbv.checkBoxSelected =NO;
        [self.week_cbv setState:self.week_cbv];
        [self.month_cbv setState:self.month_cbv];
    }
}
//毎週にチェックされると他の２つのチェックを外す
- (IBAction)weekButton:(id)sender {
    //チェックされていたら、押されてもチェックされたままにする
    if(self.week_cbv.checkBoxSelected){
        [self.week_cbv checkboxPush:self.week_cbv];
    }
     //チェックがされていなかったら、他の2つのチェックを外す
    else{
        self.day_cbv.checkBoxSelected = NO;
        self.month_cbv.checkBoxSelected =NO;
        [self.day_cbv setState:self.day_cbv];
        [self.month_cbv setState:self.month_cbv];
    }
}
//毎月にチェックされると他の２つのチェックを外す
- (IBAction)monthButton:(id)sender {
    //チェックされていたら、押されてもチェックされたままにする
    if(self.month_cbv.checkBoxSelected){
        [self.month_cbv checkboxPush:self.month_cbv];
    }
     //チェックがされていなかったら、他の2つのチェックを外す
    else{
        self.week_cbv.checkBoxSelected = NO;
        self.day_cbv.checkBoxSelected =NO;
        [self.week_cbv setState:self.week_cbv];
        [self.day_cbv setState:self.day_cbv];
}
}
@end
