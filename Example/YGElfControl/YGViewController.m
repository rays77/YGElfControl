//
//  YGViewController.m
//  YGElfControl
//
//  Created by rays on 06/14/2019.
//  Copyright (c) 2019 rays. All rights reserved.
//

#import "YGViewController.h"
#import "YGElfHeader.h"

@interface YGViewController ()

@end

@implementation YGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self addYGTextView];
}

- (void)addYGTextView {
    YGTextView *textView = [[YGTextView alloc] init];
    textView.layer.cornerRadius = 4;
    textView.layer.borderColor = [UIColor redColor].CGColor;
    textView.layer.borderWidth = 1.0;
    textView.layer.masksToBounds = YES;
    textView.frame = CGRectMake(20, 100, 200, 200);
    textView.placeholder = @"请输入名称";
    textView.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:textView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
