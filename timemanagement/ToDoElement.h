//
//  ToDoElement.h
//  timemanagement
//
//  Created by AkiraYoshihara on 12/12/01.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoElement : NSObject<NSCoding>

@property (nonatomic , copy) NSString *doing;
@property (nonatomic , copy) NSString *time;
@property (nonatomic) BOOL information;
-(id)initWithDoing:(NSString *)doing time:(NSString *)time information:(BOOL) information;

@end
