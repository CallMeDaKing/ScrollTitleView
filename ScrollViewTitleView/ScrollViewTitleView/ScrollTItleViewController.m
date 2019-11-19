//
//  ScrollTItleViewController.m
//  ScrollViewTitleView
//
//  Created by new on 2019/11/19.
//  Copyright © 2019 new. All rights reserved.
//

#import "ScrollTItleViewController.h"
#import "ZFTopBarView.h"
#import "ProjectHeader.h"

@interface ScrollTItleViewController ()<ZFTopBarViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) ZFTopBarView *topBarView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ScrollTItleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createTitleView];
    [self createScrollView];
}

- (void)createTitleView {
    self.topBarView = [[ZFTopBarView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 220) * 0.5, 100, 220, 35)];
    self.topBarView.titlesArray = @[@"测试一",@"测试二"];
    self.topBarView.delegate = self;
    self.navigationItem.titleView = self.topBarView;
}

- (void)createScrollView {
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - NavAndStatusHight)];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, self.view.bounds.size.height);
    [self.view addSubview:self.scrollView];
    
    UIView *firstEmptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height)];
    firstEmptyView.backgroundColor = [UIColor darkGrayColor];
    [self.scrollView addSubview:firstEmptyView];
    
    UIView *secondEmptyView = [[UIView alloc] initWithFrame:CGRectMake(self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height)];
    secondEmptyView.backgroundColor = [UIColor darkTextColor];
    [self.scrollView addSubview:secondEmptyView];
    
}


#pragma  mark -- ZFTopBarViewDelegate

- (void)didClickTitleWithIndex:(NSInteger)index {
    
    [self.scrollView setContentOffset:CGPointMake(self.view.bounds.size.width * index, 0) animated:YES];
}


#pragma  mark -- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.scrollView) {
        NSInteger index = floor(scrollView.contentOffset.x / self.view.bounds.size.width);
        CGFloat progress = scrollView.contentOffset.x / self.view.bounds.size.width - floor(scrollView.contentOffset.x / self.view.bounds.size.width);
        [self.topBarView updateTopBarViewWithProgress:progress left:index right:index + 1];
    }
}

@end
