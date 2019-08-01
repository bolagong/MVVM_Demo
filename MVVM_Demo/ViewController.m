//
//  ViewController.m
//  MVVM_Demo
//
//  Created by c on 2019/7/31.
//  Copyright © 2019 CB. All rights reserved.
//

#import "ViewController.h"
#import "CBViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"MVVM";
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
    tipLabel.font = [UIFont systemFontOfSize:20];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = [UIColor brownColor];
    tipLabel.text = @"点击一下进入";
    [self.view addSubview:tipLabel];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CBViewController *aVC = [[CBViewController alloc] init];
    [self.navigationController pushViewController:aVC animated:YES];
}


@end
