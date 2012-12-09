//
//  DaySelectionViewController.h
//  timemanagement
//
//  Created by AkiraYoshihara on 12/12/09.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DaySelectionViewControllerDelegate;

@interface DaySelectionViewController : UIViewController

@property (nonatomic) id <DaySelectionViewControllerDelegate> delegate;
- (IBAction)pushDone:(id)sender;

@end

@protocol DaySelectionViewControllerDelegate <NSObject>

-(void) DaySelectionDidFinish:(DaySelectionViewController *)controller day:(NSInteger) day;

@end