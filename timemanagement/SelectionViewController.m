//
//  SelectionViewController.m
//  timemanagement
//
//  Created by AkiraYoshihara on 12/11/23.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import "SelectionViewController.h"

@interface SelectionViewController ()

@end

@implementation SelectionViewController
@synthesize delegate;
@synthesize time =_time;
//初期化
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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//登録画面に戻す
- (IBAction)decide:(id)sender {
      NSDate *choice = [self.time date];
    [[self delegate] selectionViewControllerDidFinish:self time:choice];
  

}
@end
