//
//  AddPWView.m
//  XMG
//
//  Created by jrweid on 2018/6/22.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import "AddPWView.h"
#import "PassWordInfo.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface AddPWView ()
{
    GADBannerView * _bannerView;
}
@end

@implementation AddPWView

- (instancetype)initWithVC:(UIViewController *)VC
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = COLOR_HEX(@"#f5f5f5");
        
        [self addSubViewsWithVC:VC];
    }
    return self;
}

- (void)addSubViewsWithVC:(UIViewController *)VC
{
    UILabel * pwContent = [[UILabel alloc] init];
    pwContent.textColor = COLOR_HEX(@"#AAAAAA");
    pwContent.font = [UIFont systemFontOfSize:17];
    pwContent.text = @"密码内容：";
    [self addSubview:pwContent];
    pwContent.sd_layout.leftSpaceToView(self, 15).topSpaceToView(self, 15).rightSpaceToView(self, 15).heightIs(20);
    
    UIView * pwBack = [[UIView alloc] init];
    pwBack.backgroundColor = [UIColor whiteColor];
    pwBack.layer.borderColor = Border_Color.CGColor;
    pwBack.layer.borderWidth = 0.5f;
    [self addSubview:pwBack];
    pwBack.sd_layout.leftSpaceToView(self, -0.5).topSpaceToView(pwContent, 10).rightSpaceToView(self, -0.5).heightIs(133);
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.text = @"标题：";
    [pwBack addSubview:titleLabel];
    titleLabel.sd_layout.leftSpaceToView(pwBack, 15).topSpaceToView(pwBack, 0).widthIs(60).heightIs(44);
    
    UITextField * pwTitle = [[UITextField alloc] init];
    pwTitle.textColor = [UIColor blackColor];
    pwTitle.font = [UIFont systemFontOfSize:17];
    pwTitle.clearButtonMode = UITextFieldViewModeWhileEditing;
    pwTitle.placeholder = @"请输入标题～";
    [pwBack addSubview:pwTitle];
    pwTitle.sd_layout.leftSpaceToView(titleLabel, 0).topEqualToView(titleLabel).rightEqualToView(pwBack).heightIs(44);
    
    UIView * lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = Line_Color;
    [pwBack addSubview:lineView1];
    lineView1.sd_layout.leftSpaceToView(pwBack, 15).topSpaceToView(titleLabel, 0).rightEqualToView(pwBack).heightIs(0.5);
    
    UILabel * accountLabel = [[UILabel alloc] init];
    accountLabel.textColor = [UIColor blackColor];
    accountLabel.font = [UIFont systemFontOfSize:17];
    accountLabel.text = @"账户：";
    [pwBack addSubview:accountLabel];
    accountLabel.sd_layout.leftEqualToView(titleLabel).topSpaceToView(lineView1, 0).widthIs(60).heightIs(44);
    
    UITextField * pwAccount = [[UITextField alloc] init];
    pwAccount.textColor = [UIColor blackColor];
    pwAccount.font = [UIFont systemFontOfSize:17];
    pwAccount.clearButtonMode = UITextFieldViewModeWhileEditing;
    pwAccount.placeholder = @"请输入账号～";
    [pwBack addSubview:pwAccount];
    pwAccount.sd_layout.leftSpaceToView(accountLabel, 0).topEqualToView(accountLabel).rightEqualToView(pwBack).heightIs(44);
    
    UIView * lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = Line_Color;
    [pwBack addSubview:lineView2];
    lineView2.sd_layout.leftSpaceToView(pwBack, 15).topSpaceToView(accountLabel, 0).rightEqualToView(pwBack).heightIs(0.5);
    
    UILabel * pwLabel = [[UILabel alloc] init];
    pwLabel.textColor = [UIColor blackColor];
    pwLabel.font = [UIFont systemFontOfSize:17];
    pwLabel.text = @"密码：";
    [pwBack addSubview:pwLabel];
    pwLabel.sd_layout.leftEqualToView(titleLabel).topSpaceToView(lineView2, 0).widthIs(60).heightIs(44);
    
    UITextField * pwPW = [[UITextField alloc] init];
    pwPW.textColor = [UIColor blackColor];
    pwPW.font = [UIFont systemFontOfSize:17];
    pwPW.clearButtonMode = UITextFieldViewModeWhileEditing;
    pwPW.placeholder = @"请输入密码～";
    [pwBack addSubview:pwPW];
    pwPW.sd_layout.leftSpaceToView(pwLabel, 0).topEqualToView(pwLabel).rightEqualToView(pwBack).heightIs(44);
    
    UITextField * beiZhuInput = [[UITextField alloc] init];
    beiZhuInput.backgroundColor = [UIColor whiteColor];
    beiZhuInput.textColor = [UIColor blackColor];
    beiZhuInput.font = [UIFont systemFontOfSize:17];
    beiZhuInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    beiZhuInput.layer.borderColor = Border_Color.CGColor;
    beiZhuInput.layer.borderWidth = 0.5f;
    beiZhuInput.placeholder = @"备注提示信息～";
    UIView * leftView = [[UIView alloc] init];
    leftView.width = 75;
    beiZhuInput.leftView = leftView;
    beiZhuInput.leftViewMode = UITextFieldViewModeAlways;
    [self addSubview:beiZhuInput];
    beiZhuInput.sd_layout.leftSpaceToView(self, -0.5).topSpaceToView(pwBack, 30).rightSpaceToView(self, -0.5).heightIs(44);
    
    UILabel * beiZhu = [[UILabel alloc] init];
    beiZhu.textColor = [UIColor blackColor];
    beiZhu.font = [UIFont systemFontOfSize:17];
    beiZhu.text = @"备注：";
    [beiZhuInput addSubview:beiZhu];
    beiZhu.sd_layout.leftSpaceToView(beiZhuInput, 15).topSpaceToView(beiZhuInput, 0).widthIs(60).heightIs(44);

    /*
    
    
    _bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
    _bannerView.backgroundColor = COLOR_HEX(@"#f5f5f5");
    _bannerView.rootViewController = VC;
    _bannerView.adUnitID = textId;
    [self addSubview:_bannerView];
    [_bannerView loadRequest:[GADRequest request]];
    
    CGFloat bottom = 0; if (iPhoneX) bottom = 34;
    _bannerView.sd_layout.leftEqualToView(self).bottomSpaceToView(self, bottom).rightEqualToView(self).heightIs(50);*/
    
    CGFloat height = ScreenHeight - 64;
    if (iPhoneX)
    {
        height = ScreenHeight - 88 - 34;
    }
    self.contentSize = CGSizeMake(0, height + 0.3);
}

@end
