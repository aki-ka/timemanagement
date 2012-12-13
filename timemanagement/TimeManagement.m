//
//  Timemanagement.m
//  timemanagement
//
//  Created by AkiraYoshihara on 12/11/23.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import "TimeManagement.h"

@implementation TimeManagement
//初期化
@synthesize occasion = _occasion, start = _start, goal = _goal, time =_time, day =_day, res=_res;

- (id)init {
    if (self = [super init]) {
        [self initializeDefaultDataList];
        return self;
    }
    return nil;
}

- (void) initializeDefaultDataList {
    NSMutableArray *daylist = [[NSMutableArray alloc] init];
    _day = daylist;
}

- (void)setdayList:(NSMutableArray *)newList {
    if (_day != newList) {
        _day = [newList mutableCopy];
    }
}


-(id) initWithCoder:(NSCoder *) decoder{
    self = [super init];
    if (self) {
        _occasion = [decoder decodeObjectForKey:@"occasion"];
        _start = [decoder decodeObjectForKey:@"start"];
        _goal = [decoder decodeObjectForKey:@"goal"];
        _time = [decoder decodeObjectForKey:@"time"];
        _day = [decoder decodeObjectForKey:@"day"];
    }
    return self;

    
}

-(id)initWithOccasion:(NSString *)occasion start:(NSString *)start goal:(NSString *)goal time:(NSDate *)time day:(NSMutableArray *)day
{
    self = [super init];
    if (self) {
        _occasion = occasion;
        _start = start;
        _goal = goal;
        _time = time;
        [self initializeDefaultDataList];
        [self setdayList:day];
        return self;
    }
    return nil;
}

-(NSString *)getDayOfTheWeek {
    NSArray *array = [NSArray arrayWithObjects:@"月", @"火", @"水", @"木", @"金", @"土", @"日", @"", nil];
    NSString *day1;
    NSString *day2;
    
    self.res = @"";
    
    NSArray *daylist = [NSArray arrayWithArray:self.day];
    for (day1 in daylist) {
        for (day2 in array) {
            if  ([day1 isEqualToString: day2]) {
                self.res = [NSString stringWithFormat:@"%@ %@", self.res, day2];
            }
        }
    }
    if ([self.res isEqualToString:@" 月 火 水 木 金"]) {
        self.res = @"平日";
    }
    if ([self.res isEqualToString:@" 土 日"]) {
        self.res = @"休日";
    }
    return self.res;
}

-(NSString *)getTextLabel {
    static NSDateFormatter *formatter = nil;
    
    if(formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH時mm分"];
    }
    
    NSString *textLabel = [NSString stringWithFormat:@"%@   %@",[formatter stringFromDate:(NSDate *)self.time], self.occasion];
    return textLabel;
}

-(NSString *)getTextDetailLabel {
    NSString  *detailTextLabel = [NSString stringWithFormat:@"%@ - %@   %@", self.start, self.goal, [self getDayOfTheWeek]];
    return detailTextLabel;
}

-(NSComparisonResult)compareDate:(TimeManagement *)data {
    NSString* date_converted1;
    NSString* date_converted2;
    
    // NSDateFormatter を用意します。
    NSDateFormatter* formatter1 = [[NSDateFormatter alloc] init];
    NSDateFormatter* formatter2 = [[NSDateFormatter alloc] init];
    
    // 変換用の書式を設定します。
    [formatter1 setDateFormat:@"HH"];
    [formatter2 setDateFormat:@"mm"];
    
    // NSDate を NSString に変換します。
    date_converted1 = [formatter1 stringFromDate:self.time];
    date_converted2 = [formatter2 stringFromDate:self.time];
    
    NSString* date1 = [NSString stringWithFormat:@"%@:%@", date_converted1, date_converted2];
    
    NSString* date_converted3;
    NSString* date_converted4;
    
    // NSDateFormatter を用意します。
    NSDateFormatter* formatter3 = [[NSDateFormatter alloc] init];
    NSDateFormatter* formatter4 = [[NSDateFormatter alloc] init];
    
    // 変換用の書式を設定します。
    [formatter3 setDateFormat:@"HH"];
    [formatter4 setDateFormat:@"mm"];
    
    // NSDate を NSString に変換します。
    date_converted3 = [formatter3 stringFromDate:data.time];
    date_converted4 = [formatter4 stringFromDate:data.time];
    
    NSString* date2 = [NSString stringWithFormat:@"%@:%@", date_converted3, date_converted4];
    
    NSDateFormatter* formatter5 = [[NSDateFormatter alloc] init];
    NSDateFormatter* formatter6 = [[NSDateFormatter alloc] init];
    
    [formatter5 setDateFormat:@"HH:mm"];
    [formatter6 setDateFormat:@"HH:mm"];
    
    NSDate* date_converted5;
    NSDate* date_converted6;
    
    date_converted5 = [formatter5 dateFromString:date1];
    date_converted6 = [formatter6 dateFromString:date2];
    
    NSDate* date;
    
	date = [NSDate dateWithTimeIntervalSinceNow:0.0f];
    
    NSDateFormatter* formatter7 = [[NSDateFormatter alloc] init];
    
    [formatter7 setDateFormat:@"HH:mm"];
    
    NSString* date_converted7 = [formatter7 stringFromDate:date];
    
    NSDateFormatter* formatter8 = [[NSDateFormatter alloc] init];
    
    [formatter8 setDateFormat:@"HH:mm"];
    
    NSDate* date_converted8 = [formatter8 dateFromString:date_converted7];
    
    NSTimeInterval since1 = [date_converted5 timeIntervalSinceDate:date_converted8];
    NSTimeInterval since2 = [date_converted6 timeIntervalSinceDate:date_converted8];
    
    
    if (since1 < since2 && since1 > 0 && since2 > 0) {
        return NSOrderedAscending;
    } else if (since1 > since2 && since1 > 0 && since2 > 0) {
        return NSOrderedDescending;
    } else if (since1 > since2 && since1 <= 0 && since2 <= 0) {
        return NSOrderedDescending;
    } else if (since1 < since2 && since1 <= 0 && since2 <= 0) {
        return NSOrderedAscending;
    } else if (since1 < 0 && since2 > 0) {
        return NSOrderedDescending;
    } else if (since1 > 0 && since2 < 0) {
        return NSOrderedAscending;
    } else {
        return NSOrderedSame;
    }

}

-(NSComparisonResult)compareNum:(TimeManagement *)data {
    if (self.day < data.day) {
        return NSOrderedAscending;
    } else if (self.day > data.day) {
        return NSOrderedDescending;
    } else {
        return NSOrderedSame;
    }
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:_occasion forKey:@"occasion"];
    [encoder encodeObject:_start forKey:@"start"];
    [encoder encodeObject:_goal forKey:@"goal"];
    [encoder encodeObject:_time forKey:@"time"];
    [encoder encodeObject:_day forKey:@"day"];
}

-(void)dealloc{
    self.occasion =nil;
    self.start = nil;
    self.goal = nil;
    self.time=0;
    self.day = nil;
}





@end
