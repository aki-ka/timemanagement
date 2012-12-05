//
//  OccasionSelectionViewController.h
//  timemanagement
//
//  Created by AkiraYoshihara on 12/12/05.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  OccasionSelectionViewControllerDelegate <NSObject>


@end
@interface OccasionSelectionViewController : UITableViewController

@property (nonatomic) id <OccasionSelectionViewControllerDelegate> delegate;
@end
