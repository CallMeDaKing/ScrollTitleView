//
//  ZFTopBarView.h
//  justfun
//
//  Created by new on 2019/11/14.
//  Copyright © 2019 lesports. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectHeader.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ZFTopBarViewDelegate <NSObject>

- (void)didClickTitleWithIndex:(NSInteger)index;

@end

@interface ZFTopBarView : UIView

@property (nonatomic, copy) NSArray *titlesArray;
@property (nonatomic, assign) CGSize bottomLineSize;
@property (nonatomic, strong) UIColor *bottomLineColorl;
@property (nonatomic, weak) id<ZFTopBarViewDelegate> delegate;

- (void)updateTopBarViewWithProgress:(CGFloat)progress left:(NSInteger)leftIndex right:(NSInteger)rightIndex;

@end

NS_ASSUME_NONNULL_END
