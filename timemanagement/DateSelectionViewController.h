//
//  DateSelectionViewController.h
//  timemanagement
//
//  Created by AkiraYoshihara on 12/11/29.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DateSelectionViewControllerDelegate;

@interface DateSelectionViewController : UIViewController
//日付
@property (weak, nonatomic) IBOutlet UIDatePicker *DatePicker;
//delegeate
@property (assign, nonatomic) id <DateSelectionViewControllerDelegate> delegate;
//日付を選んだ後に押す決定ボタン
- (IBAction)buttonEnd:(id)sender;

@end

@protocol DateSelectionViewControllerDelegate <NSObject>
//delegateメソッド、日付を前のviewへ送る
-(void) dateSelectionViewControllerDidOK:(DateSelectionViewController *)controller date:(NSString *)date;

@end