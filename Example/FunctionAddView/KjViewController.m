//
//  KjViewController.m
//  FunctionAddView
//
//  Created by tz_skj@126.com on 05/04/2018.
//  Copyright (c) 2018 tz_skj@126.com. All rights reserved.
//

#import "KjViewController.h"
#import <FunctionAddView/FunctionAddView-umbrella.h>
@interface KjViewController ()

@end

@implementation KjViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    FunctionAddView *menu = [[FunctionAddView alloc] initWithFrame:CGRectMake(320-50-30, 568-80-64-49, 50, 50)  functions:nil];
    menu.vc = self;
    [self.view addSubview:menu];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
