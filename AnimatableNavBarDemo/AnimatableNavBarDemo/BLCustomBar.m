//
//  BLCustomBar.m
//  AnimatableNavBar
//
//  Created by shicuf on 16/7/3.
//  Copyright © 2016年 Belle. All rights reserved.
//

#import "BLCustomBar.h"

static const CGFloat kTitleViewWidth = 162.0;
static const CGFloat kTitleViewHeigth= 25.0;
static const CGFloat kMinBarHeight = 64.0;
static const CGFloat kMaxBarHeight = kMinBarHeight + kTitleViewHeigth;

@implementation BLCustomBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self configureBar];
    }
    
    return self;
}

- (void)configureBar
{
    // Configure bar appearence
    self.maximumBarHeight = kMaxBarHeight;
    self.minimumBarHeight = kMinBarHeight;
    //    self.backgroundColor = HBColor(250, 250, 250);
    
//    UIView *bgBottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, kTitleViewHeigth, [UIScreen mainScreen].bounds.size.width, 1)];
//    bgBottomLine.backgroundColor = [UIColor colorWithRed:(230)/255.0 green:(230)/255.0 blue:(230)/255.0 alpha:1.0];
//    [self addSubview:bgBottomLine];
//    [bgBottomLine makeConstraints:^(MASConstraintMaker *make) {
//        make.left.and.right.equalTo(0);
//        make.bottom.equalTo(0);
//        make.height.equalTo(1);
//    }];
    
    UIView *segmentBgView = [[UIView alloc] init];
    segmentBgView.backgroundColor = [UIColor clearColor];
    
    BLSubviewLayoutAttributes *initialSegmentLayoutAttributes = [[BLSubviewLayoutAttributes alloc] init];
    initialSegmentLayoutAttributes.size = CGSizeMake(kTitleViewWidth, kTitleViewHeigth);
    initialSegmentLayoutAttributes.center = CGPointMake(self.frame.size.width*0.5, self.maximumBarHeight-kTitleViewHeigth * 0.5);
    [segmentBgView addLayoutAttributes:initialSegmentLayoutAttributes forProgress:0.0];
    
    BLSubviewLayoutAttributes *midwaySegmentLayoutAttributes = [[BLSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:initialSegmentLayoutAttributes];
    midwaySegmentLayoutAttributes.center = CGPointMake(self.frame.size.width*0.5, (self.maximumBarHeight-self.minimumBarHeight)*0.4+self.minimumBarHeight-kTitleViewHeigth * 0.5);
    [segmentBgView addLayoutAttributes:midwaySegmentLayoutAttributes forProgress:0.6];
    
    BLSubviewLayoutAttributes *finalSegmentLayoutAttributes = [[BLSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:midwaySegmentLayoutAttributes];
    finalSegmentLayoutAttributes.center = CGPointMake(self.frame.size.width*0.5, self.minimumBarHeight-kTitleViewHeigth * 0.5 - 10);
    [segmentBgView addLayoutAttributes:finalSegmentLayoutAttributes forProgress:1.0];
    
    [self addSubview:segmentBgView];
    _segmentBgView = segmentBgView;
    
    // Add and configure profile image
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_hotbody"]];
    [titleImageView sizeToFit];
    titleImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    BLSubviewLayoutAttributes *initialTitleImageViewLayoutAttributes = [[BLSubviewLayoutAttributes alloc] init];
    initialTitleImageViewLayoutAttributes.size = [titleImageView sizeThatFits:CGSizeZero];
    initialTitleImageViewLayoutAttributes.center = CGPointMake(self.frame.size.width*0.5, 42.0);
    [titleImageView addLayoutAttributes:initialTitleImageViewLayoutAttributes forProgress:0.0];
    
    BLSubviewLayoutAttributes *midwayTitleImageViewLayoutAttributes = [[BLSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:initialTitleImageViewLayoutAttributes];
    midwayTitleImageViewLayoutAttributes.center = CGPointMake(self.frame.size.width*0.5, 42.0*0.8);
    [titleImageView addLayoutAttributes:midwayTitleImageViewLayoutAttributes forProgress:0.8];
    
    BLSubviewLayoutAttributes *finalTitleImageViewLayoutAttributes = [[BLSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:midwayTitleImageViewLayoutAttributes];
    finalTitleImageViewLayoutAttributes.center = CGPointMake(self.frame.size.width*0.5, 42.0*0.5);
    finalTitleImageViewLayoutAttributes.transform = CGAffineTransformMakeScale(0.5, 0.5);
    finalTitleImageViewLayoutAttributes.alpha = 0.0;
    [titleImageView addLayoutAttributes:finalTitleImageViewLayoutAttributes forProgress:1.0];
    
    [self addSubview:titleImageView];
}

@end
