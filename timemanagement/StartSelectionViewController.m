//
//  StartSelectionViewController.m
//  timemanagement
//
//  Created by AkiraYoshihara on 12/12/06.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import "StartSelectionViewController.h"
#import "TimeManagementController.h"
#import "TimeManagement.h"

@interface StartSelectionViewController ()<UITextFieldDelegate>

@end

@implementation StartSelectionViewController

@synthesize delegate =_delegate,managementController=_managementController,txtField=_txtField;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.txtField = [[UITextField alloc] init];
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//キーボードを隠す
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField{
    self.txtField = textField;
    return YES;
}
-(BOOL) textFieldShouldEndEditing:(UITextField *)textField{
    self.txtField = textField;
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch(section) {
        case 0: // 1個目のセクションの場合
            return @"入力";
            break;
        case 1: // 2個目のセクションの場合
            return @"履歴";
            break;
    }
    return nil; //ビルド警告回避用
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0://テキストフィールドを表示するセル
            return 1;
            break;
            
        default://候補を表示するセルの数
            break;
    }
    return self.managementController.countOfList;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    //テキストフィールドを表示
    if(indexPath.section==0){
        UITextField *txtField = [[UITextField alloc] init];
        [txtField addTarget:self action:nil forControlEvents:UIControlEventAllEditingEvents];
        txtField.frame = CGRectMake(10.f, 10.f, cell.contentView.bounds.size.width - 20.f, 24.f);
        txtField.returnKeyType = UIReturnKeyDone;
        txtField.delegate = self;
        [cell addSubview:txtField];
    }
    //候補を表示
    else{
          cell.textLabel.text = [self.managementController objectInListAtIndex:indexPath.row].start;
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     //入力の場合、セルの選択を解除
    if(indexPath.section == 0){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    //履歴から選択された場合、登録画面へ
    else{
        NSString *start = [self.managementController objectInListAtIndex:indexPath.row].start;
        [[self delegate] pushDone_s:self start:start];
    }

}

- (IBAction)buttonDone:(id)sender {
    NSString *start = [self.txtField text];
    [[self delegate] pushDone_s:self start:start];
}

- (IBAction)buttonBack:(id)sender {
     [[self delegate] pushBack_s:self];
}
@end
