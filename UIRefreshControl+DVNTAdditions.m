//
//  UIRefreshControl+DVNTAdditions.m
//  DeviantArt
//
//  Created by Aaron Pearce on 4/02/15.
//  Copyright (c) 2015 DeviantArt. All rights reserved.
//

#import "UIRefreshControl+DVNTAdditions.h"

@implementation UIRefreshControl (DVNTAdditions)

- (void)beginInitialRefreshing {
    // iOS7 Bug... http://stackoverflow.com/questions/19026351/ios-7-uirefreshcontrol-tintcolor-not-working-for-beginrefreshing
    // Have to reset the table content offset then refresh to actually get the tint color showing while in this run loop
    // Next run loop it'd be perfect but this seems to work around it.
    
    if ([self.superview isKindOfClass:UIScrollView.class]) {
        UIScrollView *scrollView = (UIScrollView *)self.superview;
        // Compare to content inset to find the top of the view
        if(scrollView.contentOffset.y == -scrollView.contentInset.top){
            scrollView.contentOffset = CGPointMake(0, -self.frame.size.height);
            [self beginRefreshing];
        }
    }
}
 
@end
