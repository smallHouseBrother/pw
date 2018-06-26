//
//  AddPWView.h
//  XMG
//
//  Created by jrweid on 2018/6/22.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddPWViewDelegate <NSObject>

- (void)AddPWViewSelectPhoto;

- (void)AddPWViewWebJumpWithWebString:(NSString *)webString;

@end

@interface AddPWView : UIView

@property (nonatomic, weak) id <AddPWViewDelegate> delegate;

- (void)reloadAddPWCellWithArray:(NSArray *)dataArray withVC:(UIViewController *)rootVC;

- (void)reloadSelectedPhotoWithImage:(UIImage *)image;

@end
