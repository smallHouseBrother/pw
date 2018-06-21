//
//  FMDBTool.m
//  XMG
//
//  Created by jrweid on 2018/6/21.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import "XMGFMDBTool.h"
#import <FMDB.h>

@implementation XMGFMDBTool

/连接数据库
- (void)connectionDB{
    
    //创建数据库路径
    NSString *path  = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"data.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    self.db = db;
    BOOL success = [db open];
    if (success) { //打开成功
        NSLog(@"数据库创建成功!");
        //创建表  执行一条sql语句  增删改 都是这样的  查询比较特殊
        NSString *sqlStr = @"CREATE TABLE IF NOT EXISTS t_test (ID INTEGER PRIMARY KEY AUTOINCREMENT ,NAME TEXT ,AGE INTEGER );";
        BOOL successT = [self.db executeUpdate:sqlStr];
        
        if (successT) {
            NSLog(@"创建表成功!");
        }else{
            NSLog(@"创建表失败!");
        }
        
        
    }else{
        NSLog(@"数据库创建失败!");
    }
    
    NSLog(@"%@",NSHomeDirectory());
    
    //关闭数据库
    //sqlite3_close(_db);
}

//增加数据
- (IBAction)addClick:(id)sender {
    
    //往表中循环插入100条数据
    for (int i = 0; i < 100 ; i++) {
        //名称设置为J_mailbox
        NSString *name = [NSString stringWithFormat:@"J_mailbox-%d",i];
        //随机生成20岁~25岁之间的记录
        NSInteger age = arc4random_uniform(5) + 20;
        
        //sql插入语句的拼接
        NSString *resultStr = [NSString stringWithFormat:@"INSERT INTO t_test (NAME,AGE) VALUES('%@',%zd) ",name,age];
        
        //执行sql插入语句(调用FMDB对象方法)
        BOOL success = [self.db executeUpdate:resultStr];
        //判断是否添加成功
        if (success) {
            NSLog(@"添加数据成功!");
        }else{
            NSLog(@"添加数据失败!");
        }
        
    }
    
    
}

//删除数据
- (IBAction)deleteClick:(id)sender {
    
    //删除语句
    NSString *sqlStr = @"DELETE FROM t_test WHERE AGE > 22 ;";
    //执行sql删除语句(调用FMDB对象方法)
    BOOL success = [self.db executeUpdate:sqlStr];
    
    if (success) {
        NSLog(@"删除数据成功!");
    }else{
        NSLog(@"删除数据失败!");
    }
}

//修改数据
- (IBAction)updateClick:(id)sender {
    
    //修改语句
    NSString *sqlStr = @"UPDATE t_test SET AGE = 30 WHERE AGE <25;";
    //执行sql修改语句(调用FMDB对象方法)
    BOOL success = [self.db executeUpdate:sqlStr];
    
    if (success) {
        NSLog(@"修改数据成功!");
    }else{
        NSLog(@"修改数据失败!");
    }
    
}

//查询数据
- (IBAction)selectClick:(id)sender {
    
    //查询语句
    NSString *sqlStr = @"SELECT NAME,AGE FROM t_test WHERE AGE = 30;";
    
    //执行sql查询语句(调用FMDB对象方法)
    FMResultSet *set =  [self.db executeQuery:sqlStr];
    
    while ([set next]) { //等价于 == sqlite_Row
        //NAME
        NSString *name = [set stringForColumnIndex:0];
        //AGE
        NSInteger age = [set intForColumnIndex:1];
        
        NSLog(@"NAME = %@ AGE = %ld",name,(long)age);
    }
    
}

@end
