//
//  RMIPhotoViewerViewController.m
//  TechnicalTestRMargaria
//
//  Created by Remi Margaria on 16-11-20.
//  Copyright © 2016 Margaria iOS Inc. All rights reserved.
//

#import "RMIPhotoViewerViewController.h"
#import <AFNetworking.h>

@interface RMIPhotoViewerViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) NSString *identifier;

@end

@implementation RMIPhotoViewerViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://api-server.essenceprototyping.com:999"]];
    manager.responseSerializer =[[AFHTTPResponseSerializer alloc] init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    [manager GET:[NSString stringWithFormat:@"/photos/get/%@", self.identifier] parameters:nil progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, NSString * _Nullable responseObject) {
        NSData *data = [[NSData alloc] initWithBase64EncodedString:responseObject options:NSDataBase64DecodingIgnoreUnknownCharacters];
        
        UIImage *image = [UIImage imageWithData:data];
        weakSelf.imageView.image = image;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error");
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


+ (instancetype)viewControllerWithId:(NSString *)identifier
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"RMIPhotoViewerStoryBoard" bundle:[NSBundle mainBundle]];
    RMIPhotoViewerViewController *viewController = [storyBoard instantiateViewControllerWithIdentifier:@"RMIPhotoViewerViewController_Id"];
    viewController.identifier = identifier;
    
    return viewController;
}

@end
