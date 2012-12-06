//
//  DetailViewController.m
//  timemanagement
//
//  Created by AkiraYoshihara on 12/12/01.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import "DetailViewController.h"
#import "ToDoElement.h"
#import "CheckBoxButton.h"
#import "DateSelectionViewController.h"
#import "TimeSelectionViewController.h"
@interface DetailViewController ()<DateSelectionViewControllerDelegate,TimeSelectionViewControllerDelegate>

@end

@implementation DetailViewController
@synthesize delegate = _delegate,element = _element,index=_index;
@synthesize todoField=_todoField,dateLabel=_dateLabel,timeLabel=_timeLabel;
@synthesize cbv_date=_cbv_date,cbv_info=_cbv_info,cbv_time=_cbv_time;

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
    //ToDoListから渡されたToDoElementをそれぞれに割り当てる
    [self.todoField setText:_element.doing];
    //スペースで分割
    NSArray *date_time = [_element.time componentsSeparatedByString:@" "];
    NSString *date = [date_time objectAtIndex:0];
    NSString *time = [date_time objectAtIndex:1];
    [self.dateLabel setText:date];
    [self.timeLabel setText:time];
    //日付があればチェック
    if([self.dateLabel.text length] != 0){
        [self.cbv_date checkboxPush:self.cbv_date];
    }
    //時間があればチェック
    if([self.timeLabel.text length] != 0){
        [self.cbv_time checkboxPush:self.cbv_time];
    }
    //通知があればチェック
    if(self.element.information){
        [self.cbv_info checkboxPush:self.cbv_info];
    }
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backButton:(id)sender {
    [[self delegate] detailViewControllerDidBack:self];
}

- (IBAction)doneButton:(id)sender {
    int textLength = [self.todoField.text length];
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
        NSString *time = [NSString stringWithFormat:@"%@ %@",self.dateLabel.text,self.timeLabel.text];
        [[self delegate] detailViewControllerDidFinish:self todo:self.todoField.text time:time infomation:self.cbv_info.checkBoxSelected index:self.index];
    }

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

- (IBAction)endButton:(id)sender {
}

- (IBAction)dateButton:(id)sender {
    if(self.cbv_date.checkBoxSelected){
        [self.dateLabel setText:@""];
    }
    else{
        DateSelectionViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"todo_date"];
        controller.delegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    }

}

- (IBAction)timeButton:(id)sender {
    if(self.cbv_time.checkBoxSelected){
        [self.timeLabel setText:@""];
    }
    else{
        TimeSelectionViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"todo_time"];
        controller.delegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    }

}
@end
