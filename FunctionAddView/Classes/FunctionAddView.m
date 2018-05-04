//
//  FunctionAddView.m
//  XMRyPersonal
//
//  Created by 宋克军 on 2018/4/13.
//  Copyright © 2018年 company. All rights reserved.
//

#import "FunctionAddView.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "FunctionMenuView.h"
@implementation FunctionAddView
- (instancetype)initWithFrame:(CGRect)frame functions:(NSMutableArray *)function {
    CGFloat min = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame));
    self = [super initWithFrame:CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), min, min)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = min/2.0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [self addGestureRecognizer:tap];
        FunctionMenuView *subView = [[FunctionMenuView alloc] initWithFrame:CGRectZero functions:function];
        @weakify(self);
        subView.delegate = self;
        [tap.rac_gestureSignal subscribeNext:^(id x) {
            @strongify(self);
            [UIView animateWithDuration:0.15 animations:^{
                self.addButton.transform = CGAffineTransformMakeRotation(M_PI_2);
            } completion:^(BOOL finished) {
                [subView show];
            }];
        }];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = self.bounds;
        button.backgroundColor = [UIColor redColor];
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSBundle *resourceBundle = [NSBundle bundleWithURL:[bundle URLForResource:@"FunctionAddView" withExtension:@"bundle"]];
        UIImage* succ_image = [UIImage imageWithContentsOfFile:[resourceBundle pathForResource:@"add task@2x" ofType:@"png"]];
        [button setImage:succ_image forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:20];
        button.userInteractionEnabled = NO;
        [self addSubview:button];
        self.addButton = button;
    }
    return self;
}
- (void)menuViewStartDismiss:(FunctionMenuView *)menuView {
    [UIView animateWithDuration:0.3 animations:^{
        self.addButton.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
    }];
}
@end
