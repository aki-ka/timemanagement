//
//  TimeManagementController.m
//  timemanagement
//
//  Created by AkiraYoshihara on 12/11/23.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import "TimeManagementController.h"
#import "TimeManagement.h"

@interface TimeManagementController ()
- (void)initializeDefaultDataList;
@end

@implementation TimeManagementController
//initialize
@synthesize masterTimeManagementList = _masterTimeManagementList;

- (id)init {
    if (self = [super init]) {
        [self initializeDefaultDataList];
        return self;
    }
    return nil; }


- (void) initializeDefaultDataList {
    NSMutableArray *managementList = [[NSMutableArray alloc] init];
    self.masterTimeManagementList = managementList;
}

//setter
- (void)setMasterTimeManagementList:(NSMutableArray *)newList {
    if (_masterTimeManagementList != newList) {
        _masterTimeManagementList = [newList mutableCopy];
    }
}
//要素の数を返す
- (NSUInteger)countOfList {
    return [self.masterTimeManagementList count];
}
//

- (TimeManagement *)objectInListAtIndex:(NSUInteger)theIndex {
    return [self.masterTimeManagementList objectAtIndex:theIndex];
}
//要素を追加する
- (void)addTimeManagementWithOccasion:(NSString *)inputOccasion start:(NSString *)inputStart goal:(NSString *)inputGoal time:(NSDate *)inputTime day:(NSInteger)inputDay {
    TimeManagement *management;
    management = [[TimeManagement alloc] initWithOccasion:inputOccasion start:inputStart goal:inputGoal time:inputTime day:inputDay];
    [self.masterTimeManagementList addObject:management];
}

-(NSMutableArray *)getList{
    return self.masterTimeManagementList;
}

-(void)removeMasterTimeManagementAtIndexes:(NSIndexSet *)indexSet {
    [self.masterTimeManagementList removeObjectsAtIndexes:indexSet];
}

-(void)sortDate {
    NSArray *sortdate = [self.masterTimeManagementList sortedArrayUsingSelector:@selector(compareDate:)];
    self.masterTimeManagementList = [NSMutableArray arrayWithArray:sortdate];
}

-(void)sortDay {
    NSArray *sortday = [self.masterTimeManagementList sortedArrayUsingSelector:@selector(compareNum:)];
    self.masterTimeManagementList = [NSMutableArray arrayWithArray:sortday];
}
@end
