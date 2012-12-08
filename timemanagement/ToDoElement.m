//
//  ToDoElement.m
//  timemanagement
//
//  Created by AkiraYoshihara on 12/12/01.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import "ToDoElement.h"

@implementation ToDoElement

@synthesize doing =_doing,time = _time,information=_information,check=_check;

-(id)initWithCoder:(NSCoder*)decoder{
    self = [super init];
    if (self) {
        _doing = [decoder decodeObjectForKey:@"doing"];
        _time = [decoder decodeObjectForKey:@"time"];
        _information = [decoder decodeBoolForKey:@"information"];
        _check = [decoder decodeBoolForKey:@"check"];
    }
    return self;
}


-(id)initWithDoing:(NSString *)doing time:(NSString *)time information:(BOOL)information{
    self = [super init];
    if (self) {
    _doing = doing;
    _time = time;
    _information = information;
        _check= NO;
        return self;
    }
    return nil;
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:_doing forKey:@"doing"];
    [encoder encodeObject:_time forKey:@"time"];
    [encoder encodeBool:_information forKey:@"information"];
    [encoder encodeBool:_check forKey:@"check"];
}

-(void)dealloc{
    self.doing =nil;
    self.time=nil;
}

@end
