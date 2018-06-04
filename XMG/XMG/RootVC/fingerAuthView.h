//
//  FingerAuthView.h
//  XMG
//
//  Created by jrweid on 2018/6/4.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@class fingerAuthView;

@protocol fingerAuthViewDelegate <NSObject>

- (void)fingerView:(fingerAuthView *)fingerView didSuccessAuth:(BOOL)isSuccess;

@end

@interface fingerAuthView : UIView

@property (nonatomic, weak) id <fingerAuthViewDelegate> delegate;

@end

