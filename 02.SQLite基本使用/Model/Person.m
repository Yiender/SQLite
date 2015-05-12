//
//  Person.m
//  02.SQLite基本使用
//
//  Created by apple on 13-11-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (id)personWithID:(NSInteger)ID name:(NSString *)name age:(NSInteger)age phoneNo:(NSString *)phoneNo
{
    Person *p = [[Person alloc] init];
    
    p.ID = ID;
    p.name = name;
    p.age = age;
    p.phoneNo = phoneNo;
    
    return p;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<Person: %p, ID: %d, name: %@, age: %d, phoneNo: %@>", self, _ID, _name, _age, _phoneNo];
}

@end
