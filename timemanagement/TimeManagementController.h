//
//  TimeManagementController.h
//  timemanagement
//
//  Created by AkiraYoshihara on 12/11/23.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TimeManagement;
@interface TimeManagementController : NSObject


@property (nonatomic, copy) NSMutableArray *masterTimeManagementList;

- (NSUInteger)countOfList;

- (TimeManagement *)objectInListAtIndex:(NSUInteger)theIndex;

- (void)addTimeManagementWithOccasion:(NSString *)inputOccasion start:(NSString *)inputStart goal:(NSString *)inputGoal time:(NSDate *) inputTime day:(NSInteger)inputDay;
//getter
-(NSMutableArray *)getList;

-(void)removeMasterTimeManagementAtIndexes:(NSIndexSet *)indexSet;

-(void)removeMasterTimeManagementWithObject:(TimeManagement *)timeManagement;

-(void)sortDate;

-(void)sortDay;

@end
