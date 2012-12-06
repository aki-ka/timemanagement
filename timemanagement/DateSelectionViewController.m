//
//  DateSelectionViewController.m
//  timemanagement
//
//  Created by AkiraYoshihara on 12/11/29.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import "DateSelectionViewController.h"

@interface DateSelectionViewController ()

@end

@implementation DateSelectionViewController
//初期化
@synthesize delegate,DatePicker =_DatePicker;


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

- (IBAction)buttonEnd:(id)sender {
    //選択した時間をstring型に直し、date へ格納
    NSDate *select = [self.DatePicker date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd"];
    NSString *date = [formatter stringFromDate:select];
    [[self delegate] dateSelectionViewControllerDidOK:self date:date];
}
@end
