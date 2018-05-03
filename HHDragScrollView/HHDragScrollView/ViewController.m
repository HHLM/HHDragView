//
//  ViewController.m
//  HHDragScrollView
//
//  Created by Mac on 2018/5/3.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "HHDragView.h"
#import "HHCollectionView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    HHDragView *topView = [[HHDragView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 200)];
    [self.view addSubview:topView];
    
    HHCollectionView *bottomView = [[HHCollectionView alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 200)];
    [self.view addSubview:bottomView];
}


@end
