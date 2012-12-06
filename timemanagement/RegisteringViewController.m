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
@interface RegisteringViewController ()
<SelectionViewControllerDelegate,OccasionSelectionViewControllerDelegate,StartSelectionViewControllerDelegate,GoalSelectionViewControllerDelegate>

@end
@implementation RegisteringViewController
@synthesize ManagementController = _ManagementController;
@synthesize delegate = _delegate;
@synthesize occasion = _occasion,start=_start,goal=_goal;
@synthesize time = _time;
@synthesize day = _day;
@synthesize buttonClearKeyboard = _buttonClearKeyboard;
//@synthesize occaisioncontroller =_occaisioncontroller;

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
    [self dismissViewControllerAnimated:YES completion:nil];
}
//Occasionから何もせずに返ってくる
-(void) pushBack:(OccasionSelectionViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
//Occasionから入力を受け取る
-(void) pushDone:(OccasionSelectionViewController *)controller occasion:(NSString *)occasion{
    [self.occasion setTitle:occasion forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:NULL];
}
//Startから何もせずに返ってくる
-(void) pushBack_s:(StartSelectionViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//Startから入力を受け取る
-(void) pushDone_s:(StartSelectionViewController *)controller start:(NSString *)start{
    [self.start setTitle:start forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];

}
//Goalから何もせずに返ってくる
-(void) pushBack_g:(GoalSelectionViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//Goalから入力を受け取る
-(void) pushDone_g:(GoalSelectionViewController *)controller goal:(NSString *)goal{
    [self.goal setTitle:goal forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];

}








//cancelが押されたら
- (IBAction)pushCancel:(id)sender {
    [[self delegate] registeringViewControllerDidCancel:self];
}
//Doneが押されたら
- (IBAction)pushDone:(id)sender {
    NSString *occasion = self.occasion.titleLabel.text;
    NSString *start = self.start.titleLabel.text;
    NSString *goal = self.goal.titleLabel.text;
    //空白があれば、登録せずに、警告を表示
    if([occasion isEqualToString:@"Occaison"]){
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
@end
