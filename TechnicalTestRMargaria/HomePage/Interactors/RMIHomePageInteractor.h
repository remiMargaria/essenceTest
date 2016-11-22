//
//  RMIHomePageInteractor.h
//  TechnicalTestRMargaria
//
//  Created by Remi Margaria on 16-11-20.
//  Copyright © 2016 Margaria iOS Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMIHomePageInteractor : NSObject

- (void)fetchPhotos:(void (^)(NSArray *, NSError *))handler;
- (void)sendPhotoWithBase64String:(NSString *)base64Str;

@end
