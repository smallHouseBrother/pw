//
//  AddPWViewController.m
//  XMG
//
//  Created by jrweid on 2018/6/4.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import "AddPWViewController.h"
#import "AddPWView.h"
#import "AddPWInfo.h"
#import "PassWordInfo.h"
#import <objc/runtime.h>
#import "XMGWebViewController.h"

static char Web_Jump_Key;

@interface AddPWViewController () <AddPWViewDelegate, XMGActionSheetDelegate>
{
    NSDateFormatter * _formatter;
    NSArray         * _dataArray;
}
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
    self.title = self.info.titleName ?: @"新增";
    
    if (self.info)
    {
        [self setBackItem];
        
        UIBarButtonItem * right = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:0 target:self action:@selector(editCurrentContent)];
        self.navigationItem.rightBarButtonItem = right;
    }
    else
    {
        UIBarButtonItem * left = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:0 target:self action:@selector(giveUpToAddPW)];
        self.navigationItem.leftBarButtonItem = left;
        
        UIBarButtonItem * right = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:0 target:self action:@selector(saveCurrentContent)];
        self.navigationItem.rightBarButtonItem = right;
    }
}

- (void)addSubViews
{
    AddPWView * selfView = [[AddPWView alloc] init];
    selfView.delegate = self;
    self.view = selfView;
    
    NSArray * titleArray = @[@[@"标题：", @"网址：", @"账户：", @"密码："], @[@"备注："]];
    NSArray * inputArray = nil;
    if (self.info) {
        inputArray = @[@[self.info.titleName, self.info.webSite, self.info.account, self.info.passWord], @[self.info.beiZhu]];
    }
    NSMutableArray * dataArray = [NSMutableArray array];
    for (NSInteger i = 0; i < titleArray.count; i++) {
        NSArray * section = titleArray[i];
        NSMutableArray * sectionArray = [NSMutableArray array];
        for (NSInteger j = 0; j < section.count; j++) {
            AddPWInfo * info = [[AddPWInfo alloc] init];
            info.editTime = self.info.createTime;
            info.leftTitle = section[j];
            info.titlePlace = [NSString stringWithFormat:@"%@信息～", [info.leftTitle substringToIndex:2]];
            info.titleInput = inputArray ? inputArray[i][j] : nil;
            [sectionArray addObject:info];
        }
        [dataArray addObject:sectionArray];
    }
    [selfView reloadAddPWCellWithArray:_dataArray = dataArray withVC:self];
}

- (void)giveUpToAddPW
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

///编辑
- (void)editCurrentContent
{
    
}

///保存
- (void)saveCurrentContent
{
    [self.view endEditing:YES];
    NSMutableArray * backArray = [NSMutableArray array];
    for (NSInteger i = 0; i < _dataArray.count; i++) {
        NSArray * section = _dataArray[i];
        for (NSInteger j = 0; j < section.count; j++) {
            AddPWInfo * addInfo = section[j];
            if (i == 0 && addInfo.titleInput.length == 0) {
                NSString * string = [NSString stringWithFormat:@"%@不能为空～", [addInfo.titlePlace substringToIndex:addInfo.titlePlace.length-1]];
                [UIAlertView showAlertMessage:string andDelay:2.0f];
                return;
            }
            [backArray addObject:addInfo.titleInput ?: @""];
        }
    }
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"yyyy年MM月dd HH:mm:ss"];
    _formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    NSString * nowTime = [_formatter stringFromDate:[NSDate date]];
    
    PassWordInfo * info = [[PassWordInfo alloc] init];
    info.titleName = [backArray firstObject];
    info.webSite = backArray[1];
    info.account = backArray[2];
    info.passWord = backArray[3];
    info.beiZhu = [backArray lastObject];
    info.createTime = nowTime;
    info.typeId = self.info.typeId;
    info.pwId = nowTimestamp;
    info.isEdit = YES;
    
    
    
    if ([FMDB_Tool insertSingleDataToDataBaseWithInfo:info]) {
        NSLog(@"插入成功");
    } else
    {
        NSLog(@"插入失败");
    }
}

#pragma mark - AddPWViewDelegate 选择图片
- (void)AddPWViewSelectPhoto
{
    
}

- (void)AddPWViewWebJumpWithWebString:(NSString *)webString
{
    XMGActionSheet * sheet = [[XMGActionSheet alloc] initWithDelegate:self cancelTitle:@"取消" otherTitles:@[@"Safari", @"内置浏览器"]];
    objc_setAssociatedObject(sheet, &Web_Jump_Key, webString, OBJC_ASSOCIATION_COPY);
    [sheet showInCurrentView];
}

- (void)actionSheet:(XMGActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString * webString = objc_getAssociatedObject(actionSheet, &Web_Jump_Key);
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:webString]];
    } else if (buttonIndex == 2)
    {
        XMGWebViewController * webVC = [[XMGWebViewController alloc] initWithTitle:@"" withUrl:webString];
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

@end
