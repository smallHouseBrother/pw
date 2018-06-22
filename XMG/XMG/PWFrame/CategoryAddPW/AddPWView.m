//
//  AddPWView.m
//  XMG
//
//  Created by jrweid on 2018/6/22.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import "AddPWView.h"
#import "PassWordInfo.h"

@interface AddPWView () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView * _tableView;
    NSArray     * _dataArray;
}
@end

@implementation AddPWView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews
{
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = COLOR_HEX(@"#f5f5f5");
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 55;
    [self addSubview:_tableView];
    _tableView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)reloadAddPWTableWithArray:(NSArray *)dataArray withVC:(UIViewController *)rootVC
{
    /*_bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
    _bannerView.backgroundColor = COLOR_HEX(@"#f5f5f5");
    _bannerView.rootViewController = rootVC;
    _bannerView.adUnitID = textId;
    [self addSubview:_bannerView];
    [_bannerView loadRequest:[GADRequest request]];
    
    CGFloat bottom = 0; if (iPhoneX) bottom = 34;
    _bannerView.sd_layout.leftEqualToView(self).bottomSpaceToView(self, bottom).rightEqualToView(self).heightIs(50);*/
    
    _tableView.tableFooterView = [self getTableFooter];
    
    _dataArray = [dataArray copy];
    
    [_tableView reloadData];
}

- (UIView *)getTableFooter
{
    UIView * footer = [[UIView alloc] init];
    footer.height = 50;
    
    UIButton * button = [[UIButton alloc] init];
    button.backgroundColor = COLOR_HEX(@"#f4a85e");
    [button setTitle:@"添 加" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 5.0f;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(addPassWord:) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:button];
    button.sd_layout.leftSpaceToView(footer, 15).topSpaceToView(footer, 30).rightSpaceToView(footer, 15).heightIs(44);
    
    return footer;
}

- (void)addPassWord:(UIButton *)button
{
    RootInfo * info = [_dataArray firstObject];
    
    [self.delegate RootViewDidSelectInfo:info];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RootCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RootCell"];
    RootInfo * info = _dataArray[indexPath.row];
    [cell reloadRootCellWithInfo:info];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RootInfo * info = _dataArray[indexPath.row];
    
    [self.delegate RootViewDidSelectInfo:info];
}

@end
