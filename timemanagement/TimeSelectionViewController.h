//
//  TimeSelectionViewController.h
//  timemanagement
//
//  Created by AkiraYoshihara on 12/11/30.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TimeSelectionViewControllerDelegate;

@interface TimeSelectionViewController : UIViewController
//時間
@property (weak, nonatomic) IBOutlet UIDatePicker *TimePicker;
//delegate
@property (assign,nonatomic) id <TimeSelectionViewControllerDelegate> delegate;
//時間を選んだ後に押す決定ボタン
- (IBAction)buttonEnd:(id)sender;

@end
@protocol TimeSelectionViewControllerDelegate <NSObject>
//時間を前のviewへ送る
-(void) timeSelectionBiewControllerDidOK:(TimeSelectionViewController *)controller time:(NSString *)time;

@end