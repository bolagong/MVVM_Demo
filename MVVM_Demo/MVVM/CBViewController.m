//
//  CBViewController.m
//  MVVM_Demo
//
//  Created by c on 2019/7/31.
//  Copyright © 2019 CB. All rights reserved.
//

#import "CBViewController.h"
#import "CBView.h"
#import "CBViewModel.h"

@interface CBViewController ()

@property (nonatomic,strong) CBViewModel *aViewModel;
@property (nonatomic,strong) CBView *aView;

@end

@implementation CBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"MVVM练习";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // creat viewModel
    _aViewModel = [[CBViewModel alloc] init];
    
    
    // creat view
    _aView = [[CBView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_aView];
    
    
    // viewModel get data (example requests the data)
    [self.aViewModel getModelData];
    
    // give the data to the view
    [self.aView showView:_aViewModel];
}



@end
