//
//  DetailViewController.h
//  timemanagement
//
//  Created by AkiraYoshihara on 12/12/01.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UINavigationItem *navi_title;
- (IBAction)backButton:(id)sender;

@end
