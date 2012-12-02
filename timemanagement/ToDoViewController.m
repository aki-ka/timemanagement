//
//  ToDoViewController.m
//  timemanagement
//
//  Created by AkiraYoshihara on 12/11/27.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import "ToDoViewController.h"
#import "AdittionToDoViewController.h"
#import "DetailViewController.h"
#import "ToDoElement.h"
#import "ToDo.h"

@interface ToDoViewController ()
<AdittionToDoViewControllerDelegate>

@end

@implementation ToDoViewController

@synthesize ToDoList =_ToDoList;
@synthesize buttonEdit =_buttonEdit;
@synthesize detailviewController = _detailviewController;
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
    self.ToDoList = [[ToDo alloc] init];
   
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [directory stringByAppendingPathComponent:@"todo.dat"];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if(array){
        NSMutableArray *Marray = [NSMutableArray arrayWithArray:array];
        [self.ToDoList setMasterToDoList:Marray];
    }
    
      [super viewDidLoad];
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
          
    

}




//キャンセルを押されたら
-(void) additionToDoViewControllerDidCancel:(AdittionToDoViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
//doneを押されたら、それぞれのリストに追加
-(void) additionToDoViewControllerDidFinish:(AdittionToDoViewController *)controller todo:(NSString *)todo time:(NSString *)time information:(BOOL)information{
       [self.ToDoList addToDoElementWithDoing:todo time:time information:information];
    [[self tableView] reloadData];
    //
    
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [directory stringByAppendingPathComponent:@"todo.dat"];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    array = [self.ToDoList getList];
       [NSKeyedArchiver archiveRootObject:array toFile:filePath];
     
       
    [self dismissViewControllerAnimated:YES completion:NULL];
    if (information) {
        UILocalNotification *localPush = [[UILocalNotification alloc] init];
        //タイムゾーン設定
        localPush.timeZone = [NSTimeZone defaultTimeZone];
        //表示タイミング
        localPush.fireDate = [NSDate dateWithTimeIntervalSinceNow:1];
        //メッセージ
        localPush.alertBody = todo;
        //バッジ表示
        localPush.applicationIconBadgeNumber = 0;
        //登録
        [[UIApplication sharedApplication] scheduleLocalNotification:localPush];
        
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.ToDoList countOfList];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
	//ToDoをラベルに表示
	cell.textLabel.text = [self.ToDoList objectInListAtIndex:indexPath.row].doing;
    //ToDoの下に時間をラベルに表示
    cell.detailTextLabel.text = [self.ToDoList objectInListAtIndex:indexPath.row].time;
    cell.accessoryType =
    UITableViewCellAccessoryDetailDisclosureButton;
    
    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
     /*[tableView deselectRowAtIndexPath:indexPath animated:YES];
  //  NSString *title = [self.doingList objectAtIndex:indexPath.row];
    DetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    controller.title = [self.doingList objectAtIndex:indexPath.row];
      [[self navigationController] pushViewController:controller animated:YES];
      */
    /**
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:title bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
     
}

- (void)tableView:(UITableView *)tableView
accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    //---Navigate to the details view---
    if (self.detailviewController == nil)
    {
        DetailViewController *d = [[DetailViewController alloc]
                                    initWithNibName:@"DetailViewController"
                                    bundle:[NSBundle mainBundle]];
        
        self.detailviewController = d;
    }
    
    //---set the state selected in the method of the
    // DetailsViewController---//
    
    //[self.detailviewController initWithTextSelected:msg];
    [self.navigationController
     pushViewController:self.detailviewController
     animated:YES];
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"AddPlayer"]){
        AdittionToDoViewController *addController = (AdittionToDoViewController *)[[[segue destinationViewController]viewControllers]objectAtIndex:0];
        addController.delegate = self;
    }
}

- (IBAction)buttonEdit:(id)sender {
    if([self.buttonEdit.title isEqualToString:@"Edit"]){
        self.buttonEdit.title = @"Delete";
        [self.tableView setEditing:YES animated:YES];
    }
    else{
        //削除
        self.buttonEdit.title = @"Edit";
        //選択したセルたちのindexpath を配列の形で取得する
        NSArray *indexPaths = [self.tableView indexPathsForSelectedRows];
        NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
        for (NSIndexPath *indexpath in indexPaths) {
            [indexSet addIndex:indexpath.row];
        }
        [self.ToDoList removemasterToDoListAtIndexes:indexSet];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
       
        NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *filePath = [directory stringByAppendingPathComponent:@"todo.dat"];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        array = [self.ToDoList getList];
        [NSKeyedArchiver archiveRootObject:array toFile:filePath];

        //編集モードを解除
        [self.tableView setEditing:NO animated:NO];
            }
    
}

@end
