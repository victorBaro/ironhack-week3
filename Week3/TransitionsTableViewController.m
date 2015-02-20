//
//  TransitionsTableViewController.m
//  Week3
//
//  Created by Victor Baro on 24/10/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "TransitionsTableViewController.h"
#import "VBFNavigationTransition.h"

@interface TransitionsTableViewController ()<UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) VBFNavigationTransition *animator;
@end

@implementation TransitionsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
}


-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if (!self.animator) {
        self.animator = [VBFNavigationTransition new];
    }
    NSLog(@"delegate");
    switch (operation) {
        case UINavigationControllerOperationPush:
            self.animator.presenting = YES;
            return  self.animator;
        case UINavigationControllerOperationPop:
            self.animator.presenting = NO;
            return self.animator;
        default: return nil;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
