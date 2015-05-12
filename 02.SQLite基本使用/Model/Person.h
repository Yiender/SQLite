//
//  Person.h
//  02.SQLite基本使用
//
//  Created by apple on 13-11-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

/**
 *  工厂方法
 *
 *  @param ID      ID
 *  @param name    姓名
 *  @param age     年龄
 *  @param phoneNo 电话
 *
 *  @return 个人信息对象
 */
+ (id)personWithID:(NSInteger)ID name:(NSString *)name age:(NSInteger)age phoneNo:(NSString *)phoneNo;

@property (assign, nonatomic) NSInteger ID;
@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger age;
@property (strong, nonatomic) NSString *phoneNo;

@end
