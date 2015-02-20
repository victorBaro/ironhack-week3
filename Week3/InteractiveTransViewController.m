//
//  InteractiveTransViewController.m
//  Week3
//
//  Created by Victor Baro on 24/10/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "InteractiveTransViewController.h"
#import "VBFInteractiveTransition.h"

@interface InteractiveTransViewController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) id<VBFSideMenuPanTarget> menuInteractor;
@end

@implementation InteractiveTransViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.menuInteractor = [[VBFInteractiveTransition alloc] initWithParentViewController:self];
    UIScreenEdgePanGestureRecognizer *gestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self.menuInteractor action:@selector(userDidPan:)];
    gestureRecognizer.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
