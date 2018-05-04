//
//  FunctionMenuItem.m
//  XMRyPersonal
//
//  Created by 宋克军 on 2018/4/13.
//  Copyright © 2018年 company. All rights reserved.
//

#import "FunctionMenuItem.h"
#import <Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface FunctionMenuItem()
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *image;
@end
@implementation FunctionMenuItem
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title image:(NSString *)image {
    self = [super init];
    if (self) {
        self.title = title;
        self.image = image;
        self.backgroundColor = [UIColor clearColor];
        [self layoutItem];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [self addGestureRecognizer:tap];
        [tap.rac_gestureSignal subscribeNext:^(id x) {
             UIAlertView *WXinstall=[[UIAlertView alloc]initWithTitle:@"提示框" message:title delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];//一般在if判断中加入
             [WXinstall show];
        }];
    }
    return self;
}
- (void)layoutItem {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:self.image] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    button.layer.cornerRadius = 25;
    button.userInteractionEnabled = NO;
    button.layer.shadowColor = [UIColor grayColor].CGColor;
    button.layer.shadowOffset = CGSizeMake(0, 3);
    button.layer.shadowOpacity = 0.8;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    [self addSubview:button];
    self.menuBtn = button;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.top.bottom.mas_equalTo(0);
    }];
    [button setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [button setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

    UILabel *title = [[UILabel alloc] init];
    title.text = self.title;
    title.font = [UIFont systemFontOfSize:14];
    [self addSubview:title];
    self.titleLabel = title;
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.centerY.mas_equalTo(button.mas_centerY);
    }];
    [title setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [title setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
}
@end
