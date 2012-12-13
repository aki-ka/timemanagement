//
//  Timemanagement.h
//  timemanagement
//
//  Created by AkiraYoshihara on 12/11/23.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeManagement : NSObject<NSCoding>
//状況
@property (nonatomic, copy) NSString *occasion;
//出発地
@property (nonatomic, copy) NSString *start;
//目的地
@property (nonatomic, copy) NSString *goal;
//時間
@property (nonatomic, strong) NSDate *time;
//曜日
@property (nonatomic, copy) NSString *res;

@property (nonatomic, copy) NSMutableArray *day;


-(id)initWithOccasion:(NSString *)occasion start:(NSString *)start goal:(NSString *)goal time:(NSDate *)time day:(NSMutableArray *)day;

-(NSString *)getDayOfTheWeek;

-(NSString *)getTextLabel;

-(NSString *)getTextDetailLabel;

-(NSComparisonResult)compareDate:(TimeManagement *)data;

-(NSComparisonResult)compareNum:(TimeManagement *)data;

@end
