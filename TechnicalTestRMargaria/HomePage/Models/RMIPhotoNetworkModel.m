//
//  RMIPhotoNetworkModel.m
//  TechnicalTestRMargaria
//
//  Created by Remi Margaria on 16-11-20.
//  Copyright © 2016 Margaria iOS Inc. All rights reserved.
//

#import "RMIPhotoNetworkModel.h"

@interface RMIPhotoNetworkModel ()

@property (nonatomic, copy, readwrite) NSString *identifier;
@property (nonatomic, copy, readwrite) NSString *name;

@end

@implementation RMIPhotoNetworkModel


+ (instancetype)instanceWithDictionary:(NSDictionary *)dic
{
    RMIPhotoNetworkModel *model = [[RMIPhotoNetworkModel alloc] init];
    model.identifier = [dic objectForKey:@"_id"]; // Need to check for null values
    model.name = [dic objectForKey:@"name"];
    
    return model;
}

@end
