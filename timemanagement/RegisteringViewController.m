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
@interface RegisteringViewController ()
<SelectionViewControllerDelegate,OccasionSelectionViewControllerDelegate>

@end
@implementation RegisteringViewController
@synthesize ManagementController = _ManagementController;
@synthesize delegate = _delegate;
@synthesize ooccasion = _ooccasion;
@synthesize occasion = _occasion;
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
//
-(void) pushBack:(OccasionSelectionViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
//
-(void) pushDone:(OccasionSelectionViewController *)controller occasion:(NSString *)occasion{
    [self.occasion setTitle:occasion forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

//cancelが押されたら
- (IBAction)pushCancel:(id)sender {
    [[self delegate] registeringViewControllerDidCancel:self];
}
//Doneが押されたら
- (IBAction)pushDone:(id)sender {
    int oLength = [self.ooccasion.text length];
   
    //空白があれば、登録せずに、警告を表示
    if(oLength==0){
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
       
    }

}

- (IBAction)pushOccasion:(id)sender {
    OccasionSelectionViewController *controller =[self.storyboard instantiateViewControllerWithIdentifier:@"occasion"];
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
    
}

- (IBAction)pushStart:(id)sender {
}

- (IBAction)pushGoal:(id)sender {
}
@end
