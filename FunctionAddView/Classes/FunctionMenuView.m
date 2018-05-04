//
//  FunctionMenuView.m
//  XMRyPersonal
//
//  Created by 宋克军 on 2018/4/13.
//  Copyright © 2018年 company. All rights reserved.
//
#define kShowAnimationTime      0.3

#define kItemSapce      20
#define kItemWidth      50
#define kItemHeight     kItemWidth

#import "FunctionMenuView.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "FunctionMenuItem.h"
#import <Masonry/Masonry.h>
@implementation FunctionMenuView

- (instancetype)initWithFrame:(CGRect)frame functions:(NSMutableArray *)function {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addBlurEffectForTargetView:self];
        [self layoutMenuItems:nil];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [self addGestureRecognizer:tap];
        @weakify(self);
        [tap.rac_gestureSignal subscribeNext:^(id x) {
            @strongify(self);
            [self dismiss];
        }];
    }
    return self;
}
- (void)layoutMenuItems:(NSMutableArray *)functions {
    NSArray *titles = @[@"测试1", @"测试2",@"测试3",@"测试测试测试测试测试5",@"测试6",@"测试7",@"测试8"];
    for (int i = 0; i < titles.count; i++) {
        FunctionMenuItem *subItem = [[FunctionMenuItem alloc] initWithFrame:CGRectZero title:titles[i] image:@""];
        [self addSubview:subItem];
        subItem.hidden = YES;
        subItem.menuBtn.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
        FunctionMenuItem *last = _items.lastObject;
        [subItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).mas_offset(-30);
            if (last) {
                make.bottom.mas_equalTo(last.mas_top).mas_offset(-15);
            } else {
                make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-80);
            }
        }];
        [self.items addObject:subItem];
    }
    [self layoutIfNeeded];
}
- (void)addBlurEffectForTargetView:(UIView *)targetView {
    // 生成特定样式的模糊效果
    UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView * effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [effectView setFrame:self.frame];
    [self addSubview:effectView];
}
- (void)show {
    if (self.isAnimating) return;
    self.isAnimating = YES;
    if (!self.superview) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    ((FunctionMenuItem *)self.items.firstObject).menuBtn.transform = CGAffineTransformMakeScale(1, 1);

    [self.superview bringSubviewToFront:self];
    self.hidden = YES;
    self.alpha = 0;
    @weakify(self);
    [UIView animateWithDuration:kShowAnimationTime animations:^{
        @strongify(self);
        self.hidden = NO;
        self.alpha = 1;
        for (FunctionMenuItem *subView in self.items) {
            subView.hidden = NO;
            subView.menuBtn.transform = CGAffineTransformMakeScale(1, 1);
            [subView.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-70);
            }];
            [subView layoutIfNeeded];
        }
    } completion:^(BOOL finished) {
        @strongify(self);
        self.isAnimating = NO;
    }];
}
- (void)dismiss {
    if (self.isAnimating) {
        return;
    }
    self.isAnimating = YES;
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
        for (int i = 0; i < self.items.count; i++) {
            FunctionMenuItem *subView = self.items[i];
            if (i == 0) {
                subView.hidden = YES;
            } else {
                subView.menuBtn.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
            }
            [subView.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(0);
            }];
            [subView layoutIfNeeded];
        }
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(menuViewDidDismiss:)]) {
            [self.delegate menuViewDidDismiss:self];
        }
        self.isAnimating = NO;
        [self removeFromSuperview];
    }];
    if ([self.delegate respondsToSelector:@selector(menuViewStartDismiss:)]) {
        [self.delegate menuViewStartDismiss:self];
    }
}
- (NSMutableArray *)items {
    if (!_items) {
        self.items = [NSMutableArray array];
    }
    return _items;
}
@end
