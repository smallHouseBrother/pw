//
//  RootViewController.m
//  XMG
//
//  Created by Zhao Chen on 2018/1/26.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import "RootViewController.h"
#import "RootView.h"
#import "RootCell.h"
#import "RootInfo.h"

@interface RootViewController () <RootViewDelegate>

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavigation];
    
    [self addSubViews];
    
    [self requestData];
}

- (void)setNavigation
{
    self.title = @"密码管理";
    
    UIBarButtonItem * more = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"more"] style:0 target:self action:@selector(showMoreBarButtonItem)];
    self.navigationItem.leftBarButtonItem = more;
    
    UIBarButtonItem * search = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchFromFMDB)];
    self.navigationItem.rightBarButtonItem = search;
}

- (void)addSubViews
{
    RootView * selfView = [[RootView alloc] init];
    selfView.delegate = self;
    self.view = selfView;
}

- (void)requestData
{
    NSArray * titleArray = @[@"网站管理", @"邮件", @"游戏", @"社交", @"银行账户", @"其他"];
    NSMutableArray * dataArray = [NSMutableArray arrayWithCapacity:titleArray.count];
    for (NSInteger i = 0; i < titleArray.count; i++) {
        RootInfo * info = [[RootInfo alloc] init];
        info.titleString = titleArray[i];
        info.imageName = [NSString stringWithFormat:@"password%@", @(i)];
        info.detailString = info.titleString;
        info.accountNum = @"1";
        [dataArray addObject:info];
    }
    [(RootView *)self.view reloadRootTableWithArray:dataArray withVC:self];
}

- (void)showMoreBarButtonItem
{
    
}

- (void)searchFromFMDB
{
    
}

@end
