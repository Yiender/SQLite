//
//  PersonManager.h
//  02.SQLite基本使用
//
//  Created by apple on 13-11-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "Person.h"

@interface PersonManager : NSObject

single_interface(PersonManager)

// 新增个人记录
- (void)addPerson:(Person *)person;

// 修改个人记录(修改传入Person对象ID对应的数据库记录的内容)
- (void)updatePerson:(Person *)person;

// 删除个人记录
- (void)removePerson:(NSInteger)personID;

// 查询所有用户信息列表
- (NSArray *)allPersons;

/**
 *  模糊查询所有姓名中包含name字符串的用户记录
 *
 *  @param name 姓名部分字符串
 *
 *  @return 查询结果集
 */
- (NSArray *)personsWithName:(NSString *)name;

@end
