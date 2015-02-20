//
//  ModifyCurvesViewController.m
//  Week3
//
//  Created by Victor Baro on 22/10/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "ModifyCurvesViewController.h"
#import "AnimationCurveView.h"

@interface ModifyCurvesViewController ()
@property (nonatomic, strong) CALayer *ball;
@property (weak, nonatomic) IBOutlet AnimationCurveView *curveView;
@property (nonatomic) CGFloat distance;
@end

@implementation ModifyCurvesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.ball = [CALayer layer];
    self.ball.bounds = CGRectMake(0, 0, 60, 60);
    self.ball.cornerRadius = 30;
    self.ball.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7].CGColor;
    self.ball.borderColor = [UIColor whiteColor].CGColor;
    self.ball.position = CGPointMake(40, CGRectGetHeight(self.view.frame) - 150);
    [self.view.layer addSublayer:self.ball];
    
    
    NSMutableDictionary *newActions = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNull null], @"position",
                                       nil];
    self.ball.actions = newActions;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)animateButtonPressed:(id)sender {
    self.distance = 300;
    if (self.ball.position.x > 150) {
        self.distance *= -1;
    }
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation.toValue = @(self.distance + self.ball.position.x);
    animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:self.curveView.resultPoint1.x : self.curveView.resultPoint1.y :self.curveView.resultPoint2.x :self.curveView.resultPoint1.y];
    NSLog(@"Point1: %@, point2: %@",NSStringFromCGPoint(self.curveView.resultPoint1), NSStringFromCGPoint(self.curveView.resultPoint2));
    animation.delegate = self;
    animation.duration = 1.0;

    [self.ball addAnimation:animation forKey:@"position"];
    

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.ball.position = CGPointMake(self.distance + self.ball.position.x, self.ball.position.y);

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
