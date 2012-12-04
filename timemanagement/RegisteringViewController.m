//
//  RegisteringViewController.m
//  timemanagement
//
//  Created by AkiraYoshihara on 12/11/23.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import "RegisteringViewController.h"
#import "SelectionViewController.h"
#import "TimeManagementController.h"
#import "TimeManagement.h"
@interface RegisteringViewController ()
<SelectionViewControllerDelegate>

@end
@implementation RegisteringViewController
@synthesize ManagementController = _ManagementController;
@synthesize delegate = _delegate;
@synthesize occasion = _occasion;
@synthesize start = _start;
@synthesize goal = _goal;
@synthesize time = _time;
@synthesize day = _day;
@synthesize buttonClearKeyboard = _buttonClearKeyboard;

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
    _ManagementController = [[TimeManagementController alloc] init];
    self.day = 8;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 キーボードを隠す
 view上の編集を終了させる
 */
- (IBAction)clearKeybord:(id)sender {
    [self.view endEditing:YES];
}

//それぞれの編集完了
- (IBAction)occasion_end:(id)sender {
}

- (IBAction)start_end:(id)sender {
}

- (IBAction)goal_end:(id)sender {
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"SelectPlayer"]){
        SelectionViewController *selectController = (SelectionViewController *)[[[segue destinationViewController]viewControllers] objectAtIndex:0];
        selectController.delegate = self;
    }
}

- (void)selectionViewControllerDidFinish:(SelectionViewController *)controller time:(NSDate *)time day:(NSInteger)day{
    self.time = time;
    self.day = day;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)pushCancel:(id)sender {
    [[self delegate] registeringViewControllerDidCancel:self];
}

- (IBAction)pushDone:(id)sender {
    int oLength = [self.occasion.text length];
    int sLength = [self.start.text length];
    int gLength = [self.goal.text length];
    //空白があれば、登録せずに、警告を表示
    if(oLength==0||sLength==0||gLength==0){
        UIAlertView *alert = [
                              [UIAlertView alloc]
                              initWithTitle:@"warning"
                              message:@"空白があります"
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil
                              ];
        [alert show];
    }
    else if(self.day == 8){
        UIAlertView *alert = [
                              [UIAlertView alloc]
                              initWithTitle:@"warning"
                              message:@"時間を入力してください"
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles: nil];
        [alert show];
    }
    else{
        [[self delegate] registeringViewControllerDidFinish:self ocassion:self.occasion.text start:self.start.text goal:self.goal.text time:self.time day:self.day];
    }

}
@end
