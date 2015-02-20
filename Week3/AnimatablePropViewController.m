//
//  AnimatablePropViewController.m
//  Week3
//
//  Created by Victor Baro on 21/10/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "AnimatablePropViewController.h"

@interface AnimatablePropViewController ()
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *squares;

@end

@implementation AnimatablePropViewController



- (IBAction)boundsAnimation:(UITapGestureRecognizer *)sender {
    UIView *square = sender.view;
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         square.bounds = CGRectMake(0, 0,
                                                    CGRectGetWidth(square.bounds) + 100,
                                                    CGRectGetHeight(square.bounds));
                     } completion:^(BOOL finished) {
                     }];
}

- (IBAction)frameAnimation:(UITapGestureRecognizer *)sender {
    UIView *square = sender.view;
    [UIView animateWithDuration:3.0
                          delay:0.0
         usingSpringWithDamping:0.8
          initialSpringVelocity:5.0
                        options:0
                     animations:^{
                         square.frame = CGRectMake(square.frame.origin.x,
                                                   square.frame.origin.y,
                                                   CGRectGetWidth(square.frame) + 200,
                                                   CGRectGetHeight(square.frame));
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (IBAction)centerAnimation:(UITapGestureRecognizer *)sender {
    UIView *square = sender.view;

    [UIView animateKeyframesWithDuration:0.6
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic
                              animations:^{
                                  [UIView addKeyframeWithRelativeStartTime:0.0
                                                          relativeDuration:1/8.0
                                                                animations:^{
                                                                    square.center = CGPointMake(square.center.x - 10, square.center.y);

                                                                }];
                                  
                                  [UIView addKeyframeWithRelativeStartTime:0.0
                                                          relativeDuration:1 - 1/8.0
                                                                animations:^{
                                                                    square.center = CGPointMake(square.center.x + 110, square.center.y);
                                                                    
                                                                }];
                                  
//                                  [UIView addKeyframeWithRelativeStartTime:0.0
//                                                          relativeDuration:1
//                                                                animations:^{
//                                                                    square.center = CGPointMake(square.center.x - 10, square.center.y);
//
//                                                                }];
//                                  
                                  
                              } completion:nil];
    
}


- (IBAction)transformAnimation:(UITapGestureRecognizer *)sender {
    UIView *square = sender.view;
    [UIView animateWithDuration:2.0
                          delay:0.0
         usingSpringWithDamping:0.5
          initialSpringVelocity:10.0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         square.transform = CGAffineTransformRotate(square.transform, M_PI_4);
                     } completion:^(BOOL finished) {
                         
                     }];
}


- (IBAction)alphaAnimation:(UITapGestureRecognizer *)sender {
    UIView *square = sender.view;

    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         square.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         square.alpha = 1.0;
                     }];
}

- (IBAction)bckgColorAnimation:(UITapGestureRecognizer *)sender {
    
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    UIView *square = sender.view;

    [UIView animateWithDuration:0.5
                     animations:^{
                         square.backgroundColor = color;
                     } completion:^(BOOL finished) {
                     }];
    
    
}


@end
