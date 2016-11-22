//
//  RMIWindowServiceManager_test.m
//  TechnicalTestRMargaria
//
//  Created by Remi Margaria on 16-11-20.
//  Copyright © 2016 Margaria iOS Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RMIWindowServiceManager.h"

@interface RMIWindowServiceManager_test : XCTestCase

@property (nonatomic, strong) RMIWindowServiceManager *sut;
@end

@implementation RMIWindowServiceManager_test

- (void)setUp {
    self.sut = [[RMIWindowServiceManager alloc] init];
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_GivenWindowServiceManager_WhenCreateRootViewController_ThenReturnTabBar
{
    id controller = [self.sut createRootViewController];
    XCTAssertTrue([controller isKindOfClass:[UITabBarController class]]);

}

@end
