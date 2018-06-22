//
//  AddPWViewController.m
//  XMG
//
//  Created by jrweid on 2018/6/4.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import "AddPWViewController.h"

@interface AddPWViewController ()

@end

@implementation AddPWViewController

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
    
    
    
    UIBarButtonItem * left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:0 target:self action:@selector(giveUpToAddPW)];
    self.navigationItem.rightBarButtonItem = left;
    
    UIBarButtonItem * right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPassWordRecord)];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)addSubViews
{
    
}

- (void)queryData
{
    
}

- (void)addPassWordRecord
{
    
}

@end
