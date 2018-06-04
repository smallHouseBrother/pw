//
//  FingerAuthView.m
//  XMG
//
//  Created by jrweid on 2018/6/4.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import "fingerAuthView.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation fingerAuthView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews
{
    NSDictionary * infoDict = [[NSBundle mainBundle] infoDictionary];
    NSArray * iconsName = infoDict[@"CFBundleIcons"][@"CFBundlePrimaryIcon"][@"CFBundleIconFiles"];
    UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [iconsName lastObject]]];
    
    
}

- (void)requestFingerAuth
{
    LAContext * context = [[LAContext alloc] init];
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil])
    {
        NSLog(@"+++++++++++++++++++++++++");
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:NSLocalizedString(@"通过Home键验证已有手机指纹", nil) reply:^(BOOL success, NSError * _Nullable error) {
            if (success)
            {
                NSLog(@"Authenticated using Touch ID.");
            }
            else
            {
                if (error.code == LAErrorTouchIDNotEnrolled)
                {
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"尚未设置指纹（Touch ID），请在手机“设置＞Touch ID与密码”中添加指纹或打开密码" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                    [alert show];
                }
                else if (error.code == LAErrorUserFallback) {
                    NSLog(@"User tapped Enter Password");
                } else if (error.code == LAErrorUserCancel) {
                    NSLog(@"User tapped Cancel");
                }
            }
        }];
    }
    else
    {
        NSLog(@"_______________________");
    }
}

@end
