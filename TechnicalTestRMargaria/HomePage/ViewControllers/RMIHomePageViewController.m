//
//  RMIHomePageViewController.m
//  TechnicalTestRMargaria
//
//  Created by Remi Margaria on 16-11-20.
//  Copyright © 2016 Margaria iOS Inc. All rights reserved.
//

#import "RMIHomePageViewController.h"
#import "RMIHomePagePresenter.h"
#import "RMIHomePageInteractor.h"
#import "RMIPhotoViewerViewController.h"

@interface RMIHomePageViewController ()<RMIHomePagePresenterProtocol, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) RMIHomePagePresenter *presenter;
@property (nonatomic , strong) NSArray *photos;
@end

@implementation RMIHomePageViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    self.presenter = [RMIHomePagePresenter instanceWithInteractor:[[RMIHomePageInteractor alloc] init]];
    self.presenter.delegate = self;
    return self;
}

- (void)viewDidLoad {

    [super viewDidLoad];
    self.title = @"Photos";
    [self.presenter viewDidLoad];
    UIBarButtonItem *takePhotoBarButtonIdem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takePicture:)];
    [self.navigationItem setRightBarButtonItem:takePhotoBarButtonIdem];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (instancetype)viewController
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"RMIHomePageStoryBoard" bundle:[NSBundle mainBundle]];
    return [storyBoard instantiateViewControllerWithIdentifier:@"RMIHomePageViewController_Id"];
}

- (void)takePicture:(UIButton *)button
{
    UIImagePickerController *imagePickerViewController = [[UIImagePickerController alloc] init];
    imagePickerViewController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerViewController.delegate = self;
    [self presentViewController:imagePickerViewController animated:YES completion:NULL];
}

#pragma - RMIHomePagePresenterProtocol

- (void)photosLoaded:(NSArray *)photos
{
    self.photos = photos;
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RMIHomePagePhotoCellIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = [[self.photos objectAtIndex:indexPath.row] name];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.photos count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RMIPhotoViewerViewController *photoViewerViewController = [RMIPhotoViewerViewController viewControllerWithId:[[self.photos objectAtIndex:indexPath.row] identifier]];
    [self.navigationController pushViewController:photoViewerViewController animated:YES];
}

#pragma - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self.presenter didTakePhoto:image];
}

@end
