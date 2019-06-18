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

//    [self addYGTextView];
    [self addNoDataView];
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

- (void)addNoDataView {
    /*
    [[YGNoDataView showOnlyTitle:@"无购物记录" toView:self.view offsetY:100 size:CGSizeMake(150, 150) tapBlock:^{
        NSLog(@"YGNoDataView 被点击");
    }] bottomTitleFont:[UIFont systemFontOfSize:20] color:[UIColor redColor]];
    */
    
    /*
    [YGNoDataView showOnlyNullImage:@"general_empty" toView:self.view offsetY:100 size:CGSizeMake(150, 150) tapBlock:^{
        NSLog(@"YGNoDataView 被点击");
    }];
    */
    
//    [YGNoDataView showNullImage:@"general_empty" topTitle:@"温馨提示" toView:self.view offsetY:0 size:CGSizeMake(150, 150) tapBlock:nil];
    
    /*
    [YGNoDataView showNullImage:@"general_empty" topTitle:@"温馨提示" bottomTitle:@"无购物记录，请刷新重试！" toView:self.view offsetY:-100 size:CGSizeMake(150, 150) tapBlock:^{
        NSLog(@"YGNoDataView 被点击");
    }];
     */
    
    
    [YGNoDataView showNullImage:nil bottomTitle:@"无购物记录，请刷新重试！" toView:self.view offsetY:0 size:CGSizeMake(150, 150) tapBlock:^{
        NSLog(@"YGNoDataView 被点击");
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
