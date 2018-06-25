//
//  CategoryListViewController.m
//  XMG
//
//  Created by jrweid on 2018/6/22.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import "CategoryListViewController.h"
#import "CategoryListView.h"
#import "AddPWViewController.h"
#import "RootInfo.h"

@interface CategoryListViewController () <CategoryListViewDelegate>

@end

@implementation CategoryListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavigation];
    
    [self addSubViews];
    
    [self queryData];
}

- (void)setNavigation
{
    [self setBackItem];
    
    self.title = self.info.titleString;
    
    UIBarButtonItem * right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPassWordRecord)];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)addSubViews
{
    CategoryListView * selfView = [[CategoryListView alloc] init];
    selfView.delegate = self;
    self.view = selfView;
}

- (void)queryData
{
    NSArray * dataArray = [FMDB_Tool querySingleTypeAllDataFromDataBaseWithType:self.info.typeId];
    [(CategoryListView *)self.view reloadCategoryListTableWithArray:dataArray withVC:self];
}

- (void)addPassWordRecord
{
    AddPWViewController * addPW = [[AddPWViewController alloc] init];
    XGNavigationController * addPwNavi = [[XGNavigationController alloc] initWithRootViewController:addPW];
    [self.navigationController presentViewController:addPwNavi animated:YES completion:nil];
}

@end
