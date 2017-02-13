//
//  DVNTBrowseContainerViewController.m
//  DeviantArt
//
//  Created by Aaron Pearce on 30/05/14.
//  Copyright (c) 2014 DeviantArt. All rights reserved.
//

#import "DVNTBrowseContainerViewController.h"

@interface DVNTBrowseContainerViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate, DVNTNavigationBarDelegate, DVNTAppURLProtocol, DVNTReporterProtocol>

@property (nonatomic) CGFloat statusBarHeight;
@property (nonatomic) UIView *statusBarCurtain;
@property (nonatomic) UIImageView *avatarImageView;
@property (nonatomic) DVNTSubNavigationBar *subNavigationBar;
@property (nonatomic) UIPageViewController *pageViewController;
@property (nonatomic) DVNTNavigationBar *navBar;
@property (nonatomic) BOOL shouldHideStatusBar;
@property (nonatomic) BOOL isPageViewControllerAnimating;
@property (nonatomic) NSMutableArray *navbarVisibleConstraints;
@property (nonatomic) NSMutableArray *navbarHiddenConstraints;

@end


@implementation DVNTBrowseContainerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UIImageView *backgroundImageView = [[UIImageView alloc] init];
    backgroundImageView.contentMode = UIViewContentModeTopLeft;
    UIImage *backgroundImage;


    backgroundImage = [DVNTSlash createSlashWithSize:self.view.bounds.size intersect:[DVNTSlash standardIntersectionForContentAdjustForStatus:YES adjustForNavbar:NO] options:[DVNTSlash createOptionsWithSpecifiedItems:@{@"drawStatusBar":@YES}]];
    
    backgroundImageView.image = backgroundImage;
    [self.view addSubview:backgroundImageView];
    [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionInterPageSpacingKey: @0}];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;

    /*
     This is a bit of a hack, based on an answer at http://stackoverflow.com/questions/21033238/uipageviewcontroller-prevents-my-table-view-from-scrolling-to-top-when-tapping-t/21069767#21069767
     In brief, the status bar can only effect scrollsToTop behavior on one scrollview at a time. If more than one scroll view within the current view hierarchy has scrollsToTop = YES, status bar taps are ignored. This loop finds the hidden UIQueuingScrollView inside the pageViewController and disables scrollsToTop for it. Another UIScrollView is found within the subnav, so its scrollToTop is set to NO in its init method.
     Each view controller that should be scrollable will set its own scrollsToTop to YES when it will appear, and set it to NO when it will disappear.
     */
    for ( UIView *view in (self.pageViewController.view).subviews ) {
        if ( [view isKindOfClass:[UIScrollView class]] ) {
            UIScrollView *scrollView = (UIScrollView *)view;
            scrollView.scrollsToTop = NO;
        }
    }

    [self.view addSubview:self.pageViewController.view];

    [self addChildViewController:self.pageViewController];

    [self.pageViewController didMoveToParentViewController:self];

    self.statusBarCurtain = [[UIView alloc] init];
    self.statusBarCurtain.backgroundColor = [UIColor dvnt_blackColor];
    [self.view addSubview:self.statusBarCurtain];



    _navBar = [[DVNTNavigationBar alloc] init];
    self.navigationItem.title = @"";
    self.navBar.tapDelegate = self;
    [self.view addSubview:self.navBar];


    self.subNavigationBar = [[DVNTSubNavigationBar alloc] initWithTrackingString:@"top" selectionBlock:^(DVNTSubNavigationBar *scrollNavigationBar, NSInteger selectedIndex)  {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // Prune this DDLogInfo call after T27283 is verified in production, so release after 1.10.
            DDLogInfo(@"DVNTBrowseContainerViewController viewDidLoad setViewControllers");
            
            id startingViewController = [self.viewModel viewControllerForSubNavigationItemAtIndex:selectedIndex];
            [self.pageViewController setViewControllers: @[startingViewController] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
        });
    }];
    
    DVNTLandingScreenType defaultLanding = [[NSUserDefaults dvnt_objectForKey:DVNTAccountViewModelLandingScreenKey] integerValue];
    self.subNavigationBar.selectedIndex = [self getIndexFromLandingScreenType:defaultLanding];
    self.subNavigationBar.frame = CGRectOffset(self.subNavigationBar.frame, 0, CGRectGetHeight(self.subNavigationBar.frame));
    [self.view addSubview:self.subNavigationBar];

    [self setupLayout];
}

@end
