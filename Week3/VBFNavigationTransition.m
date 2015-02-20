//
//  VBFNavigationTransition.m
//  Week3
//
//  Created by Victor Baro on 24/10/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "VBFNavigationTransition.h"

@implementation VBFNavigationTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 1.0f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect startFrame = fromViewController.view.frame;

    
    if (self.presenting) {
        
        [transitionContext.containerView addSubview:fromViewController.view];
        [transitionContext.containerView addSubview:toViewController.view];
        
        
        toViewController.view.center = CGPointMake(500, CGRectGetHeight(fromViewController.view.frame)/2);
        
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0.0
             usingSpringWithDamping:0.95
              initialSpringVelocity:4
                            options:0
                         animations:^{
                             fromViewController.view.transform = CGAffineTransformMakeScale(0.5, 0.5);
                             toViewController.view.center = fromViewController.view.center;
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                             
                         } ];

    }
    else {
        
        [transitionContext.containerView addSubview:toViewController.view];
        [transitionContext.containerView addSubview:fromViewController.view];
        
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0.0
             usingSpringWithDamping:0.95
              initialSpringVelocity:4
                            options:0
                         animations:^{
                             toViewController.view.transform = CGAffineTransformIdentity;
                             toViewController.view.frame = startFrame;
                             fromViewController.view.center = CGPointMake(500, CGRectGetHeight(toViewController.view.frame)/2);
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                         } ];
        
    }
}


@end
