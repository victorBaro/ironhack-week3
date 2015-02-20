//
//  AnimationCurveExamples.m
//  Week3
//
//  Created by Victor Baro on 20/10/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "AnimationCurveExamples.h"

@implementation AnimationCurveExamples

- (IBAction)linear:(UITapGestureRecognizer *)sender {
    UIView *view = sender.view;
    
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         CGPoint destination;
                         if (view.center.x < 100) {
                             destination = CGPointMake(view.center.x + 250,
                                                       view.center.y);
                         } else {
                             destination = CGPointMake(view.center.x - 250,
                                                       view.center.y);
                         }
                         view.center = destination;
                     } completion:nil];
}

- (IBAction)easinAniation:(UITapGestureRecognizer *)sender {
    UIView *view = sender.view;
    
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGPoint destination;
                         if (view.center.x < 100) {
                             destination = CGPointMake(view.center.x + 250,
                                                       view.center.y);
                         } else {
                             destination = CGPointMake(view.center.x - 250,
                                                       view.center.y);
                         }
                         view.center = destination;
                     } completion:nil];
}

- (IBAction)easeoutAnimation:(UITapGestureRecognizer *)sender {
    UIView *view = sender.view;
    
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGPoint destination;
                         if (view.center.x < 100) {
                             destination = CGPointMake(view.center.x + 250,
                                                       view.center.y);
                         } else {
                             destination = CGPointMake(view.center.x - 250,
                                                       view.center.y);
                         }
                         view.center = destination;
                     } completion:nil];
}

- (IBAction)easinoutAnimation:(UITapGestureRecognizer *)sender {
    UIView *view = sender.view;
    
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         CGPoint destination;
                         if (view.center.x < 100) {
                             destination = CGPointMake(view.center.x + 250,
                                                       view.center.y);
                         } else {
                             destination = CGPointMake(view.center.x - 250,
                                                       view.center.y);
                         }
                         view.center = destination;
                     } completion:nil];
}

@end
