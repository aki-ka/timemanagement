//
//  TimeSelectionViewController.m
//  timemanagement
//
//  Created by AkiraYoshihara on 12/11/30.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import "TimeSelectionViewController.h"

@interface TimeSelectionViewController ()

@end

@implementation TimeSelectionViewController

@synthesize delegate,TimePicker =_TimePicker;

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
    NSDate *select = [self.TimePicker date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *time = [formatter stringFromDate:select];
    [[self delegate] timeSelectionBiewControllerDidOK:self time:time];
}
@end
