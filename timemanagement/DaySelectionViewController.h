//
//  DaySelectionViewController.h
//  timemanagement
//
//  Created by AkiraYoshihara on 12/12/09.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CheckBoxButton_Time;
@protocol DaySelectionViewControllerDelegate;

@interface DaySelectionViewController : UIViewController

@property (nonatomic) id <DaySelectionViewControllerDelegate> delegate;
@property (nonatomic) NSMutableArray *days;
@property (weak, nonatomic) IBOutlet CheckBoxButton_Time *Mon;
@property (weak, nonatomic) IBOutlet CheckBoxButton_Time *Tues;
@property (weak, nonatomic) IBOutlet CheckBoxButton_Time *Wednes;
@property (weak, nonatomic) IBOutlet CheckBoxButton_Time *Thurs;
@property (weak, nonatomic) IBOutlet CheckBoxButton_Time *Fri;
@property (weak, nonatomic) IBOutlet CheckBoxButton_Time *Satur;
@property (weak, nonatomic) IBOutlet CheckBoxButton_Time *Sun;
@property (weak, nonatomic) IBOutlet CheckBoxButton_Time *Usual;
@property (weak, nonatomic) IBOutlet CheckBoxButton_Time *Holi;

- (IBAction)pushDone:(id)sender;
- (IBAction)pushUsual:(id)sender;
- (IBAction)pushHoliday:(id)sender;

@end

@protocol DaySelectionViewControllerDelegate <NSObject>

-(void) DaySelectionDidFinish:(DaySelectionViewController *)controller days:(NSMutableArray *) days;

@end