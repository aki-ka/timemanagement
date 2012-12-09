//
//  TimeManagementMasterViewController.m
//  timemanagement
//
//  Created by 有山 祐平 on 12/12/03.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import "TimeManagementMasterViewController.h"

#import "TimeManagement.h"

#import "TimeManagementController.h"

#import "RegisteringViewController.h"

#import "TimeManagementDetailViewController.h"

@interface TimeManagementMasterViewController ()
<ResisteringViewControllerDelegate,UIActionSheetDelegate>

@end

@implementation TimeManagementMasterViewController

@synthesize dataController = _dataController;
@synthesize EditButton = _EditButton;
@synthesize sectionDatas = _sectionDatas;
@synthesize flag = _flag;

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
    _dataController = [[TimeManagementController alloc] init];
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [directory stringByAppendingPathComponent:@"timemanagement.dat"];
    //[[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if(array){
        NSMutableArray *Marray = [NSMutableArray arrayWithArray:array];
        [self.dataController setMasterTimeManagementList:Marray];
        
    }

    [super viewDidLoad];
    self.tableView.allowsMultipleSelectionDuringEditing = YES;


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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.flag != 1){
        // Return the number of sections.
        return 1;
    } else {
        return self.sectionDatas.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.flag != 1){
        // Return the number of rows in the section.
        return [self.dataController countOfList];
    } else {
        NSArray *data = [self.sectionDatas objectAtIndex: section];
        return data.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TimeManagementCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    if (self.flag !=1){
        cell.textLabel.text = [[self.dataController objectInListAtIndex:indexPath.row] getTextLabel];
        
        cell.detailTextLabel.text = [[self.dataController objectInListAtIndex:indexPath.row] getTextDetailLabel];
        
        
        // Configure the cell...
        
        return cell;
        
    } else {
        NSArray *data = [self.sectionDatas objectAtIndex:indexPath.section];
        
        cell.textLabel.text = [[data objectAtIndex:indexPath.row] getTextLabel];
        
        cell.detailTextLabel.text = [[data objectAtIndex:indexPath.row] getTextDetailLabel];
        
        return cell;
    }
}

// キャンセルが押されたら
-(void) registeringViewControllerDidCancel:(RegisteringViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// doneが押されたら、リストに追加
- (void)registeringViewControllerDidFinish:(RegisteringViewController *)controller ocassion:(NSString *)ocassion start:(NSString *)start goal:(NSString *)goal time:(NSDate *)time day:(NSInteger)day; {
    [self.dataController addTimeManagementWithOccasion:ocassion start:start goal:goal time:time day:day];
    
    NSArray *datalist = [NSArray arrayWithArray:self.dataController.masterTimeManagementList];
    
    NSArray *mondaylist;
    NSArray *tuedaylist;
    NSArray *weddaylist;
    NSArray *thudaylist;
    NSArray *fridaylist;
    NSArray *satdaylist;
    NSArray *sundaylist;
    NSArray *nonedaylist;
    NSPredicate *mon = [NSPredicate predicateWithFormat:@"self.day == 0"];
    mondaylist = [datalist filteredArrayUsingPredicate:mon];
    NSPredicate *tue = [NSPredicate predicateWithFormat:@"self.day == 1"];
    tuedaylist = [datalist filteredArrayUsingPredicate:tue];
    NSPredicate *wed = [NSPredicate predicateWithFormat:@"self.day == 2"];
    weddaylist = [datalist filteredArrayUsingPredicate:wed];
    NSPredicate *thu = [NSPredicate predicateWithFormat:@"self.day == 3"];
    thudaylist = [datalist filteredArrayUsingPredicate:thu];
    NSPredicate *fri = [NSPredicate predicateWithFormat:@"self.day == 4"];
    fridaylist = [datalist filteredArrayUsingPredicate:fri];
    NSPredicate *sat = [NSPredicate predicateWithFormat:@"self.day == 5"];
    satdaylist = [datalist filteredArrayUsingPredicate:sat];
    NSPredicate *sun = [NSPredicate predicateWithFormat:@"self.day == 6"];
    sundaylist = [datalist filteredArrayUsingPredicate:sun];
    NSPredicate *none = [NSPredicate predicateWithFormat:@"self.day ==7"];
    nonedaylist = [datalist filteredArrayUsingPredicate:none];
    
    self.sectionDatas = [[NSArray alloc] initWithObjects:mondaylist, tuedaylist, weddaylist, thudaylist, fridaylist, satdaylist ,sundaylist, nonedaylist, nil];
    
    
    [[self tableView] reloadData];
    
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [directory stringByAppendingPathComponent:@"timemanagement.dat"];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    array = [self.dataController getList];
    [NSKeyedArchiver archiveRootObject:array toFile:filePath];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}



//-----------------------------------------------------変更点-----------------------------------------------------------------------





-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"addTime"]){
        RegisteringViewController *addTime = (RegisteringViewController *)[[[segue destinationViewController]viewControllers]objectAtIndex:0];
        addTime.delegate = self;
        addTime.Controller = self.dataController;
    }
    if ([[segue identifier] isEqualToString:@"ShowTimeManagementDetail"]) {
        TimeManagementDetailViewController *detailViewController = [segue
                                                                    destinationViewController];
        if (self.flag != 1) {
            detailViewController.timeManagement =[self.dataController
                                                  objectInListAtIndex:[self.tableView indexPathForSelectedRow].row];
        } else {
            if ([self.tableView indexPathForSelectedRow].section == 0) {
                detailViewController.timeManagement = [[self.sectionDatas objectAtIndex:0] objectAtIndex:[self.tableView indexPathForSelectedRow].row];
                
            } else if ([self.tableView indexPathForSelectedRow].section == 1) {
                detailViewController.timeManagement = [[self.sectionDatas objectAtIndex:1] objectAtIndex:[self.tableView indexPathForSelectedRow].row];
            } else if ([self.tableView indexPathForSelectedRow].section == 2) {
                detailViewController.timeManagement = [[self.sectionDatas objectAtIndex:2] objectAtIndex:[self.tableView indexPathForSelectedRow].row];
            } else if ([self.tableView indexPathForSelectedRow].section == 3) {
                detailViewController.timeManagement = [[self.sectionDatas objectAtIndex:3] objectAtIndex:[self.tableView indexPathForSelectedRow].row];
            } else if ([self.tableView indexPathForSelectedRow].section == 4) {
                detailViewController.timeManagement = [[self.sectionDatas objectAtIndex:4] objectAtIndex:[self.tableView indexPathForSelectedRow].row];
            } else if ([self.tableView indexPathForSelectedRow].section == 5) {
                detailViewController.timeManagement = [[self.sectionDatas objectAtIndex:5] objectAtIndex:[self.tableView indexPathForSelectedRow].row];
            } else if ([self.tableView indexPathForSelectedRow].section == 6) {
                detailViewController.timeManagement = [[self.sectionDatas objectAtIndex:6] objectAtIndex:[self.tableView indexPathForSelectedRow].row];
            } else {
                detailViewController.timeManagement = [[self.sectionDatas objectAtIndex:7] objectAtIndex:[self.tableView indexPathForSelectedRow].row];
            }
        }
        
        
    }

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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.flag == 1){
        if (section == 0) {
            return @"月曜日";
        } else if (section == 1) {
            return @"火曜日";
        } else if (section == 2) {
            return @"水曜日";
        } else if (section == 3) {
            return @"木曜日";
        } else if (section == 4) {
            return @"金曜日";
        } else if (section == 5) {
            return @"土曜日";
        } else if (section == 6) {
            return @"日曜日";
        } else {
            return @"なし";
        }
    }
    
    return 0;
}


