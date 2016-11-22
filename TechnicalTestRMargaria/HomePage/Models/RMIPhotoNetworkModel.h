//
//  RMIPhotoNetworkModel.h
//  TechnicalTestRMargaria
//
//  Created by Remi Margaria on 16-11-20.
//  Copyright © 2016 Margaria iOS Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMIPhotoNetworkModel : NSObject

@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, copy, readonly) NSString *name;

+ (instancetype)instanceWithDictionary:(NSDictionary *)dic;


@end
