//
//  DaySelectionViewController.m
//  timemanagement
//
//  Created by AkiraYoshihara on 12/12/09.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import "DaySelectionViewController.h"
#import "CheckBoxButton_Time.h"
@interface DaySelectionViewController ()

@end

@implementation DaySelectionViewController
@synthesize delegate=_delegate,days=_days;
@synthesize Mon=_Mon,Tues=_Tues,Wednes=_Wednes,Thurs=_Thurs,Fri=_Fri,Satur=_Satur,Sun=_sun;
@synthesize Usual=_Usual,Holi=_Holi;

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
    _days = [[NSMutableArray alloc] init];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//チェックがされている曜日を配列に格納
-(void) settingDays{
    if(self.Mon.checkBoxSelected)
        [self.days addObject:@"月"];
    if(self.Tues.checkBoxSelected)
        [self.days addObject:@"火"];
    if(self.Wednes.checkBoxSelected)
        [self.days addObject:@"水"];
    if(self.Thurs.checkBoxSelected)
        [self.days addObject:@"木"];
    if(self.Fri.checkBoxSelected)
        [self.days addObject:@"金"];
    if(self.Satur.checkBoxSelected)
        [self.days addObject:@"土"];
    if(self.Sun.checkBoxSelected)
        [self.days addObject:@"日"];
}

- (IBAction)pushDone:(id)sender {
    [self settingDays];
    [[self delegate] DaySelectionDidFinish:self days:self.days];
}
//平日ボタンを押したら
- (IBAction)pushUsual:(id)sender {
    if (self.Usual.checkBoxSelected) {
        self.Mon.checkBoxSelected = NO;
        self.Tues.checkBoxSelected = NO;
        self.Wednes.checkBoxSelected = NO;
        self.Thurs.checkBoxSelected = NO;
        self.Fri.checkBoxSelected = NO;
        [self.Mon setState:self.Mon];
        [self.Tues setState:self.Tues];
        [self.Wednes setState:self.Wednes];
        [self.Thurs setState:self.Thurs];
        [self.Fri setState:self.Fri];
    }
    else{
        self.Mon.checkBoxSelected = YES;
        self.Tues.checkBoxSelected = YES;
        self.Wednes.checkBoxSelected = YES;
        self.Thurs.checkBoxSelected = YES;
        self.Fri.checkBoxSelected = YES;
        [self.Mon setState:self.Mon];
        [self.Tues setState:self.Tues];
        [self.Wednes setState:self.Wednes];
        [self.Thurs setState:self.Thurs];
        [self.Fri setState:self.Fri];

    }
}
//休日ボタンを押したら
- (IBAction)pushHoliday:(id)sender {
    if(self.Holi.checkBoxSelected){
        self.Satur.checkBoxSelected =NO;
        self.Sun.checkBoxSelected=NO;
        [self.Satur setState:self.Satur];
        [self.Sun setState:self.Sun];
    }
    else{
        self.Satur.checkBoxSelected =YES;
        self.Sun.checkBoxSelected=YES;
        [self.Satur setState:self.Satur];
        [self.Sun setState:self.Sun];
    }
}
@end
