//
//  MultipleExampleAnimationsViewController.m
//  Week3
//
//  Created by Victor Baro on 23/10/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "MultipleExampleAnimationsViewController.h"

@interface MultipleExampleAnimationsViewController ()
@property (nonatomic, strong) CALayer *animLayer;
@end

@implementation MultipleExampleAnimationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.animLayer = [CALayer layer];
    self.animLayer.bounds = CGRectMake(0, 0, 60, 60);
    self.animLayer.cornerRadius = 30;
    self.animLayer.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.7].CGColor;
    self.animLayer.borderColor = [UIColor whiteColor].CGColor;
    self.animLayer.position = CGPointMake(40, CGRectGetHeight(self.view.frame)/2);
    [self.view.layer addSublayer:self.animLayer];
    
    [self additive];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) additive {
    CABasicAnimation *bounceAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    bounceAnimation.duration = 0.5;
    bounceAnimation.fromValue = [NSNumber numberWithInt:0];
    bounceAnimation.toValue = [NSNumber numberWithInt:30];
    bounceAnimation.repeatCount = 10;
    bounceAnimation.autoreverses = YES;
    bounceAnimation.fillMode = kCAFillModeForwards;
    bounceAnimation.removedOnCompletion = NO;
    bounceAnimation.additive = YES;
    [self.animLayer addAnimation:bounceAnimation forKey:@"bounceAnimation"];
    
    CABasicAnimation *scrollAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    scrollAnimation.duration = 5;
    scrollAnimation.fromValue = [NSNumber numberWithInt:0];
    scrollAnimation.toValue = [NSNumber numberWithInt:300];
    scrollAnimation.fillMode = kCAFillModeForwards;
    scrollAnimation.removedOnCompletion = NO;
    //scrollAnimation.additive = YES;
    [self.animLayer addAnimation:scrollAnimation forKey:@"scrollAnimation"];
}

- (void) group {

    
}

- (void) viewTransition {
//    [UIView transitionWithView:containerView
//                      duration:0.2
//                       options:UIViewAnimationOptionTransitionFlipFromLeft
//                    animations:^{
//    [fromView removeFromSuperview];
//    [containerView addSubview:toView];
//}
//                    completion:NULL];
    
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
