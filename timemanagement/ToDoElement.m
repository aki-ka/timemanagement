//
//  ToDoElement.m
//  timemanagement
//
//  Created by AkiraYoshihara on 12/12/01.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import "ToDoElement.h"

@implementation ToDoElement

@synthesize doing =_doing,time = _time,information=_information,check=_check,repeat=_repeat,day=_day,min=_min;

-(id)initWithCoder:(NSCoder*)decoder{
    self = [super init];
    if (self) {
        _doing = [decoder decodeObjectForKey:@"doing"];
        _time = [decoder decodeObjectForKey:@"time"];
        _information = [decoder decodeBoolForKey:@"information"];
        _check = [decoder decodeBoolForKey:@"check"];
        _repeat = [decoder decodeBoolForKey:@"repeat"];
        _day = [decoder decodeIntegerForKey:@"day"];
        _min = [decoder decodeIntegerForKey:@"min"];
    }
    return self;
}


-(id)initWithDoing:(NSString *)doing time:(NSString *)time information:(BOOL)information repeat:(BOOL)repeat day:(int)day min:(int)min{
    self = [super init];
    if (self) {
    _doing = doing;
    _time = time;
    _information = information;
        _check= NO;
        _repeat = repeat;
        _day = day;
        _min = min;
        return self;
    }
    return nil;
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:_doing forKey:@"doing"];
    [encoder encodeObject:_time forKey:@"time"];
    [encoder encodeBool:_information forKey:@"information"];
    [encoder encodeBool:_check forKey:@"check"];
    [encoder encodeBool:_repeat forKey:@"repeat"];
    [encoder encodeInt:_day forKey:@"day"];
    [encoder encodeInt:_min forKey:@"min"];
}

-(void)dealloc{
    self.doing =nil;
    self.time=nil;
    self.day=0;
    self.min=0;
}

@end
