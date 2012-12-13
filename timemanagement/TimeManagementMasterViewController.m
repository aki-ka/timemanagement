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
<ResisteringViewControllerDelegate,UIActionSheetDelegate, DetailViewControllerDelegate>

@end

@implementation TimeManagementMasterViewController

@synthesize dataController = _dataController;
@synthesize EditButton = _EditButton;
@synthesize sectionDatas = _sectionDatas;
@synthesize flag = _flag;
@synthesize o_ideal=_o_ideal, s_ideal=_s_ideal, g_ideal=_g_ideal;
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
    _o_ideal = [[NSMutableArray alloc] init];
    _s_ideal = [[NSMutableArray alloc] init];
    _g_ideal = [[NSMutableArray alloc] init];
    
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [directory stringByAppendingPathComponent:@"timemanagement.dat"];
    NSString *o_filePath = [directory stringByAppendingPathComponent:@"occasion.dat"];
    NSString *s_filePath = [directory stringByAppendingPathComponent:@"start.dat"];
    NSString *g_filePath = [directory stringByAppendingPathComponent:@"goal.dat"];

   // [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
  //  [[NSFileManager defaultManager] removeItemAtPath:o_filePath error:nil];
  //  [[NSFileManager defaultManager] removeItemAtPath:s_filePath error:nil];
  //  [[NSFileManager defaultManager] removeItemAtPath:g_filePath error:nil];
    
    //セル表示
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if(array){
        NSMutableArray *Marray = [NSMutableArray arrayWithArray:array];
        [self.dataController setMasterTimeManagementList:Marray];
        
    }
    //状況履歴
    NSArray *o_array = [NSKeyedUnarchiver unarchiveObjectWithFile:o_filePath];
    if(o_array){
      [self.o_ideal setArray:o_array];
    }
    //出発地履歴
    NSArray *s_array = [NSKeyedUnarchiver unarchiveObjectWithFile:s_filePath];
    if(s_array){
        [self.s_ideal setArray:s_array];
    }
    //目的地履歴
    NSArray *g_array = [NSKeyedUnarchiver unarchiveObjectWithFile:g_filePath];
    if(g_array){
        [self.g_ideal setArray:g_array];
    }
    TimeManagement *timeManagement;
    for (timeManagement in self.dataController.masterTimeManagementList) {
        TimeManagement *management;
        management = [[TimeManagement alloc] initWithOccasion:timeManagement.occasion start:timeManagement.start goal:timeManagement.goal time:timeManagement.time day:timeManagement.day];
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

-(void) detailViewControllerDidCalcel:(TimeManagementDetailViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// doneが押されたら、リストに追加
- (void)registeringViewControllerDidFinish:(RegisteringViewController *)controller ocassion:(NSString *)ocassion start:(NSString *)start goal:(NSString *)goal time:(NSDate *)time day:(NSMutableArray *)day; {
    [self.dataController addTimeManagementWithOccasion:ocassion start:start goal:goal time:time day:day];
    
    NSArray *datalist = [NSArray arrayWithArray:self.dataController.masterTimeManagementList];
    
    NSMutableArray *mondaylist = [[NSMutableArray alloc] init];
    NSMutableArray *tuedaylist = [[NSMutableArray alloc] init];
    NSMutableArray *weddaylist = [[NSMutableArray alloc] init];
    NSMutableArray *thudaylist = [[NSMutableArray alloc] init];
    NSMutableArray *fridaylist = [[NSMutableArray alloc] init];
    NSMutableArray *satdaylist = [[NSMutableArray alloc] init];
    NSMutableArray *sundaylist = [[NSMutableArray alloc] init];
    NSMutableArray *nonedaylist = [[NSMutableArray alloc] init];
    NSString *mon_chr = @"月";
    NSString *tue_chr = @"火";
    NSString *wed_chr = @"水";
    NSString *thu_chr = @"木";
    NSString *fri_chr = @"金";
    NSString *sat_chr = @"土";
    NSString *sun_chr = @"日";
    
    TimeManagement *data;
    
    for (data in datalist) {
        NSArray *daylist = [NSArray arrayWithArray: data.day];
        if ([daylist containsObject:mon_chr]) {
            [mondaylist addObject: data];
        }
        if ([daylist containsObject:tue_chr]) {
            [tuedaylist addObject:data];
        }
        if ([daylist containsObject:wed_chr]) {
            [weddaylist addObject:data];
        }
        if ([daylist containsObject:thu_chr]) {
            [thudaylist addObject:data];
        }
        if ([daylist containsObject:fri_chr]) {
            [fridaylist addObject:data];
        }
        if ([daylist containsObject:sat_chr]) {
            [satdaylist addObject:data];
        }
        if ([daylist containsObject:sun_chr]) {
            [sundaylist addObject:data];
        }
        if ([daylist count] == 0) {
            [nonedaylist addObject:data];
        }
    }
    
    NSArray *monlist = [NSArray arrayWithArray:mondaylist];
    NSArray *tuelist = [NSArray arrayWithArray:tuedaylist];
    NSArray *wedlist = [NSArray arrayWithArray:weddaylist];
    NSArray *thulist = [NSArray arrayWithArray:thudaylist];
    NSArray *frilist = [NSArray arrayWithArray:fridaylist];
    NSArray *satlist = [NSArray arrayWithArray:satdaylist];
    NSArray *sunlist = [NSArray arrayWithArray:sundaylist];
    NSArray *nonelist = [NSArray arrayWithArray:nonedaylist];
    
    
    self.sectionDatas = [[NSArray alloc] initWithObjects:monlist, tuelist, wedlist, thulist, frilist, satlist ,sunlist, nonelist, nil];
        
    [[self tableView] reloadData];
    
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [directory stringByAppendingPathComponent:@"timemanagement.dat"];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    array = [self.dataController getList];
    [NSKeyedArchiver archiveRootObject:array toFile:filePath];
    //それぞれの履歴のデータを保存
    NSString *o_filePath = [directory stringByAppendingPathComponent:@"occasion.dat"];
    NSString *s_filePath = [directory stringByAppendingPathComponent:@"start.dat"];
    NSString *g_filePath = [directory stringByAppendingPathComponent:@"goal.dat"];
    [NSKeyedArchiver archiveRootObject:self.o_ideal toFile:o_filePath];
    [NSKeyedArchiver archiveRootObject:self.s_ideal toFile:s_filePath];
    [NSKeyedArchiver archiveRootObject:self.g_ideal toFile:g_filePath];
    [self dismissViewControllerAnimated:YES completion:NULL];
    }



//-----------------------------------------------------変更点-----------------------------------------------------------------------





-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"addTime"]){
        RegisteringViewController *addTime = (RegisteringViewController *)[[[segue destinationViewController]viewControllers]objectAtIndex:0];
        addTime.delegate = self;
        addTime.o_ideal = self.o_ideal;
        addTime.s_ideal = self.s_ideal;
        addTime.g_ideal = self.g_ideal;
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
    TimeManagementDetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"timemanagementdetail"];
    detailViewController.delegate = self;
    
    if (self.flag != 1) {
        detailViewController.timeManagement =[self.dataController
                                              objectInListAtIndex:[self.tableView indexPathForSelectedRow].row];
        detailViewController.delegate = self;
        [self presentViewController:detailViewController animated:YES completion:nil];
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
        [self presentViewController:detailViewController animated:YES completion:nil];
    }

    
    
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
                //データの消去
                [self.dataController removeMasterTimeManagementWithObject:time];
            }
            
            NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            NSString *filePath = [directory stringByAppendingPathComponent:@"timemanagement.dat"];
            NSMutableArray *array = [[NSMutableArray alloc] init];
            array = [self.dataController getList];
            [NSKeyedArchiver archiveRootObject:array toFile:filePath];
            
            NSArray *datalist = [NSArray arrayWithArray:self.dataController.masterTimeManagementList];
            
            NSMutableArray *mondaylist = [[NSMutableArray alloc] init];
            NSMutableArray *tuedaylist = [[NSMutableArray alloc] init];
            NSMutableArray *weddaylist = [[NSMutableArray alloc] init];
            NSMutableArray *thudaylist = [[NSMutableArray alloc] init];
            NSMutableArray *fridaylist = [[NSMutableArray alloc] init];
            NSMutableArray *satdaylist = [[NSMutableArray alloc] init];
            NSMutableArray *sundaylist = [[NSMutableArray alloc] init];
            NSMutableArray *nonedaylist = [[NSMutableArray alloc] init];
            NSString *mon_chr = @"月";
            NSString *tue_chr = @"火";
            NSString *wed_chr = @"水";
            NSString *thu_chr = @"木";
            NSString *fri_chr = @"金";
            NSString *sat_chr = @"土";
            NSString *sun_chr = @"日";
            
            TimeManagement *data;
            
            for (data in datalist) {
                NSArray *daylist = [NSArray arrayWithArray: data.day];
                if ([daylist containsObject:mon_chr]) {
                    [mondaylist addObject: data];
                }
                if ([daylist containsObject:tue_chr]) {
                    [tuedaylist addObject:data];
                }
                if ([daylist containsObject:wed_chr]) {
                    [weddaylist addObject:data];
                }
                if ([daylist containsObject:thu_chr]) {
                    [thudaylist addObject:data];
                }
                if ([daylist containsObject:fri_chr]) {
                    [fridaylist addObject:data];
                }
                if ([daylist containsObject:sat_chr]) {
                    [satdaylist addObject:data];
                }
                if ([daylist containsObject:sun_chr]) {
                    [sundaylist addObject:data];
                }
                if ([daylist count] == 0) {
                    [nonedaylist addObject:data];
                }
            }
            
            NSArray *monlist = [NSArray arrayWithArray:mondaylist];
            NSArray *tuelist = [NSArray arrayWithArray:tuedaylist];
            NSArray *wedlist = [NSArray arrayWithArray:weddaylist];
            NSArray *thulist = [NSArray arrayWithArray:thudaylist];
            NSArray *frilist = [NSArray arrayWithArray:fridaylist];
            NSArray *satlist = [NSArray arrayWithArray:satdaylist];
            NSArray *sunlist = [NSArray arrayWithArray:sundaylist];
            NSArray *nonelist = [NSArray arrayWithArray:nonedaylist];
            
            
            self.sectionDatas = [[NSArray alloc] initWithObjects:monlist, tuelist, wedlist, thulist, frilist, satlist ,sunlist, nonelist, nil];
                        
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
                
                NSMutableArray *mondaylist = [[NSMutableArray alloc] init];
                NSMutableArray *tuedaylist = [[NSMutableArray alloc] init];
                NSMutableArray *weddaylist = [[NSMutableArray alloc] init];
                NSMutableArray *thudaylist = [[NSMutableArray alloc] init];
                NSMutableArray *fridaylist = [[NSMutableArray alloc] init];
                NSMutableArray *satdaylist = [[NSMutableArray alloc] init];
                NSMutableArray *sundaylist = [[NSMutableArray alloc] init];
                NSMutableArray *nonedaylist = [[NSMutableArray alloc] init];
                NSString *mon_chr = @"月";
                NSString *tue_chr = @"火";
                NSString *wed_chr = @"水";
                NSString *thu_chr = @"木";
                NSString *fri_chr = @"金";
                NSString *sat_chr = @"土";
                NSString *sun_chr = @"日";
                
                TimeManagement *data;
                
                for (data in datalist) {
                    NSArray *daylist = [NSArray arrayWithArray: data.day];
                    if ([daylist containsObject:mon_chr]) {
                        [mondaylist addObject: data];
                    }
                    if ([daylist containsObject:tue_chr]) {
                        [tuedaylist addObject:data];
                    }
                    if ([daylist containsObject:wed_chr]) {
                        [weddaylist addObject:data];
                    }
                    if ([daylist containsObject:thu_chr]) {
                        [thudaylist addObject:data];
                    }
                    if ([daylist containsObject:fri_chr]) {
                        [fridaylist addObject:data];
                    }
                    if ([daylist containsObject:sat_chr]) {
                        [satdaylist addObject:data];
                    }
                    if ([daylist containsObject:sun_chr]) {
                        [sundaylist addObject:data];
                    }
                    if ([daylist count] == 0) {
                        [nonedaylist addObject:data];
                    }
                }
                
                NSArray *monlist = [NSArray arrayWithArray:mondaylist];
                NSArray *tuelist = [NSArray arrayWithArray:tuedaylist];
                NSArray *wedlist = [NSArray arrayWithArray:weddaylist];
                NSArray *thulist = [NSArray arrayWithArray:thudaylist];
                NSArray *frilist = [NSArray arrayWithArray:fridaylist];
                NSArray *satlist = [NSArray arrayWithArray:satdaylist];
                NSArray *sunlist = [NSArray arrayWithArray:sundaylist];
                NSArray *nonelist = [NSArray arrayWithArray:nonedaylist];
                
                
                self.sectionDatas = [[NSArray alloc] initWithObjects:monlist, tuelist, wedlist, thulist, frilist, satlist ,sunlist, nonelist, nil];
                
                self.flag = 1;
                
                
                [[self tableView] reloadData];
                break;
            }
        }
        
    }
    }


@end
