//
//  DVNTMoreLikeThisViewController.m
//  DeviantArt
//
//  Created by Aaron Pearce on 25/07/14.
//  Copyright (c) 2014 DeviantArt. All rights reserved.
//

#import "DVNTMoreLikeThisViewController.h"

@interface DVNTMoreLikeThisViewController () <DVNTAppURLProtocol>


@end

@implementation DVNTMoreLikeThisViewController


// from http://stackoverflow.com/questions/2798653/is-it-possible-to-determine-whether-viewcontroller-is-presented-as-modal
// could be a handy category
- (BOOL)isModal {
    return self.presentingViewController.presentedViewController == self
    || self.navigationController.presentingViewController.presentedViewController == self.navigationController
    || [self.tabBarController.presentingViewController isKindOfClass:[UITabBarController class]];
}

@end
