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
<AdittionToDoViewControllerDelegate,DetailViewControllerDelegate>

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
//通知センターから選ばれたら通知を消去
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    // キャンセル処理
    [[UIApplication sharedApplication] cancelLocalNotification:notification];
    if (notification.repeatInterval) {
        // 繰り返しありの場合は再登録
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}

//詳細画面でキャンセルが押されたら
-(void) detailViewControllerDidBack:(DetailViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//詳細画面で決定が押されたら
-(void) detailViewControllerDidFinish:(DetailViewController *)controller todo:(NSString *)todo time:(NSString *)time infomation:(BOOL)information repeat:(BOOL)repeat day:(int)day min:(int)min index:(NSInteger)index{
    //登録処理
    [self.ToDoList exchangeToDoElement:todo time:time information:information repeat:repeat day:day min:min index:index];
    [[self tableView] reloadData];
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [directory stringByAppendingPathComponent:@"todo.dat"];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    array = [self.ToDoList getList];
    [NSKeyedArchiver archiveRootObject:array toFile:filePath];
    
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    //通知がYESだったら
    if (information) {
        BOOL single = YES;
        //重複しているかどうか確かめる
        int a =[ [[UIApplication sharedApplication] scheduledLocalNotifications] count];
        NSLog(@"%d",a);
        for (UILocalNotification *notify in [[UIApplication sharedApplication] scheduledLocalNotifications]){
            NSString *key = [notify.userInfo objectForKey:@"todo"];
            if([key isEqual:todo]){
                single = NO;
                break;
            }
        }
        //重複していなければ登録
        if(single){
            UILocalNotification *localPush = [[UILocalNotification alloc] init];
            //タイムゾーン設定
            localPush.timeZone = [NSTimeZone defaultTimeZone];
            //表示タイミング
            
            //スペースで分割
            NSArray *date_time = [time componentsSeparatedByString:@" "];
            NSString *date_text = [date_time objectAtIndex:0];
            NSString *time_text = [date_time objectAtIndex:1];
            //時間があれば
            if([time_text length] != 0){
                NSDate *formatterDate = [[NSDate alloc] init];
                //日付があれば
                if([date_text length] != 0){
                    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
                    [inputFormatter setDateFormat:@"MM/dd HH:mm"];
                    formatterDate = [inputFormatter dateFromString:time];
                }
                //日付がなければ
                else{
                    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
                    [inputFormatter setDateFormat:@"HH:mm"];
                    formatterDate = [inputFormatter dateFromString:time_text];
                }
                NSDate *now =[NSDate date];
                //現在時刻との差を算出
                NSTimeInterval since = [formatterDate timeIntervalSinceDate:now];
                localPush.fireDate = [NSDate dateWithTimeIntervalSinceNow:since];
            }
            //時間がなければ、すぐに通知
            else{
                localPush.fireDate = [NSDate dateWithTimeIntervalSinceNow:1];
            }
            
            //繰り返しの設定
            if(repeat){
                switch (day) {
                        //毎日のとき
                    case 1:
                        localPush.repeatInterval = NSDayCalendarUnit;
                        break;
                        //毎週のとき
                    case 2:
                        localPush.repeatInterval = NSWeekCalendarUnit;
                        break;
                        //毎月のとき
                    default:
                        localPush.repeatInterval = NSMonthCalendarUnit;
                        break;
                }
            }
            //メッセージ
            localPush.alertBody = todo;
            //バッジ表示
            localPush.applicationIconBadgeNumber = 0;
            //特定できるようにキーを設定
            [localPush setUserInfo:[NSDictionary  dictionaryWithObject:todo forKey:@"todo"]];
            //登録
            [[UIApplication sharedApplication] scheduleLocalNotification:localPush];
        }
    }
}

//キャンセルを押されたら
-(void) additionToDoViewControllerDidCancel:(AdittionToDoViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
//doneを押されたら、それぞれのリストに追加
-(void) additionToDoViewControllerDidFinish:(AdittionToDoViewController *)controller todo:(NSString *)todo time:(NSString *)time information:(BOOL)information repeat:(BOOL)repeat day:(int)day min:(int)min{
       [self.ToDoList addToDoElementWithDoing:todo time:time information:information repeat:repeat day:day min:min];
    [[self tableView] reloadData];
    //保存
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [directory stringByAppendingPathComponent:@"todo.dat"];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    array = [self.ToDoList getList];
       [NSKeyedArchiver archiveRootObject:array toFile:filePath];
     //遷移先の画面の消去
    [self dismissViewControllerAnimated:YES completion:NULL];
    //通知がYESだったら
    if (information) {
        BOOL single = YES;
        //重複しているかどうか確かめる
        for (UILocalNotification *notify in [[UIApplication sharedApplication] scheduledLocalNotifications]){
            NSString *key = [notify.userInfo objectForKey:todo];
            if([key isEqual:todo]){
                 single = NO;
                break;
            }
        }
        //重複していなければ登録
        if(single){
        UILocalNotification *localPush = [[UILocalNotification alloc] init];
        //タイムゾーン設定
        localPush.timeZone = [NSTimeZone defaultTimeZone];
        //表示タイミング
            
            //スペースで分割
            NSArray *date_time = [time componentsSeparatedByString:@" "];
            NSString *date_text = [date_time objectAtIndex:0];
            NSString *time_text = [date_time objectAtIndex:1];
            //時間があれば
            if([time_text length] != 0){
                NSDate *formatterDate = [[NSDate alloc] init];
                //日付があれば
                if([date_text length] != 0){
                NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
                [inputFormatter setDateFormat:@"MM/dd HH:mm"];
                formatterDate = [inputFormatter dateFromString:time];
                }
                //日付がなければ
            else{
                NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
                [inputFormatter setDateFormat:@"HH:mm"];
                formatterDate = [inputFormatter dateFromString:time_text];
            }
                NSDate *now =[NSDate date];
                //現在時刻との差を算出
                NSTimeInterval since = [formatterDate timeIntervalSinceDate:now];
                localPush.fireDate = [NSDate dateWithTimeIntervalSinceNow:since];
            }
            //時間がなければ、すぐに通知
            else{
                localPush.fireDate = [NSDate dateWithTimeIntervalSinceNow:1];
            }
            
               //繰り返しの設定
            if(repeat){
                switch (day) {
                        //毎日のとき
                    case 1:
                        localPush.repeatInterval = NSDayCalendarUnit;
                        break;
                        //毎週のとき
                    case 2:
                        localPush.repeatInterval = NSWeekCalendarUnit;
                        break;
                        //毎月のとき
                    default:
                        localPush.repeatInterval = NSMonthCalendarUnit;
                        break;
                }                
            }
            //メッセージ
            localPush.alertBody = todo;
            //バッジ表示
            localPush.applicationIconBadgeNumber = 0;
            //特定できるようにキーを設定
            [localPush setUserInfo:[NSDictionary  dictionaryWithObject:todo forKey:@"todo"]];

        //登録
        [[UIApplication sharedApplication] scheduleLocalNotification:localPush];
        }
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
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    if([self.ToDoList objectInListAtIndex:indexPath.row].check){
        cell.accessoryType =UITableViewCellAccessoryCheckmark;
        [cell.textLabel setEnabled:NO];
       }
    else{
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    
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
{ //選択されたセルを取得
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //編集状態でなければ
    if(!tableView.editing){
        //選択状態の解除
       [tableView deselectRowAtIndexPath:indexPath animated:YES];
        //詳細用のアクセサリをチェックマークに変え、テキストを薄い色に
        if(cell.accessoryType == UITableViewCellAccessoryDetailDisclosureButton){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [cell.textLabel setEnabled:NO];
            //チェックされたとする
        [self.ToDoList objectInListAtIndex:indexPath.row].check = YES;
            //保存
            NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            NSString *filePath = [directory stringByAppendingPathComponent:@"todo.dat"];
            NSMutableArray *array = [[NSMutableArray alloc] init];
            array = [self.ToDoList getList];
            [NSKeyedArchiver archiveRootObject:array toFile:filePath];
            //通知を消去
            for (UILocalNotification *notify in [[UIApplication sharedApplication] scheduledLocalNotifications]){
                NSString *key = [notify.userInfo objectForKey:cell.textLabel.text];
                if([key isEqual:cell.textLabel.text]){
                    [[UIApplication sharedApplication] cancelLocalNotification:notify];
                    break;
                }
            }
            
        }
        //その逆
        else{
            cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
            [cell.textLabel setEnabled:YES];
            [self.ToDoList objectInListAtIndex:indexPath.row].check = NO;
            //保存
            NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            NSString *filePath = [directory stringByAppendingPathComponent:@"todo.dat"];
            NSMutableArray *array = [[NSMutableArray alloc] init];
            array = [self.ToDoList getList];
            [NSKeyedArchiver archiveRootObject:array toFile:filePath];

        }
    }
   
    }
//アクセサリが押されたら詳細画面へ飛ぶ
- (void)tableView:(UITableView *)tableView
accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if(cell.accessoryType == UITableViewCellAccessoryDetailDisclosureButton){
    DetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    controller.delegate = self;
    controller.element = [self.ToDoList objectInListAtIndex:indexPath.row];
    controller.index = indexPath.row;
    [self presentViewController:controller animated:YES completion:nil];
    }
  }

//追加画面へ飛ぶ
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
