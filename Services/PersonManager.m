//
//  PersonManager.m
//  02.SQLite基本使用
//
//  Created by apple on 13-11-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "PersonManager.h"
#import <sqlite3.h>

@interface PersonManager()
{
    // SQLite数据库的连接，基于该连接可以进行数据库操作
    sqlite3 *_db;
}

@end

@implementation PersonManager
single_implementation(PersonManager)

// 在初始化方法中完成数据库连接工作
- (id)init
{
    self = [super init];
    
    if (self) {
        // 1. 创建(连接)数据库
        [self openDB];
        
        // 2. 创建数据表
        [self createTable];
    }
    
    return self;
}

#pragma mark - 数据库操作方法
/**
 *  打开数据库
 */
- (void)openDB
{
    // 生成存放在沙盒中的数据库完整路径
    NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbName = [docDir stringByAppendingPathComponent:@"my.db"];
    
    // 如果数据库不存在，怎新建并打开一个数据库，否则直接打开
    if (SQLITE_OK == sqlite3_open(dbName.UTF8String, &_db)) {
        NSLog(@"创建/打开数据库成功。");
    } else {
        NSLog(@"创建/打开数据库失败。");
    }
}

/**
 *  指定单步sql指令
 *
 *  @param sql sql语句
 *  @param msg 提示信息
 */
- (void)execSql:(NSString *)sql msg:(NSString *)msg
{
    char *errmsg;
    // 所谓回调：sqlite3_exec执行完成sql之后调用的方法，叫做回调方法
    if (SQLITE_OK == sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errmsg)) {
        NSLog(@"%@成功", msg);
    } else {
        NSLog(@"%@失败 - %s", msg, errmsg);
    }
}

/**
 *  创建数据表
 */
- (void)createTable
{
    NSString *sql = @"CREATE TABLE IF NOT EXISTS t_person (id integer PRIMARY KEY AUTOINCREMENT,name text,age integer,phoneNo text)";
    
    [self execSql:sql msg:@"创建数据表"];
}

#pragma mark - 成员方法
// 新增个人记录
- (void)addPerson:(Person *)person
{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO t_person (name, age, phoneNo) VALUES ('%@', %ld, '%@')", person.name, (long)person.age, person.phoneNo];
    
    [self execSql:sql msg:@"添加个人记录"];
    
}

// 修改个人记录(修改传入Person对象ID对应的数据库记录的内容)
- (void)updatePerson:(Person *)person
{
    
}

// 删除个人记录
- (void)removePerson:(NSInteger)personID
{
    
}

/**
 *  返回指定sql查询语句运行的结果集
 *
 *  @param sql sql
 *
 *  @return 结果集
 */
- (NSArray *)queryPersonsWithSql:(NSString *)sql
{
    // 1. 评估准备SQL语法是否正确
    sqlite3_stmt *stmt = NULL;
    
    //    NSMutableArray *persons = [NSMutableArray array];
    NSMutableArray *persons = nil;
    
    if (SQLITE_OK == sqlite3_prepare_v2(_db, sql.UTF8String, -1, &stmt, NULL)) {
        // 2. 如果能够正常查询，调用单步执行方法，依次取得查询结果
        // 如果得到一行记录
        persons = [NSMutableArray array];
        
        while (SQLITE_ROW == sqlite3_step(stmt)) {
            // 3. 获取/显示查询结果
            // sqlite3_column_xxx方法的第二个参数与sql语句中的字段顺寻一一对应（从0开始）
            int ID = sqlite3_column_int(stmt, 0);
            const unsigned char *name = sqlite3_column_text(stmt, 1);
            int age = sqlite3_column_int(stmt, 2);
            const unsigned char *phoneNo = sqlite3_column_text(stmt, 3);
            
            NSString *nameUTF8 = [NSString stringWithUTF8String:(const char *)name];
            NSString *phoneNoUTF8 = [NSString stringWithUTF8String:(const char *)phoneNo];
            
            Person *p = [Person personWithID:ID name:nameUTF8 age:age phoneNo:phoneNoUTF8];
            [persons addObject:p];
        }
        
    } else {
        NSLog(@"SQL语法错误");
    }
    
    // 4. 释放句柄
    sqlite3_finalize(stmt);
    
    return persons;
}

// 查询所有用户信息列表
- (NSArray *)allPersons
{
    NSString *sql = @"SELECT id, name, age, phoneNo FROM t_person";
    
    return [self queryPersonsWithSql:sql];
}

- (NSArray *)personsWithName:(NSString *)name
{
    // 如果在NSString中包含%，可以使用%%表示
    NSString *sql = [NSString stringWithFormat:@"SELECT id, name, age, phoneNo FROM t_person WHERE name LIKE '%%%@%%'", name];
    
    return [self queryPersonsWithSql:sql];
}

@end
