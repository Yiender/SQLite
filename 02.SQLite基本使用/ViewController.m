//
//  ViewController.m
//  02.SQLite基本使用
//
//  Created by apple on 13-11-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "PersonManager.h"

@interface ViewController () <UITableViewDataSource, UISearchBarDelegate>
{
    NSArray *_personList;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController
/**
 在应用程序第一次运行，由于沙盒中没有数据库，所以需要创建一个空的数据库
 
 创建数据库之后，为了保证能够正常运行，通常需要做一些初始化工作，其中最重要的一项工作就是创建数据表
 
 而下次再使用时，就无需再创建创建数据表了。
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
   //    // 3. 数据操作
//    NSArray *array = @[@"张三", @"李四", @"王五", @"张老头"];
//    
    // 提示：数据不是批量生成的，而是一条一条依次添加到数据库中的
//    for (NSInteger i = 0; i < 50; i++) {
//        NSString *str = array[arc4random_uniform(4)];
//        NSString *name = [NSString stringWithFormat:@"%@%d", str, arc4random_uniform(1000)];
//        NSString *phoneNo = [NSString stringWithFormat:@"1390%05d", arc4random_uniform(100000)];
//
//        Person *p = [Person personWithID:i + 1 name:name age:18 + arc4random_uniform(20) phoneNo:phoneNo];
//        [[PersonManager sharedPersonManager] addPerson:p];
//    }
    // 4. 查询所有个人信息
    _personList = [[PersonManager sharedPersonManager] allPersons];
}

#pragma mark - 表格数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _personList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"Cell";
    
    // 在iOS 6中，如果使用registercell，系统会在runtime自动注册可重用单元格
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    // 设置单元格内容
    Person *p = _personList[indexPath.row];
    
    cell.textLabel.text = p.name;
    cell.detailTextLabel.text = p.phoneNo;
    
    return cell;
}

#pragma mark - 搜索栏代理方法
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    _personList = [[PersonManager sharedPersonManager] personsWithName:searchText];
    [_tableView reloadData];
}

@end
