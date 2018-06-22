//
//  CategoryListViewController.m
//  XMG
//
//  Created by jrweid on 2018/6/22.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import "CategoryListViewController.h"
#import "CategoryListViewView.h"
#import "AddPWViewController.h"
#import "RootInfo.h"

@interface CategoryListViewController () <CategoryListViewViewDelegate>

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
    CategoryListViewView * selfView = [[CategoryListViewView alloc] init];
    selfView.delegate = self;
    self.view = selfView;
}

- (void)queryData
{
    
}

- (void)addPassWordRecord
{
    AddPWViewController * addPW = [[AddPWViewController alloc] init];
    [self.navigationController presentViewController:addPW animated:YES completion:nil];
}

@end
