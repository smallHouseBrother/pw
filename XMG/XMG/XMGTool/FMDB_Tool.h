//
//  FMDB_Tool.h
//  DDB_project
//
//  Created by 马红杰 on 2017/1/22.
//  Copyright © 2017年 GOLDDRAGON. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabase, PassWordInfo;

@interface FMDB_Tool : NSObject

+ (BOOL)writeToDataBaseWithInfo:(PassWordInfo *)info;

//查询所有数据
+ (NSArray <PassWordInfo *> *)downAllDataFromDataBase;

//删除掉某条数据
+ (BOOL)deleteSomeOneProductWithProduct:(PassWordInfo *)info;

//更新某条数据
+ (BOOL)updateSomeOneProductWithProduct:(PassWordInfo *)info withNumber:(int)number;

//查询单品总数量
+ (int)checkAllTheTableProductNumberWithDataBase;

//查询某单品数量
+ (int)checkSomeOneProductCountWithInfo:(PassWordInfo *)info;

//检查是否有此条数据
+ (BOOL)checkIsThereSomeOneProductWithProduct:(PassWordInfo *)info;

@end
