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
@synthesize occasion = _occasion, start = _start, goal = _goal, time =_time, day =_day;

-(id) initWithCoder:(NSCoder *) decoder{
    self = [super init];
    if (self) {
        _occasion = [decoder decodeObjectForKey:@"occasion"];
        _start = [decoder decodeObjectForKey:@"start"];
        _goal = [decoder decodeObjectForKey:@"goal"];
        _time = [decoder decodeObjectForKey:@"time"];
        _day = [decoder decodeIntegerForKey:@"day"];
    }
    return self;

    
}

-(id)initWithOccasion:(NSString *)occasion start:(NSString *)start goal:(NSString *)goal time:(NSDate *)time day:(NSInteger)day
{
    self = [super init];
    if (self) {
        _occasion = occasion;
        _start = start;
        _goal = goal;
        _time = time;
        _day = day;
        return self;
    }
    return nil;
}

-(NSString *)getDayOfTheWeek {
    NSArray *array =
    [NSArray arrayWithObjects:@"月", @"火", @"水", @"木", @"金", @"土", @"日", @"", nil];
    return [array objectAtIndex: self.day];
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
    return [self.time compare:data.time];
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
    [encoder encodeInteger:_day forKey:@"day"];
}

-(void)dealloc{
    self.occasion =nil;
    self.start = nil;
    self.goal = nil;
    self.time=0;
    self.day = 0;
}





@end
