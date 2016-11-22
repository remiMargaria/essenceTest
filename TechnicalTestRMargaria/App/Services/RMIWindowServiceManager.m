//
//  RMIWindowServiceManager.m
//  TechnicalTestRMargaria
//
//  Created by Remi Margaria on 16-11-20.
//  Copyright © 2016 Margaria iOS Inc. All rights reserved.
//

#import "RMIWindowServiceManager.h"
#import "RMIHomePageViewController.h"

@implementation RMIWindowServiceManager

- (UIViewController *)createRootViewController
{
    RMIHomePageViewController *homePageViewController = [RMIHomePageViewController viewController];
    UINavigationController *navigationViewController = [[UINavigationController alloc] initWithRootViewController:homePageViewController];
    UITabBarController *tabBarViewController = [[UITabBarController alloc] init];
    tabBarViewController.viewControllers = @[navigationViewController];
    
    return tabBarViewController;
}

@end

