//
//  FunctionMenuItem.h
//  XMRyPersonal
//
//  Created by 宋克军 on 2018/4/13.
//  Copyright © 2018年 company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FunctionMenuItem : UIView
@property (nonatomic, strong) UIButton *menuBtn;
@property (nonatomic, strong) UILabel *titleLabel;
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title image:(NSString *)image;
@end
