//
//  AddPWView.h
//  XMG
//
//  Created by jrweid on 2018/6/22.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddPWViewDelegate <NSObject>

@end

@interface AddPWView : UIScrollView

@property (nonatomic, weak) id <AddPWViewDelegate> aDelegate;

- (instancetype)initWithVC:(UIViewController *)VC;

@end
