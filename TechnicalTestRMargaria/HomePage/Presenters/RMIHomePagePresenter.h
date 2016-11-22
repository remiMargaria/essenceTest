//
//  RMIHomePagePresenter.h
//  TechnicalTestRMargaria
//
//  Created by Remi Margaria on 16-11-20.
//  Copyright © 2016 Margaria iOS Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIImage;
@class RMIHomePageInteractor;

@protocol RMIHomePagePresenterProtocol <NSObject>

- (void)photosLoaded:(NSArray *)photos;

@end
@interface RMIHomePagePresenter : NSObject

@property (nonatomic, weak) id<RMIHomePagePresenterProtocol>delegate;

+ (instancetype)instanceWithInteractor:(RMIHomePageInteractor *)inteactor;

- (void)viewDidLoad;
- (void)didTakePhoto:(UIImage *)photo;
@end
