//
//  ToDo.h
//  timemanagement
//
//  Created by AkiraYoshihara on 12/12/01.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ToDoElement;
@interface ToDo : NSObject

@property (nonatomic, retain) NSMutableArray *masterToDoList;

- (NSUInteger)countOfList;

- (ToDoElement *)objectInListAtIndex:(NSUInteger)theIndex;

-(void)removemasterToDoListAtIndexes:(NSIndexSet *)indexes;

- (void)addToDoElementWithDoing:(NSString *)doing time:(NSString *)time information:(BOOL) information repeat:(BOOL) repeat day:(int) day min:(int) min;

-(void) exchangeToDoElement:(NSString *)doing time:(NSString *)time information:(BOOL) information repeat:(BOOL) repeat day:(int) day min:(int) min index:(NSInteger) index;

- (NSMutableArray *) getList;
@end
