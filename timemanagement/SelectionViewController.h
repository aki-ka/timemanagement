//
//  SelectionViewController.h
//  timemanagement
//
//  Created by AkiraYoshihara on 12/11/23.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SelectionViewControllerDelegate;

@interface SelectionViewController : UIViewController

@property (weak,nonatomic) id <SelectionViewControllerDelegate> delegate;

//時間選択
@property (weak, nonatomic) IBOutlet UIDatePicker *time;
//画面を登録画面に戻すアクション
- (IBAction)decide:(id)sender;

@end

@protocol SelectionViewControllerDelegate <NSObject>

- (void)selectionViewControllerDidFinish:(SelectionViewController *)controller time:(NSDate *)time;

@end