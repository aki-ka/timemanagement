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
#import "OccasionSelectionViewController.h"
#import "StartSelectionViewController.h"
#import "GoalSelectionViewController.h"
#import "DaySelectionViewController.h"
@interface RegisteringViewController ()
<SelectionViewControllerDelegate,OccasionSelectionViewControllerDelegate,StartSelectionViewControllerDelegate,GoalSelectionViewControllerDelegate,DaySelectionViewControllerDelegate>

@end
@implementation RegisteringViewController
@synthesize ManagementController = _ManagementController;
@synthesize delegate = _delegate;
@synthesize occasion = _occasion,start=_start,goal=_goal;
@synthesize time = _time;
@synthesize day = _day;
@synthesize occasion_text=_occasion_text,start_text=_start_text,goal_text=_goal_text;


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




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"SelectPlayer"]){
        SelectionViewController *selectController = (SelectionViewController *)[[[segue destinationViewController]viewControllers] objectAtIndex:0];
        selectController.delegate = self;
    }
}
//selectionViewから返ってきた値を格納
- (void)selectionViewControllerDidFinish:(SelectionViewController *)controller time:(NSDate *)time day:(NSInteger)day{
    self.time = time;
    self.day = day;
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    self.time_text.text = [formatter stringFromDate:time];
    [self dismissViewControllerAnimated:YES completion:nil];
}
//Occasionから何もせずに返ってくる
-(void) pushBack:(OccasionSelectionViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
//Occasionから入力を受け取る
-(void) pushDone:(OccasionSelectionViewController *)controller occasion:(NSString *)occasion{
    [self.occasion_text setText:occasion];
    [self dismissViewControllerAnimated:YES completion:NULL];
}
//Startから何もせずに返ってくる
-(void) pushBack_s:(StartSelectionViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//Startから入力を受け取る
-(void) pushDone_s:(StartSelectionViewController *)controller start:(NSString *)start{
    [self.start_text setText:start];
    [self dismissViewControllerAnimated:YES completion:nil];

}
//Goalから何もせずに返ってくる
-(void) pushBack_g:(GoalSelectionViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//Goalから入力を受け取る
-(void) pushDone_g:(GoalSelectionViewController *)controller goal:(NSString *)goal{
    [self.goal_text setText:goal];
    [self dismissViewControllerAnimated:YES completion:nil];

}
//Dayから入力を受け取る
-(void) DaySelectionDidFinish:(DaySelectionViewController *)controller day:(NSInteger)day{
    [self dismissViewControllerAnimated:YES completion:nil];
}







//cancelが押されたら
- (IBAction)pushCancel:(id)sender {
    [[self delegate] registeringViewControllerDidCancel:self];
}
//Doneが押されたら
- (IBAction)pushDone:(id)sender {
    NSString *occasion = self.occasion_text.text;
    NSString *start = self.start_text.text;
    NSString *goal = self.goal_text.text;
    int olength = [occasion length];
    int slength = [start length];
    int glength = [goal length];
    //空白があれば、登録せずに、警告を表示
    if(olength==0||slength==0||glength==0){
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
        [[self delegate] registeringViewControllerDidFinish:self ocassion:occasion start:start goal:goal time:self.time day:self.day];
    }

}

- (IBAction)pushOccasion:(id)sender {
    OccasionSelectionViewController *controller =[self.storyboard instantiateViewControllerWithIdentifier:@"occasion"];
    controller.delegate = self;
    controller.managementController = self.Controller;
    [self presentViewController:controller animated:YES completion:nil];
    
}

- (IBAction)pushStart:(id)sender {
    StartSelectionViewController *controller =[self.storyboard instantiateViewControllerWithIdentifier:@"start"];
    controller.delegate = self;
    controller.managementController = self.Controller;
    [self presentViewController:controller animated:YES completion:nil];

}

- (IBAction)pushGoal:(id)sender {
    GoalSelectionViewController *controller =[self.storyboard instantiateViewControllerWithIdentifier:@"goal"];
    controller.delegate = self;
   controller.managementController = self.Controller;
    [self presentViewController:controller animated:YES completion:nil];

}

- (IBAction)pushDay:(id)sender {
    DaySelectionViewController *controller =[self.storyboard instantiateViewControllerWithIdentifier:@"day"];
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}
@end