- (IBAction)buttonPush:(id)sender {
    if([self.EditButton.title isEqualToString:@"Delete"]){
        //削除
        self.EditButton.title = @"Edit";
        //選択したセルたちのindexpath を配列の形で取得する
        
        if (self.flag != 1){
            NSArray *indexPaths = [self.tableView indexPathsForSelectedRows];
            NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
            for (NSIndexPath *indexpath in indexPaths) {
                [indexSet addIndex:indexpath.row];
            }
            [self.dataController removeMasterTimeManagementAtIndexes:indexSet];
            [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            
            NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            NSString *filePath = [directory stringByAppendingPathComponent:@"timemanagement.dat"];
            NSMutableArray *array = [[NSMutableArray alloc] init];
            array = [self.dataController getList];
            [NSKeyedArchiver archiveRootObject:array toFile:filePath];
            
            //編集モードを解除
            [self.tableView setEditing:NO animated:NO];
            
        } else {
            
            NSArray *indexPaths = [self.tableView indexPathsForSelectedRows];
            
            
            NSMutableArray *index = [[NSMutableArray alloc] init];
            
            for (NSIndexPath *indexPath in indexPaths) {
                [index addObject:[[self.sectionDatas objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
            }
            
            
            for (TimeManagement *time in index) {
                [self.dataController removeMasterTimeManagementWithObject:time];
            }
            
            NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            NSString *filePath = [directory stringByAppendingPathComponent:@"timemanagement.dat"];
            NSMutableArray *array = [[NSMutableArray alloc] init];
            array = [self.dataController getList];
            [NSKeyedArchiver archiveRootObject:array toFile:filePath];
            
            NSArray *datalist = [NSArray arrayWithArray:self.dataController.masterTimeManagementList];
            
            NSArray *mondaylist;
            NSArray *tuedaylist;
            NSArray *weddaylist;
            NSArray *thudaylist;
            NSArray *fridaylist;
            NSArray *satdaylist;
            NSArray *sundaylist;
            NSArray *nonedaylist;
            NSPredicate *mon = [NSPredicate predicateWithFormat:@"self.day == 0"];
            mondaylist = [datalist filteredArrayUsingPredicate:mon];
            NSPredicate *tue = [NSPredicate predicateWithFormat:@"self.day == 1"];
            tuedaylist = [datalist filteredArrayUsingPredicate:tue];
            NSPredicate *wed = [NSPredicate predicateWithFormat:@"self.day == 2"];
            weddaylist = [datalist filteredArrayUsingPredicate:wed];
            NSPredicate *thu = [NSPredicate predicateWithFormat:@"self.day == 3"];
            thudaylist = [datalist filteredArrayUsingPredicate:thu];
            NSPredicate *fri = [NSPredicate predicateWithFormat:@"self.day == 4"];
            fridaylist = [datalist filteredArrayUsingPredicate:fri];
            NSPredicate *sat = [NSPredicate predicateWithFormat:@"self.day == 5"];
            satdaylist = [datalist filteredArrayUsingPredicate:sat];
            NSPredicate *sun = [NSPredicate predicateWithFormat:@"self.day == 6"];
            sundaylist = [datalist filteredArrayUsingPredicate:sun];
            NSPredicate *none = [NSPredicate predicateWithFormat:@"self.day ==7"];
            nonedaylist = [datalist filteredArrayUsingPredicate:none];
            
            self.sectionDatas = [[NSArray alloc] initWithObjects:mondaylist, tuedaylist, weddaylist, thudaylist, fridaylist, satdaylist ,sundaylist, nonedaylist, nil];
            
            
            [self.tableView reloadData];
            
            //編集モードを解除
            [self.tableView setEditing:NO animated:NO];
            
            
        }
        
    }
    else {
        UIActionSheet *as = [[UIActionSheet alloc] init];
        as.tag = 0;
        as.title = @"選択してください。";
        as.delegate = self;
        [as addButtonWithTitle:@"編集"];
        [as addButtonWithTitle:@"並び替え"];
        [as addButtonWithTitle:@"キャンセル"];
        as.cancelButtonIndex = 2;
        [as showInView:self.view.window];
    }
}

-(void)actionSheet:(UIActionSheet*)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 0){
        switch (buttonIndex) {
            case 0: {
                self.EditButton.title = @"Delete";
                [self.tableView setEditing:YES animated:YES];
                break;
                
            }
            case 1: {
                // ２番目のボタンが押されたときの処理を記述する
                UIActionSheet *as = [[UIActionSheet alloc] init];
                as.tag = 1;
                as.title = @"選択してください。";
                as.delegate = self;
                [as addButtonWithTitle:@"時間で並び替え"];
                [as addButtonWithTitle:@"曜日で並び替え"];
                [as addButtonWithTitle:@"登録の新しい順"];
                [as addButtonWithTitle:@"登録の古い順"];
                [as addButtonWithTitle:@"キャンセル"];
                as.cancelButtonIndex = 4;
                [as showInView:self.view.window];
                break;
            }
        }
    } else {
        switch (buttonIndex) {
            case 0: {
                // １番目のボタンが押されたときの処理を記述する
                self.flag = 0;
                [self.dataController sortDate];
                [[self tableView] reloadData];
                break;
                
            }
            case 1: {
                // ２番目のボタンが押されたときの処理を記述する
                
                [self.dataController sortDate];
                [self.dataController sortDay];
                
                NSArray *datalist = [NSArray arrayWithArray:self.dataController.masterTimeManagementList];
                
                NSArray *mondaylist;
                NSArray *tuedaylist;
                NSArray *weddaylist;
                NSArray *thudaylist;
                NSArray *fridaylist;
                NSArray *satdaylist;
                NSArray *sundaylist;
                NSArray *nonedaylist;
                NSPredicate *mon = [NSPredicate predicateWithFormat:@"self.day == 0"];
                mondaylist = [datalist filteredArrayUsingPredicate:mon];
                NSPredicate *tue = [NSPredicate predicateWithFormat:@"self.day == 1"];
                tuedaylist = [datalist filteredArrayUsingPredicate:tue];
                NSPredicate *wed = [NSPredicate predicateWithFormat:@"self.day == 2"];
                weddaylist = [datalist filteredArrayUsingPredicate:wed];
                NSPredicate *thu = [NSPredicate predicateWithFormat:@"self.day == 3"];
                thudaylist = [datalist filteredArrayUsingPredicate:thu];
                NSPredicate *fri = [NSPredicate predicateWithFormat:@"self.day == 4"];
                fridaylist = [datalist filteredArrayUsingPredicate:fri];
                NSPredicate *sat = [NSPredicate predicateWithFormat:@"self.day == 5"];
                satdaylist = [datalist filteredArrayUsingPredicate:sat];
                NSPredicate *sun = [NSPredicate predicateWithFormat:@"self.day == 6"];
                sundaylist = [datalist filteredArrayUsingPredicate:sun];
                NSPredicate *none = [NSPredicate predicateWithFormat:@"self.day ==7"];
                nonedaylist = [datalist filteredArrayUsingPredicate:none];
                
                self.sectionDatas = [[NSArray alloc] initWithObjects:mondaylist, tuedaylist, weddaylist, thudaylist, fridaylist, satdaylist ,sundaylist, nonedaylist, nil];
                
                self.flag = 1;
                
                
                [[self tableView] reloadData];
                break;
            }
        }
        
    }
    }


@end
