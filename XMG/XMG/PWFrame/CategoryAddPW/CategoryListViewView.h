//
//  CategoryListViewView.h
//  XMG
//
//  Created by jrweid on 2018/6/22.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CategoryListViewViewDelegate <NSObject>



@end

@interface CategoryListViewView : UIView

@property (nonatomic, weak) id <CategoryListViewViewDelegate> delegate;

@end
