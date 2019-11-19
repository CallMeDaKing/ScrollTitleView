//
//  ZFTopBarView.m
//  justfun
//
//  Created by new on 2019/11/14.
//  Copyright © 2019 lesports. All rights reserved.
//

#import "ZFTopBarView.h"



static const NSInteger TitleTag = 100;

@interface ZFTopBarView ()

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong, readwrite) UIView *bottomLine;
@property (nonatomic, assign) CGRect currentFrame;

@end

@implementation ZFTopBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.currentIndex = 0;
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setTitlesArray:(NSArray *)titlesArray {
    
    if (titlesArray.count) {
        
        _titlesArray = [titlesArray copy];
        
        CGFloat titleWidth = self.bounds.size.width / titlesArray.count;
        CGFloat titleHeight = self.bounds.size.height;
        
        CGFloat lineWidth = 16.5;
        CGFloat lineHeight = 3;
        CGFloat lineOriginX = (titleWidth - lineWidth) * 0.5;
         
        for (int i = 0; i < titlesArray.count; i ++) {
            UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(0 + i * titleWidth, 0, titleWidth, titleHeight)];
            titleButton.tag = TitleTag + i;
            titleButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            [titleButton setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
            [titleButton setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateSelected];
            [titleButton setTitle:titlesArray[i] forState:UIControlStateNormal];
            titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            titleButton.titleLabel.font = [UIFont fontWithName:@"苹方-简 中黑体" size:15];
            [titleButton addTarget:self action:@selector(onClickTitle:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:titleButton];
            
            if (i == 0) {
                [titleButton setTitleColor:UIColorFromRGB(0xF8EA43) forState:UIControlStateNormal];
                [titleButton setTitleColor:UIColorFromRGB(0xF8EA43) forState:UIControlStateSelected];
                titleButton.transform = CGAffineTransformMakeScale(1.05, 1.05);
                self.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(lineOriginX, titleHeight - 3, lineWidth, lineHeight)];
                self.bottomLine.backgroundColor = UIColorFromRGB(0xF8EA43);
                self.bottomLine.layer.cornerRadius = 1;
                self.bottomLine.layer.masksToBounds = YES;
                [self addSubview:self.bottomLine];
                self.currentFrame = self.bottomLine.frame;
            }
        }
    }
}

- (void)onClickTitle:(UIButton *)sender {

    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickTitleWithIndex:)] && self.titlesArray.count) {
        NSInteger index = sender.tag - TitleTag;
        [self.delegate didClickTitleWithIndex:index];
    }
}

- (void)updateTopBarViewWithProgress:(CGFloat)progress left:(NSInteger)leftIndex right:(NSInteger)rightIndex {
    
    [self updateBottomLineFrameWithProgress:progress leftIndex:leftIndex rightIndex:rightIndex];
    [self updteTabBarTitleColorWithProgress:progress leftIndex:leftIndex rightIndex:rightIndex];
    [self updateTopBarTitleScaleWithProgress:progress leftIndex:leftIndex rightIndex:rightIndex];
}

- (void)updateTopBarTitleScaleWithProgress:(CGFloat)progress leftIndex:(NSInteger)leftIndex rightIndex:(NSInteger)rightIndex {
    
    if (rightIndex > self.titlesArray.count) {
        return;
    }
    CGFloat righScale = progress;
    CGFloat leftScale = 1 - righScale;
    CGFloat scaleTransform = 0.05;     // 初始transform为 1.05 所以在这里只需要在 1 的基础上进行 0.05 的放缩
    
    UIButton *leftSender = [self viewWithTag:leftIndex + TitleTag];
    UIButton *rightSender = [self viewWithTag:rightIndex + TitleTag];
    
    leftSender.transform = CGAffineTransformMakeScale(leftScale * scaleTransform + 1, leftScale * scaleTransform + 1);
    rightSender.transform = CGAffineTransformMakeScale(righScale * scaleTransform + 1, righScale * scaleTransform + 1);
}

- (void)updateBottomLineFrameWithProgress:(CGFloat)progress leftIndex:(NSInteger)leftIndex rightIndex:(NSInteger)rightIndex {
    
    if (rightIndex > self.titlesArray.count) {
        return;
    }
    CGFloat lineWidth = 16.5;
    CGFloat totalWidth = self.bounds.size.width / self.titlesArray.count;
    CGFloat actualVlaue = totalWidth * progress;
    CGFloat originX = (totalWidth - lineWidth) * 0.5;
    CGFloat lineOriginX = leftIndex * totalWidth + originX + actualVlaue;
    self.bottomLine.frame = CGRectMake(lineOriginX, self.bottomLine.frame.origin.y, self.bottomLine.frame.size.width, self.bottomLine.frame.size.height);
}

- (void)updteTabBarTitleColorWithProgress:(CGFloat)progress leftIndex:(NSInteger)leftIndex rightIndex:(NSInteger)rightIndex {
    
    if (rightIndex > self.titlesArray.count) {
        return;
    }
    CGFloat rightScale = progress;
    CGFloat leftScale = 1 - rightScale;
    
    NSArray *startColor = [self getRGBAWithColor:UIColorFromRGB(0xFFFFFF)];
    NSArray *endColor = [self getRGBAWithColor:UIColorFromRGB(0xF8EA43)];
    
    CGFloat deltaR = [endColor[0] floatValue] - [startColor[0] floatValue];
    CGFloat deltaG = [endColor[1] floatValue] - [startColor[1] floatValue];
    CGFloat deltaB = [endColor[2] floatValue] - [startColor[2] floatValue];
    CGFloat deltaA = [endColor[3] floatValue] - [startColor[3] floatValue];
    
    UIColor *rightColor = [UIColor colorWithRed:[startColor[0] floatValue] + deltaR * rightScale green:[startColor[1] floatValue] + deltaG * rightScale blue:[startColor[2] floatValue] + deltaB * rightScale alpha:[startColor[3] floatValue] + deltaA * rightScale];
    UIColor *leftColor = [UIColor colorWithRed:[startColor[0] floatValue] + deltaR * leftScale green:[startColor[1] floatValue] + deltaG * leftScale blue:[startColor[2] floatValue] + deltaB * leftScale alpha:[startColor[3] floatValue] + deltaA * leftScale];
    
    
    UIButton *leftSender = [self viewWithTag:leftIndex + TitleTag];
    UIButton *rightSender = [self viewWithTag:rightIndex + TitleTag];
    
    leftSender.titleLabel.textColor = leftColor;
    rightSender.titleLabel.textColor = rightColor;
}

- (NSArray *)getRGBAWithColor:(UIColor *)color {
    
    CGFloat R = 0.0;
    CGFloat G = 0.0;
    CGFloat B = 0.0;
    CGFloat A = 0.0;
    [color getRed:&R green:&G blue:&B alpha:&A];
    return @[@(R),@(G),@(B),@(A)];
}

- (void)setBottomLineSize:(CGSize)bottomLineSize {
    
    if (bottomLineSize.width && bottomLineSize.height) {
        self.bottomLine.frame = CGRectMake(self.bottomLine.frame.origin.x + (self.bottomLine.frame.size.width - bottomLineSize.width) * 0.5, self.bottomLine.frame.origin.y, bottomLineSize.width, bottomLineSize.height);
        
        [self.bottomLine setNeedsLayout];
        [self.bottomLine layoutIfNeeded];
    }
}

- (void)setBottomLineColorl:(UIColor *)bottomLineColorl {
    self.bottomLine.backgroundColor = bottomLineColorl;
}

@end
