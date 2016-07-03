//
//  BLTabTitleCell.h
//  AnimatableNavBar
//
//  Created by shicuf on 16/7/3.
//  Copyright © 2016年 Belle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLTabTitleCellProtocol.h"

@interface BLTabTitleCell : UICollectionViewCell<BLTabTitleCellProtocol>

@property (nonatomic, weak,readonly) UILabel *titleLabel;

@end
