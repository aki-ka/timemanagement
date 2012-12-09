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
@property (nonatomic) BOOL repeat;
@property (nonatomic) int day;
@property (nonatomic) int min;
//ToDoが完了したことを知らせる
@property (nonatomic) BOOL check;
//初期化
-(id)initWithDoing:(NSString *)doing time:(NSString *)time information:(BOOL) information repeat:(BOOL) repeat day:(int) day min:(int) min;

@end
