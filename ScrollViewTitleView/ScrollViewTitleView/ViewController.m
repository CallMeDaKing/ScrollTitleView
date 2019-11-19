//
//  ViewController.m
//  ScrollViewTitleView
//
//  Created by new on 2019/11/19.
//  Copyright © 2019 new. All rights reserved.
//

#import "ViewController.h"
#import "ZFTopBarView.h"
#import "ScrollTItleViewController.h"

@interface ViewController ()

@property (nonatomic, strong) ZFTopBarView *topBarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *openVC = [[UIButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 200) * 0.5, 100, 200, 60)];
    [openVC setTitle:@"测试" forState:UIControlStateNormal];
    [openVC addTarget:self action:@selector(clickOpenVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:openVC];
}

- (void)clickOpenVC {
    ScrollTItleViewController *scrollViewController = [[ScrollTItleViewController alloc] init];
    [self.navigationController pushViewController:scrollViewController animated:NO];
}

@end
