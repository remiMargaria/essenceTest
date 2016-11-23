//
//  RMIHomePagePresenter.m
//  TechnicalTestRMargaria
//
//  Created by Remi Margaria on 16-11-20.
//  Copyright © 2016 Margaria iOS Inc. All rights reserved.
//

#import "RMIHomePagePresenter.h"
#import "RMIHomePageInteractor.h"
#import <UIKit/UIKit.h>

@interface RMIHomePagePresenter ()

@property (nonatomic, strong) RMIHomePageInteractor *interactor;

@end
@implementation RMIHomePagePresenter

+ (instancetype)instanceWithInteractor:(RMIHomePageInteractor *)inteactor {
    
    RMIHomePagePresenter *presenter = [[RMIHomePagePresenter alloc] init];
    presenter.interactor = inteactor;
    
    return presenter;
    
}

- (void)viewDidLoad
{
    __weak typeof(self) weakSelf = self;
    [self.interactor fetchPhotos:^(NSArray *photos, NSError *error) {
        if (!error)
            [weakSelf.delegate photosLoaded:photos]; // Here we paass directly the netWork model. Ideally it's better to convert it to a view model
        else
            NSLog(@"Error Network");
    }];
}

- (void)didTakePhoto:(UIImage *)photo
{
    NSData *data = UIImageJPEGRepresentation(photo, 0.5);
    [self.interactor sendPhotoWithBase64String:[data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn]];
}
@end
