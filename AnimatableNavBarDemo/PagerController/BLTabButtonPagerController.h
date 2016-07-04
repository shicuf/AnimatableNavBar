//
//  BLTabButtonPagerController.h
//  AnimatableNavBar
//
//  Created by shicuf on 16/7/3.
//  Copyright © 2016年 Belle. All rights reserved.
//

#import "BLTabPagerController.h"
#import "BLTabTitleCell.h"

// register cell conforms to TYTabTitleViewCellProtocol

@interface BLTabButtonPagerController : BLTabPagerController<BLTabPagerControllerDelegate,BLPagerControllerDataSource>

// be carefull!!! the barStyle set style will reset progress propertys, set it (behind [super viewdidload]) or (in init) and set cell property that you want

// pagerBar color
@property (nonatomic, strong) UIColor *pagerBarColor;
@property (nonatomic, strong) UIColor *collectionViewBarColor;

// progress view
@property (nonatomic, assign) CGFloat progressRadius;
@property (nonatomic, strong) UIColor *progressColor;

// text color
@property (nonatomic, strong) UIColor *normalTextColor;
@property (nonatomic, strong) UIColor *selectedTextColor;

@property (nonatomic, copy) void(^indexBlock)(NSInteger index);

@end
