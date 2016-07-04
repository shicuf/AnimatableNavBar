//
//  BLCustomPagerController.m
//  AnimatableNavBar
//
//  Created by shicuf on 16/7/3.
//  Copyright © 2016年 Belle. All rights reserved.
//

#import "BLCustomPagerController.h"
#import "BLTabButtonPagerController.h"
#import "CustomViewController.h"
#import "ListViewController.h"
#import "CollectionViewController.h"

#import "BLCustomBar.h"
#import "BLSplitterDelegate.h"
#import "BLImageStyleBehavior.h"

static const CGFloat kTitleViewWidth = 162;
static const CGFloat kTitleViewHeigth= 25;

@interface BLCustomPagerController ()<BLTabPagerControllerDelegate, BLPagerControllerDataSource>

@property (nonatomic) BLCustomBar *communityBar;
@property (nonatomic) BLSplitterDelegate *delegateSplitter;

@property (nonatomic, strong) BLTabButtonPagerController *pagerController;
@property (nonatomic, weak) ListViewController *recommendVc;
@property (nonatomic, weak) CustomViewController *monitorVc;

@end

@implementation BLCustomPagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self addPagerController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!_showNavBar) {
        self.navigationController.navigationBarHidden = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (!_showNavBar) {
        self.navigationController.navigationBarHidden = NO;
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _pagerController.view.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupNavigationBar {
    [self setNeedsStatusBarAppearanceUpdate];
    
    // Setup the bar
    self.communityBar = [[BLCustomBar alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), 100.0)];
    
    BLImageStyleBehavior *behaviorDefiner = [[BLImageStyleBehavior alloc] init];
    [behaviorDefiner addSnappingPositionProgress:0.0 fromStartProgress:0.0 toEndProgress:0.5];
    [behaviorDefiner addSnappingPositionProgress:1.0 fromStartProgress:0.5 toEndProgress:1.0];
    behaviorDefiner.snappingEnabled = YES;
    behaviorDefiner.elastic = NO;
    self.communityBar.behavior = behaviorDefiner;
    
    // Configure a separate UITableViewDelegate and UIScrollViewDelegate (optional)
    self.delegateSplitter = [[BLSplitterDelegate alloc] initWithAdditionalDelegate:behaviorDefiner originalDelegate:self.recommendVc];
    self.recommendVc.tableView.delegate = (id<UITableViewDelegate>)self.delegateSplitter;
    //    self.monitorVc.tableView.delegate = (id<UITableViewDelegate>)self.delegateSplitter;
    [self.view addSubview:self.communityBar];
    
    
    UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBarButton setImage:[UIImage imageNamed:@"nav_notification"] forState:UIControlStateNormal];
    [leftBarButton setImage:[UIImage imageNamed:@"nav_notification_h"] forState:UIControlStateHighlighted];
    [leftBarButton addTarget:self action:@selector(showRemindVc) forControlEvents:UIControlEventTouchUpInside];
    [leftBarButton sizeToFit];
    leftBarButton.frame = CGRectMake(12, 30, leftBarButton.frame.size.width, leftBarButton.frame.size.height);
    [self.communityBar addSubview:leftBarButton];
    
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarButton setImage:[UIImage imageNamed:@"nav_takePhoto"] forState:UIControlStateNormal];
    [rightBarButton setImage:[UIImage imageNamed:@"nav_takePhoto_h"] forState:UIControlStateHighlighted];
    [rightBarButton addTarget:self action:@selector(showPostVc) forControlEvents:UIControlEventTouchUpInside];
    [rightBarButton sizeToFit];
    rightBarButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - rightBarButton.frame.size.width - 12, 30, rightBarButton.frame.size.width, rightBarButton.frame.size.height);
    [self.communityBar addSubview:rightBarButton];
}

#pragma mark - Event Response
- (void)showRemindVc {
    
}

- (void)showPostVc {
    
}

- (void)addPagerController
{
    BLTabButtonPagerController *pagerController = [[BLTabButtonPagerController alloc] initWithSuperBarView:_communityBar.segmentBgView];
    pagerController.dataSource = self;
    pagerController.delegate = self;
    pagerController.adjustStatusBarHeight = YES;
    //BLTabButtonPagerController set barstyle will reset (BLTabPagerController not reset)cell propertys
    pagerController.barStyle = _variable ? BLPagerBarStyleProgressBounceView: BLPagerBarStyleProgressView;
    // after set barstyle,you need set cell propertys that you want
    //pagerController.cellWidth = 56;
    pagerController.cellSpacing = 70;
    if (_showNavBar) {
        pagerController.progressWidth = _variable ? 0 : 36;
    }
    
    pagerController.view.frame = self.view.bounds;
    [self addChildViewController:pagerController];
    [self.view addSubview:pagerController.view];
    _pagerController = pagerController;
    
    [self.view bringSubviewToFront:self.communityBar];
}

- (void)scrollToRamdomIndex
{
    [_pagerController moveToControllerAtIndex:1 animated:NO];
}

#pragma mark - BLPagerControllerDataSource

- (NSInteger)numberOfControllersInPagerController {
    return 2;
}

- (NSString *)pagerController:(BLPagerController *)pagerController titleForIndex:(NSInteger)index {
    return index == 0 ? @"关注":@"推荐";
}

- (UIViewController *)pagerController:(BLPagerController *)pagerController controllerForIndex:(NSInteger)index
{
    if (index == 0) {
        ListViewController *VC = [[ListViewController alloc]init];
        VC.text = [@(index) stringValue];
        self.recommendVc = VC;
        
        self.delegateSplitter.additionalDelegate = self.recommendVc;
        self.recommendVc.tableView.delegate = (id<UITableViewDelegate>)self.delegateSplitter;
        // 更新bar的高度
        [self.communityBar.behavior snapToResetProgress];
        
        return VC;
    }else {
        CustomViewController *VC = [[CustomViewController alloc]init];
        VC.text = [@(index) stringValue];
        self.monitorVc = VC;
        return VC;
    }
}

#pragma mark - BLTabPagerControllerDelegate

- (void)pagerController:(BLTabPagerController *)pagerController didSelectAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        self.delegateSplitter.additionalDelegate = self.recommendVc;
        self.recommendVc.tableView.delegate = (id<UITableViewDelegate>)self.delegateSplitter;
        // 更新bar的高度
        [self.communityBar.behavior snapToResetProgress];
    }
}
@end
