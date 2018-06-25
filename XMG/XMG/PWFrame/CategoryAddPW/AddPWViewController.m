//
//  AddPWViewController.m
//  XMG
//
//  Created by jrweid on 2018/6/4.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import "AddPWViewController.h"
#import "AddPWView.h"

@interface AddPWViewController () <AddPWViewDelegate>

@end

@implementation AddPWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavigation];
    
    [self addSubViews];
}

- (void)setNavigation
{
    self.title = @"新增";
    
    UIBarButtonItem * left = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:0 target:self action:@selector(giveUpToAddPW)];
    self.navigationItem.leftBarButtonItem = left;
    
    UIBarButtonItem * right = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:0 target:self action:@selector(saveCurrentContent)];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)addSubViews
{
    AddPWView * selfView = [[AddPWView alloc] initWithVC:self];
    selfView.aDelegate = self;
    self.view = selfView;
}

- (void)giveUpToAddPW
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveCurrentContent
{
    
}

@end
