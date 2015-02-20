//
//  VBFRotatingSquare.m
//  VBFFlatLoaders
//
//  Created by Victor Baro on 19/09/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "VBFRotatingSquare.h"

@interface VBFRotatingSquare ()
@property (nonatomic, strong) UIView *square;
@property (nonatomic, strong) CAShapeLayer *shadow;
@property (nonatomic, assign) CGFloat tensionValue;
@end

@implementation VBFRotatingSquare


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}


- (void) commonInit {
    [self addSquare];
    [self addShadow];
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(startAnimation)];
    [self addGestureRecognizer:gr];
}

- (void) addSquare {
    _side = 40;
    _square = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                      0,
                                                      _side,
                                                      _side)];
    _square.center = self.center;
    _square.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.8f];
    _square.layer.borderColor = [UIColor whiteColor].CGColor;
    _square.layer.borderWidth = 1.0;
    
    [self addSubview:_square];
}

- (void) addShadow {
    _shadow = [CAShapeLayer layer];

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(_square.frame.origin.x,
                                  _square.frame.origin.y + _side + 2)];
    [path addLineToPoint:CGPointMake(_square.frame.origin.x + _side,
                                     _square.frame.origin.y + _side + 2)];
    
    self.shadow.path = path.CGPath;
    self.shadow.strokeColor = [UIColor colorWithWhite:0.3 alpha:0.4].CGColor;
    self.shadow.lineWidth = 0.0;
    self.shadow.lineCap = kCALineCapRound;
    
    [self.layer addSublayer:self.shadow];
}

- (void) startAnimation {
    self.tensionValue = 1;
    [self.square.layer addAnimation:[self addAnimationRotation] forKey:@"rot"];
    [self.square.layer addAnimation:[self addAnimationVerticalMovement] forKey:@"trans"];
    [self.shadow addAnimation:[self addShadowAnimation] forKey:@"stroke"];
}

- (CAKeyframeAnimation *) addAnimationRotation {
    CAKeyframeAnimation *rot = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rot.values = @[@0, @(M_PI_4), @(M_PI_2)];
    rot.keyTimes = @[@0.0, @0.5, @1.0];
    rot.duration = 0.55;
    rot.calculationMode = kCAAnimationCubic;
    rot.tensionValues = @[@(-self.tensionValue + 1.1),@(0.0),@(-self.tensionValue - 2)];
    
    return rot;
}

- (CAKeyframeAnimation  *) addAnimationVerticalMovement {
    CAKeyframeAnimation *trans = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    CGFloat yValue = self.square.center.y;
    CGFloat amount = ((sqrtf(2) * self.side) - self.side)/2;
    trans.values = @[@(yValue), @(yValue - amount), @(yValue)];
    trans.keyTimes = @[@0.0, @0.5, @1.0];
    trans.duration = 0.55;
    
    trans.calculationMode = kCAAnimationCubic;
    trans.tensionValues = @[@(-self.tensionValue + 1),@(0.0),@(-self.tensionValue - 2)];
    
    return trans;
}

- (CAKeyframeAnimation *) addShadowAnimation {
    CAKeyframeAnimation *sh = [CAKeyframeAnimation animationWithKeyPath:@"lineWidth"];
    sh.values = @[@0.0, @2, @0.0];
    sh.keyTimes = @[@0.0, @0.5, @1.0];
    sh.duration = 0.55;
    sh.calculationMode = kCAAnimationCubic;
    sh.tensionValues = @[@(-self.tensionValue + 1),@(0.0),@(-self.tensionValue - 2)];

    return sh;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
