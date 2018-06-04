//
//  RootInfo.h
//  XMG
//
//  Created by 马红杰 on 2018/5/31.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RootInfo : NSObject

///类型
@property (nonatomic, copy) NSString * titleString;

///最后一条编辑的内容
@property (nonatomic, copy) NSString * detailString;

///icon名
@property (nonatomic, copy) NSString * imageName;

///账户数量
@property (nonatomic, copy) NSString * accountNum;

@end