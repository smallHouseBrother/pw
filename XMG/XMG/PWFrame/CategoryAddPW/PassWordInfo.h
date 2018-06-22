//
//  PassWordInfo.h
//  XMG
//
//  Created by jrweid on 2018/6/21.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PassWordInfo : NSObject

@property (nonatomic) NSInteger typeId;

@property (nonatomic) NSInteger pwId;

@property (nonatomic, copy) NSString * titleName;

@property (nonatomic, copy) NSString * account;

@property (nonatomic, copy) NSString * passWord;

@property (nonatomic, copy) NSString * beiZhu;

@property (nonatomic) NSData * imageData;

@end
