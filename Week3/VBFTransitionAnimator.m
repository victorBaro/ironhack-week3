//
//  VBFTransitionAnimator.m
//  Week3
//
//  Created by Victor Baro on 23/10/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "VBFTransitionAnimator.h"

@implementation VBFTransitionAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.8f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {

    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    

    CGFloat width = 200;
    CGFloat height = 150;
    CGRect detailControllerFrame = CGRectMake(0,
                                              0,
                                              width, height);
    
    if (self.presenting) {
        fromViewController.view.userInteractionEnabled = NO;
        
        [transitionContext.containerView addSubview:fromViewController.view];
        [transitionContext.containerView addSubview:toViewController.view];
        

        toViewController.view.frame = detailControllerFrame;
        toViewController.view.center = CGPointMake(500, CGRectGetHeight(fromViewController.view.frame)/2);
        
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0.0
             usingSpringWithDamping:0.6
              initialSpringVelocity:10
                            options:0
                         animations:^{
                             fromViewController.view.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
                             fromViewController.view.transform = CGAffineTransformMakeScale(0.9, 0.9);
                             toViewController.view.center = fromViewController.view.center;
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];

                         } ];
        
        

    }
    else {
        toViewController.view.userInteractionEnabled = YES;
        
        [transitionContext.containerView addSubview:toViewController.view];
        [transitionContext.containerView addSubview:fromViewController.view];
        
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0.0
             usingSpringWithDamping:0.6
              initialSpringVelocity:10
                            options:0
                         animations:^{
                             toViewController.view.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
                             toViewController.view.transform = CGAffineTransformIdentity;
                             fromViewController.view.center = CGPointMake(500, CGRectGetHeight(toViewController.view.frame)/2);
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                             [[UIApplication sharedApplication].keyWindow addSubview:toViewController.view];
                         } ];
        
    }
}

@end
