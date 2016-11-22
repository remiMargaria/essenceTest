//
//  RMIHomePageInteractor.m
//  TechnicalTestRMargaria
//
//  Created by Remi Margaria on 16-11-20.
//  Copyright © 2016 Margaria iOS Inc. All rights reserved.
//

#import "RMIHomePageInteractor.h"
#import <AFNetworking.h>
#import <AFNetworking/AFURLResponseSerialization.h>

#import "RMIPhotoNetworkModel.h"

@implementation RMIHomePageInteractor

- (void)fetchPhotos:(void (^)(NSArray *, NSError *))handler
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://api-server.essenceprototyping.com:999"]];
    manager.responseSerializer = [[AFJSONResponseSerializer alloc] init];
    [manager GET:@"/photos/search/?searchString" parameters:nil progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, NSArray * _Nullable responseObject) {
        
        NSMutableArray *photos = [NSMutableArray array];
        for (NSDictionary *dic in responseObject)
            [photos addObject:[RMIPhotoNetworkModel instanceWithDictionary:dic]];
        
        handler([photos copy], nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        handler(nil, error);
    }];
}

- (void)sendPhotoWithBase64String:(NSString *)base64Str
{
    NSError *error;
    NSDictionary *body = @{@"name": @"Photo", @"data" : base64Str};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer =[[AFJSONResponseSerializer alloc] init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"https://api-server.essenceprototyping.com:999/photos/upload"] parameters:nil error:nil];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            
            NSLog(@"Reply: %@", responseObject);
        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
        }
    }] resume];
}

@end
