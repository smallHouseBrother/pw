//
//  FMDB_Tool.m
//  DDB_project
//
//  Created by 马红杰 on 2017/1/22.
//  Copyright © 2017年 GOLDDRAGON. All rights reserved.
//

#import "FMDB_Tool.h"
#import <FMDB.h>
#import "PassWordInfo.h"

@implementation FMDB_Tool

//1.executeUpdate:不确定的参数用？来占位（后面参数必须是oc对象，；代表语句结束）
//2.executeUpdateWithForamat：不确定的参数用%@，%d等来占位 （参数为原始数据类型，执行语句不区分大小写）
//    [db executeUpdateWithFormat:@"insert into PW_TABLE (name,number) values (%@,%@);", info.singleName, info.number];
//3.参数是数组的使用方式
//    [db executeUpdate:@"insert into PW_TABLE(name,number) values(?,?);" withArgumentsInArray:@[info.singleName, info.number]];

///数据库文件
+ (FMDatabase *)getFMDatabase
{
    NSString * doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * fileName = [doc stringByAppendingPathComponent:@"fmdb.sqlite"];
    return [FMDatabase databaseWithPath:fileName];
}

///插入单条数据
+ (BOOL)insertSingleDataToDataBaseWithInfo:(PassWordInfo *)info
{
    FMDatabase * dataBase = [self getFMDatabase];
    if (![dataBase open])
    {
        XMGLog(@"open error, message: %@", dataBase.lastErrorMessage);
        return NO;
    }
    BOOL create = [dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS PW_TABLE(ID INTEGER PRIMARY KEY AUTOINCREMENT, TYPEID INT, PWID INT, TITLE TEXT, ACCOUNT TEXT, PASSWORD TEXT, BEIZHU TEXT, IMAGE DATA)"];
    
    if (!create)
    {
        [dataBase close];
        XMGLog(@"create error, message: %@", dataBase.lastErrorMessage);
        return NO;
    }
    
    BOOL insert = [dataBase executeUpdate:@"INSERT INTO PW_TABLE(TYPEID, PWID, TITLE, ACCOUNT, PASSWORD, BEIZHU, IMAGE) VALUES (?,?,?,?,?,?,?);", @(info.typeId), @(info.pwId), info.titleName, info.account, info.passWord, info.beiZhu, info.imageData];
    
    if (!insert)
    {
        XMGLog(@"insert error, message: %@", dataBase.lastErrorMessage);
    }
    [dataBase close];
    return insert;
}

///查询单类型所有数据
+ (NSArray <PassWordInfo *> *)querySingleTypeAllDataFromDataBaseWithType:(NSInteger)typeId
{
    FMDatabase * dataBase = [self getFMDatabase];
    if (![dataBase open])
    {
        XMGLog(@"open error, message: %@", dataBase.lastErrorMessage);
        return nil;
    }
    BOOL create = [dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS PW_TABLE(ID INTEGER PRIMARY KEY AUTOINCREMENT, TYPEID INT, PWID INT, TITLE TEXT, ACCOUNT TEXT, PASSWORD TEXT, BEIZHU TEXT, IMAGE DATA)"];
    if (!create)
    {
        [dataBase close];
        XMGLog(@"create error, message: %@", dataBase.lastErrorMessage);
        return nil;
    }
    
    NSMutableArray * backArray = [NSMutableArray array];
    FMResultSet * resultSet = [dataBase executeQuery:@"SELECT * FROM PW_TABLE WHERE TYPEID = ?;", @(typeId)];
    while ([resultSet next])
    {
        PassWordInfo * info = [[PassWordInfo alloc] init];
        info.typeId = [resultSet intForColumnIndex:1];
        info.pwId = [resultSet intForColumnIndex:2];
        info.titleName = [resultSet objectForColumnIndex:3];
        info.account = [resultSet objectForColumnIndex:4];
        info.passWord = [resultSet objectForColumnIndex:5];
        info.beiZhu = [resultSet objectForColumnIndex:6];
        info.imageData = [resultSet dataForColumnIndex:7];
        [backArray addObject:info];
    }
    [dataBase close];
    XMGLog(@"query success");
    return backArray;
}

///删除掉某条数据
+ (BOOL)deleteSingleDataWithPassWordInfo:(PassWordInfo *)info
{
    FMDatabase * dataBase = [self getFMDatabase];
    if (![dataBase open])
    {
        XMGLog(@"open error, message: %@", dataBase.lastErrorMessage);
        return NO;
    }
    BOOL create = [dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS PW_TABLE(ID INTEGER PRIMARY KEY AUTOINCREMENT, TYPEID INT, PWID INT, TITLE TEXT, ACCOUNT TEXT, PASSWORD TEXT, BEIZHU TEXT, IMAGE DATA)"];
    if (!create)
    {
        [dataBase close];
        XMGLog(@"create error, message: %@", dataBase.lastErrorMessage);
        return NO;
    }
    
    BOOL delete = [dataBase executeUpdate:@"DELETE FROM PW_TABLE WHERE PWID = ?;", @(info.pwId)];
    if (!delete)
    {
        XMGLog(@"delete error :%@", dataBase.lastErrorMessage);
    }
    [dataBase close];
    return delete;
}

///更新某条数据
+ (BOOL)updateSingleDataWithPassWordInfo:(PassWordInfo *)info
{
    FMDatabase * dataBase = [self getFMDatabase];
    if (![dataBase open])
    {
        XMGLog(@"open error, message: %@", dataBase.lastErrorMessage);
        return NO;
    }
    BOOL create = [dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS PW_TABLE(ID INTEGER PRIMARY KEY AUTOINCREMENT, TYPEID INT, PWID INT, TITLE TEXT, ACCOUNT TEXT, PASSWORD TEXT, BEIZHU TEXT, IMAGE DATA)"];
    if (!create)
    {
        [dataBase close];
        XMGLog(@"create error, message: %@", dataBase.lastErrorMessage);
        return NO;
    }

    BOOL update = [dataBase executeUpdate:@"UPDATE PW_TABLE SET TITLE = ?, ACCOUNT = ?, PASSWORD = ?, BEIZHU = ?, IMAGE = ? WHERE TYPEID = ? AND PWID = ?;", info.titleName, info.account, info.passWord, info.beiZhu, info.imageData, @(info.typeId), @(info.pwId)];
    if (!update)
    {
        XMGLog(@"update error :%@", dataBase.lastErrorMessage);
    }
    [dataBase close];
    return update;
}

///查询单类型总数量
+ (NSInteger)querySingleTypeNumFromDataBaseWithType:(NSInteger)typeId
{
    FMDatabase * dataBase = [self getFMDatabase];
    if (![dataBase open])
    {
        XMGLog(@"open error, message: %@", dataBase.lastErrorMessage);
        return 0;
    }
    BOOL create = [dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS PW_TABLE(ID INTEGER PRIMARY KEY AUTOINCREMENT, TYPEID INT, PWID INT, TITLE TEXT, ACCOUNT TEXT, PASSWORD TEXT, BEIZHU TEXT, IMAGE DATA)"];
    if (!create)
    {
        [dataBase close];
        XMGLog(@"create error, message: %@", dataBase.lastErrorMessage);
        return 0;
    }
    
    NSInteger number = 0;
    FMResultSet * resultSet = [dataBase executeQuery:@"SELECT * FROM PW_TABLE WHERE TYPEID = ?;", @(typeId)];
    while ([resultSet next]) {
        number++;
    }
    
    [dataBase close];
    return number;
}









/*- (void)withDataBase:(FMDatabase *)db
{
    [db executeQuery:@"SELECT * FROM t_home_status WHERE access_token = ? AND status_idstr <= ? ORDER BY status_idstr, SINGLEID DESC limit ?;"];
    ////DESC降序 ASC升序 基于一个或多个列按升序或降序顺序
}



- (void)query
{
    //销毁命令SQLdrop ...//如果表格存在 则销毁
    [db executeUpdate:@"drop table if exists PW_TABLE"];
    
    
  
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
        whoopsSomethingWrongHappend &= [db executeUpdate:@"INSERT INTO PW_TABLE VALUES (?)", [NSNumber numberWithInt:1]];
        whoopsSomethingWrongHappend &= [db executeUpdate:@"INSERT INTO PW_TABLE VALUES (?)", [NSNumber numberWithInt:2]];
        whoopsSomethingWrongHappend &= [db executeUpdate:@"INSERT INTO PW_TABLE VALUES (?)", [NSNumber numberWithInt:3]];
        
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
                XMGLog(@"插入失败！");
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
