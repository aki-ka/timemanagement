//
//  ToDo.m
//  timemanagement
//
//  Created by AkiraYoshihara on 12/12/01.
//  Copyright (c) 2012年 AkiraYoshihara. All rights reserved.
//

#import "ToDo.h"
#import "ToDoElement.h"

@interface ToDo ()
- (void)initializeDefaultDataList;
@end

@implementation ToDo

@synthesize masterToDoList = _masterToDoList;

- (id)init {
    if (self = [super init]) {
        [self initializeDefaultDataList];
        return self;
    }
    return nil; }


- (void) initializeDefaultDataList {
    NSMutableArray *todoList = [[NSMutableArray alloc] init];
    self.masterToDoList = todoList;
   
}

//setter
- (void)setMasterTimeManagementList:(NSMutableArray *)newList {
    if (_masterToDoList != newList) {
        _masterToDoList = [newList mutableCopy];
    }
}
//要素の数を返す
- (NSUInteger)countOfList {
    return [self.masterToDoList count];
}
//

- (ToDoElement *)objectInListAtIndex:(NSUInteger)theIndex {
    return [self.masterToDoList objectAtIndex:theIndex];
}

//index番目の要素を入れ替える
-(void) exchangeToDoElement:(NSString *)doing time:(NSString *)time information:(BOOL)information repeat:(BOOL)repeat day:(int)day min:(int)min index:(NSInteger)index{
    [self.masterToDoList removeObjectAtIndex:index];
    ToDoElement *todoElement;
    todoElement = [[ToDoElement alloc] initWithDoing:doing time:time information:information repeat:repeat day:day min:min];
    [self.masterToDoList insertObject:todoElement atIndex:index];
}
//消去
- (void) removemasterToDoListAtIndexes:(NSIndexSet *)indexes{
    [self.masterToDoList removeObjectsAtIndexes:indexes];
}
//要素を追加する
- (void)addToDoElementWithDoing:(NSString *)doing time:(NSString *)time information:(BOOL)information repeat:(BOOL)repeat day:(int)day min:(int)min{
    ToDoElement *todoElement;
    todoElement = [[ToDoElement alloc] initWithDoing:doing time:time information:information repeat:repeat day:day min:min];
    [self.masterToDoList addObject:todoElement];
}

-(NSMutableArray *) getList{
    return self.masterToDoList;
}
@end
