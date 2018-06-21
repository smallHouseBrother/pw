//
//  FMDB_Tool.m
//  DDB_project
//
//  Created by 马红杰 on 2017/1/22.
//  Copyright © 2017年 GOLDDRAGON. All rights reserved.
//

#import "FMDB_Tool.h"
#import <FMDB.h>
#import "sqlite3.h"
#import "PassWordInfo.h"

@implementation FMDB_Tool

//1.executeUpdate:不确定的参数用？来占位（后面参数必须是oc对象，；代表语句结束）
//2.executeUpdateWithForamat：不确定的参数用%@，%d等来占位 （参数为原始数据类型，执行语句不区分大小写）
//    [db executeUpdateWithFormat:@"insert into t_product (name,number) values (%@,%@);", info.singleName, info.number];
//3.参数是数组的使用方式
//    [db executeUpdate:@"insert into t_product(name,number) values(?,?);" withArgumentsInArray:@[info.singleName, info.number]];

+ (BOOL)writeToDataBaseWithInfo:(PassWordInfo *)info
{       
    NSString * doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * fileName = [doc stringByAppendingPathComponent:@"fmd.sqlite"];
    FMDatabase * dataBase = [FMDatabase databaseWithPath:fileName];
    if (![dataBase open])
    {
        NSLog(@"open error, message: %@", dataBase.lastErrorMessage);
        return NO;
    }
    BOOL create = [dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS t_product(ID INTEGER PRIMARY KEY AUTOINCREMENT, SINGLEID INT, NAME TEXT, COUNT INT, FEE TEXT, IMAGE TEXT, PROPERTY TEXT, WAGE TEXT)"];
    if (!create)
    {
        [dataBase close];
        NSLog(@"create error, message: %@", dataBase.lastErrorMessage);
        return NO;
    }
    
    BOOL insert = [dataBase executeUpdate:@"INSERT INTO t_product(SINGLEID, NAME, COUNT, FEE, IMAGE, PROPERTY, WAGE) VALUES (?,?,?,?,?,?,?);", @(info.singleID), info.singleName, @(info.number), info.fee, info.imageURL, info.property, info.wage];
    if (!insert)
    {
        [dataBase close];
        NSLog(@"insert error, message: %@", dataBase.lastErrorMessage);
        return NO;
    }
    [dataBase close];
    NSLog(@"insert success");
    return YES;
}

//查询所有数据
+ (NSArray <PassWordInfo *> *)downAllDataFromDataBase
{
    NSString * doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * fileName = [doc stringByAppendingPathComponent:@"fmd.sqlite"];
    FMDatabase * dataBase = [FMDatabase databaseWithPath:fileName];
    if (![dataBase open])
    {
        NSLog(@"open error, message: %@", dataBase.lastErrorMessage);
        return nil;
    }
    BOOL create = [dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS t_product(ID INTEGER PRIMARY KEY AUTOINCREMENT, SINGLEID INT, NAME TEXT, COUNT INT, FEE TEXT, IMAGE TEXT, PROPERTY TEXT, WAGE TEXT)"];
    if (!create)
    {
        [dataBase close];
        NSLog(@"create error, message: %@", dataBase.lastErrorMessage);
        return nil;
    }
    
    NSMutableArray * backArray = [NSMutableArray array];    
    FMResultSet * resultSet = [dataBase executeQuery:@"SELECT * FROM t_product"];

    while ([resultSet next])
    {
//        SINGLEID, NAME, COUNT, FEE, IMAGE, PROPERTY, WAGE
        productInfo * info = [[productInfo alloc] init];
        info.singleID = [resultSet intForColumnIndex:1];
        info.singleName = [resultSet objectForColumnIndex:2];
        info.number = [resultSet intForColumnIndex:3];
        info.fee = [resultSet objectForColumnIndex:4];
        info.imageURL = [resultSet objectForColumnIndex:5];
        info.property = [resultSet objectForColumnIndex:6];
        info.wage = [resultSet objectForColumnIndex:7];
        [backArray addObject:info];
    }
    [dataBase close];
    NSLog(@"examine success");
    return backArray;
}

//删除掉某条数据
+ (BOOL)deleteSomeOneProductWithProduct:(PassWordInfo *)info
{
    NSString * doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * fileName = [doc stringByAppendingPathComponent:@"fmd.sqlite"];
    FMDatabase * dataBase = [FMDatabase databaseWithPath:fileName];
    if (![dataBase open])
    {
        NSLog(@"open error, message: %@", dataBase.lastErrorMessage);
        return NO;
    }
    BOOL create = [dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS t_product(ID INTEGER PRIMARY KEY AUTOINCREMENT, SINGLEID INT, NAME TEXT, COUNT INT, FEE TEXT, IMAGE TEXT, PROPERTY TEXT, WAGE TEXT)"];
    if (!create)
    {
        [dataBase close];
        NSLog(@"create error, message: %@", dataBase.lastErrorMessage);
        return NO;
    }
    
    BOOL delete = [dataBase executeUpdate:@"DELETE FROM t_product WHERE SINGLEID = ? AND PROPERTY = ? AND WAGE = ?;", @(info.singleID), info.property, info.wage];
    if (!delete)
    {
        NSLog(@"delete error :%@", dataBase.lastErrorMessage);
    }
    [dataBase close];
    return delete;
}

//更新某条数据
+ (BOOL)updateSomeOneProductWithProduct:(PassWordInfo *)info withNumber:(int)number
{
    NSString * doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * fileName = [doc stringByAppendingPathComponent:@"fmd.sqlite"];
    FMDatabase * dataBase = [FMDatabase databaseWithPath:fileName];
    if (![dataBase open])
    {
        NSLog(@"open error, message: %@", dataBase.lastErrorMessage);
        return NO;
    }
    BOOL create = [dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS t_product(ID INTEGER PRIMARY KEY AUTOINCREMENT, SINGLEID INT, NAME TEXT, COUNT INT, FEE TEXT, IMAGE TEXT, PROPERTY TEXT, WAGE TEXT)"];
    if (!create)
    {
        [dataBase close];
        NSLog(@"create error, message: %@", dataBase.lastErrorMessage);
        return NO;
    }
    
    BOOL update = [dataBase executeUpdate:@"UPDATE t_product SET COUNT = ? WHERE SINGLEID = ? AND PROPERTY = ? AND WAGE = ?;", @(info.number+number), @(info.singleID), info.property, info.wage];
    if (!update)
    {
        NSLog(@"update error :%@", dataBase.lastErrorMessage);
    }
    [dataBase close];
    return update;
}

//查询单品总数量
+ (int)checkAllTheTableProductNumberWithDataBase
{
    NSString * doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * fileName = [doc stringByAppendingPathComponent:@"fmd.sqlite"];
    FMDatabase * dataBase = [FMDatabase databaseWithPath:fileName];
    if (![dataBase open])
    {
        NSLog(@"open error, message: %@", dataBase.lastErrorMessage);
        return 0;
    }
    BOOL create = [dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS t_product(ID INTEGER PRIMARY KEY AUTOINCREMENT, SINGLEID INT, NAME TEXT, COUNT INT, FEE TEXT, IMAGE TEXT, PROPERTY TEXT, WAGE TEXT)"];
    if (!create)
    {
        [dataBase close];
        NSLog(@"create error, message: %@", dataBase.lastErrorMessage);
        return 0;
    }

    int number = 0;    
    FMResultSet * resultSet = [dataBase executeQuery:@"SELECT * FROM t_product"];
    
    while ([resultSet next])
    {
        number += [resultSet intForColumnIndex:3];
    }
    [dataBase close];
    NSLog(@"examine success");
    return number;
}

//查询某单品数量
+ (int)checkSomeOneProductCountWithInfo:(productInfo *)info
{
    NSString * doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * fileName = [doc stringByAppendingPathComponent:@"fmd.sqlite"];
    FMDatabase * dataBase = [FMDatabase databaseWithPath:fileName];
    if (![dataBase open])
    {
        NSLog(@"open error, message: %@", dataBase.lastErrorMessage);
        return 0;
    }
    BOOL create = [dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS t_product(ID INTEGER PRIMARY KEY AUTOINCREMENT, SINGLEID INT, NAME TEXT, COUNT INT, FEE TEXT, IMAGE TEXT, PROPERTY TEXT, WAGE TEXT)"];
    if (!create)
    {
        [dataBase close];
        NSLog(@"create error, message: %@", dataBase.lastErrorMessage);
        return 0;
    }
    
    int number = 0;    
    FMResultSet * resultSet = [dataBase executeQuery:@"SELECT * FROM t_product WHERE SINGLEID = ? AND PROPERTY = ? AND WAGE = ?;", @(info.singleID), info.property, info.wage];
    while ([resultSet next])
    {
        number = [resultSet intForColumnIndex:3];
    }
    [dataBase close];
    NSLog(@"examine success");
    return number;
}

//检查是否有此条数据
+ (BOOL)checkIsThereSomeOneProductWithProduct:(productInfo *)info
{
    NSString * doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * fileName = [doc stringByAppendingPathComponent:@"fmd.sqlite"];
    FMDatabase * dataBase = [FMDatabase databaseWithPath:fileName];
    if (![dataBase open])
    {
        NSLog(@"open error, message: %@", dataBase.lastErrorMessage);
        return NO;
    }
    BOOL create = [dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS t_product(ID INTEGER PRIMARY KEY AUTOINCREMENT, SINGLEID INT, NAME TEXT, COUNT INT, FEE TEXT, IMAGE TEXT, PROPERTY TEXT, WAGE TEXT)"];
    if (!create)
    {
        [dataBase close];
        NSLog(@"create error, message: %@", dataBase.lastErrorMessage);
        return NO;
    }
    
    BOOL isHave = NO;
    FMResultSet * resultSet = [dataBase executeQuery:@"SELECT * FROM t_product WHERE SINGLEID = ? AND PROPERTY = ? AND WAGE = ?;", @(info.singleID), info.property, info.wage];
    while ([resultSet next])
    {
        isHave = YES;
    }
    [dataBase close];
    return isHave;
}


/*- (void)withDataBase:(FMDatabase *)db
{
    [db executeQuery:@"SELECT * FROM t_home_status WHERE access_token = ? AND status_idstr <= ? ORDER BY status_idstr, SINGLEID DESC limit ?;"];
    ////DESC降序 ASC升序 基于一个或多个列按升序或降序顺序
}



- (void)query
{
    //销毁命令SQLdrop ...//如果表格存在 则销毁
    [db executeUpdate:@"drop table if exists t_product"];
    
    
  
 //创建队列
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:fileName];
    [queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"INSERT INTO t_student(name) VALUES (?)", @"Jack"];
        // 查询
        FMResultSet *rs = [db executeQuery:@"select * from t_student"];
    }];
 
 
 ////想象一个场景，比如你要更新数据库的大量数据，我们需要确保所有的数据更新成功，才采取这种更新方案，如果在更新期间出现错误，就不能采取这种更新方案了，如果我们不使用事务，我们的更新操作直接对每个记录生效，万一遇到更新错误，已经更新的数据怎么办？难道我们要一个一个去找出来修改回来吗？怎么知道原来的数据是怎么样的呢？这个时候就需要使用事务实现。
    __block BOOL whoopsSomethingWrongHappend = true;
    //把任务包装到事务里
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        whoopsSomethingWrongHappend &= [db executeUpdate:@"INSERT INTO t_product VALUES (?)", [NSNumber numberWithInt:1]]; 
        whoopsSomethingWrongHappend &= [db executeUpdate:@"INSERT INTO t_product VALUES (?)", [NSNumber numberWithInt:2]];
        whoopsSomethingWrongHappend &= [db executeUpdate:@"INSERT INTO t_product VALUES (?)", [NSNumber numberWithInt:3]];
        
        //如果有错误，返回
        if (!whoopsSomethingWrongHappend)
        {
            *rollback = YES;    //当最后*rollback的值为YES的时候，事务回退，如果最后*rollback为NO，事务提交
            return;
        }
    }];
}

- (void)beginTransactionWithDataBase:(FMDatabase *)
{
    // 开启事务
    [self.database beginTransaction]; 
    BOOL isRollBack = NO; 
    @try { 
        for (int i = 0; i<500; i++) { 
            NSNumber *num = @(i+1); 
            NSString *name = [[NSString alloc] initWithFormat:@"student_%d",i]; 
            NSString *sex = (i%2==0)?@"f":@"m";
            NSString *sql = @"insert into mytable(num,name,sex) values(?,?,?);"; 
            BOOL result = [database executeUpdate:sql,num,name,sex]; 
            if ( !result )
            { 
                NSLog(@"插入失败！");
                return; 
            } 
        } 
    } 
    @catch (NSException *exception) { 
        isRollBack = YES; 
        // 事务回退
        [self.database rollback]; 
    } 
    @finally { 
        if (!isRollBack) { 
            //事务提交
            [self.database commit]; 
        } 
    } 
}*/



@end
