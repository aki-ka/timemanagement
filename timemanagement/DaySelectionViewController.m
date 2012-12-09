//
//  DaySelectionViewController.m
//  timemanagement
//
//  Created by AkiraYoshihara on 12/12/09.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import "DaySelectionViewController.h"

@interface DaySelectionViewController ()

@end

@implementation DaySelectionViewController
@synthesize delegate=_delegate;

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

- (IBAction)pushDone:(id)sender {
    [[self delegate] DaySelectionDidFinish:self day:7];
}
@end
