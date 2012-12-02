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

//消去
- (void) removemasterToDoListAtIndexes:(NSIndexSet *)indexes{
    [self.masterToDoList removeObjectsAtIndexes:indexes];
}
//要素を追加する
- (void)addToDoElementWithDoing:(NSString *)doing time:(NSString *)time information:(BOOL)information {
    ToDoElement *todoElement;
    todoElement = [[ToDoElement alloc] initWithDoing:doing time:time information:information];
    [self.masterToDoList addObject:todoElement];
}

-(NSMutableArray *) getList{
    return self.masterToDoList;
}
@end
