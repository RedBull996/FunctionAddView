//
//  FunctionMenuView.h
//  XMRyPersonal
//
//  Created by 宋克军 on 2018/4/13.
//  Copyright © 2018年 company. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FunctionMenuView;
@protocol FunctionMenuViewDelegate <NSObject>
@optional
- (void)menuViewStartDismiss:(FunctionMenuView *)menuView;
- (void)menuViewDidDismiss:(FunctionMenuView *)menuView;
@end
@interface FunctionMenuView : UIView
@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, weak) id<FunctionMenuViewDelegate> delegate;
/**
 *  初始化
 *
 *  @param frame
 *  @param function  菜单
 */
- (instancetype)initWithFrame:(CGRect)frame functions:(NSMutableArray *)function;
- (void)show;
@end
