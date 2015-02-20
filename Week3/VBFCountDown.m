//
//  VBFCountDown.m
//  Reaction
//
//  Created by Victor Baro on 11/05/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//


#import "VBFCountDown.h"
#import <pop/POP.h>


static NSInteger const kNumberOfDivisions = 60;


@interface VBFCountDown () <POPAnimationDelegate> {
    NSUInteger _remainingSeconds;
    int _currentDivision;
}
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) CAShapeLayer *mainCircle;
@property (nonatomic, strong) NSMutableArray *divisions;
@property (nonatomic, strong) NSTimer *divisionTimer;
@end

@implementation VBFCountDown



- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame countDownTime:3];
}

- (id)initWithFrame:(CGRect)frame
      countDownTime:(NSInteger)seconds {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _totalSeconds = seconds;
        _remainingSeconds = seconds;
        [self addCountdown];
    }
    return self;
}
- (void)awakeFromNib {
    [self addCountdown];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutIfNeeded];
    [self updateLayout];
}
- (void) addCountdown {
    [self addNumber];
    [self addMainCircle];
    [self updateLayout];
    self.backgroundColor = [UIColor clearColor];
}
- (void) addNumber {
    self.numberLabel = [[UILabel alloc]initWithFrame:self.bounds];
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    self.numberLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.bounds)*0.5];
    self.numberLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)_remainingSeconds];
    self.numberLabel.textColor = [UIColor whiteColor];
    self.numberLabel.center = self.center;
    [self addSubview:self.numberLabel];
}
- (void) addMainCircle {
    self.mainCircle = [CAShapeLayer layer];
    
    // Configure the apperence of the circle
    self.mainCircle.fillColor = [UIColor clearColor].CGColor;
    self.mainCircle.strokeColor = [UIColor colorWithWhite:1.0 alpha:0.9].CGColor;
    self.mainCircle.lineWidth = 2.0;
    self.mainCircle.strokeEnd = 0.0;
    self.mainCircle.lineCap = kCALineCapRound;
    [self.layer addSublayer:self.mainCircle];
}
- (void)updateLayout {
    CGPoint selfCenter = CGPointMake(CGRectGetWidth(self.bounds)/2,
                                     CGRectGetHeight(self.bounds)/2);
    self.numberLabel.center = selfCenter;
    CGFloat mainCircleDiameter = MIN(CGRectGetHeight(self.bounds),
                                     CGRectGetWidth(self.bounds));
    CGRect mainCircleFrame = CGRectMake(selfCenter.x - mainCircleDiameter/2,
                                        selfCenter.y - mainCircleDiameter/2,
                                        mainCircleDiameter,
                                        mainCircleDiameter);
    self.mainCircle.frame = mainCircleFrame;
    self.mainCircle.path = [self mainCirclePathForCircleDiameter:mainCircleDiameter].CGPath;
}
#pragma mark -  Public api
- (void)stopCountdown {
    [self.divisionTimer invalidate];
    self.divisionTimer = nil;
    [self.mainCircle removeAllAnimations];
    [self.numberLabel.layer removeAllAnimations];
    [self restartValues];
}
- (void)restartValues {
    [self removeDivisions];
    _remainingSeconds = self.totalSeconds;
    self.mainCircle.strokeEnd = 0.0;
    self.numberLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)_remainingSeconds];
    self.mainCircle.opacity = 1.0;
}
- (void)startCountdown {
    [self updateLayout];
    [self animateMainCircle];
    [self animateNumberAppear];

    _currentDivision = 0;
    CGFloat interval = (CGFloat)1/kNumberOfDivisions;
    self.divisionTimer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                          target:self
                                                        selector:@selector(manageDivision)
                                                        userInfo:nil
                                                         repeats:YES];
}

- (void) updateNumber {
    _remainingSeconds -= 1;
    [self animateNumberDissapear];
}

- (void) manageDivision {
    if (_currentDivision == kNumberOfDivisions - 1) {
        //ALL DIVISIONS ARE ON SCREEN
        [self removeDivisions];
        [self updateNumber];
        
        if (_remainingSeconds == 0) {
            //Kill animation
            [self.divisionTimer invalidate];
            [self countdownHasFinished];
        } else {
            //Restart cicle
            _currentDivision = 0;
            [self addNewDivision];
            _currentDivision +=1;
        }
        
    } else {
        //ADD NEW DIVISION
        [self addNewDivision];
        _currentDivision += 1;
    }
    
}
- (void)removeDivisions {
    for (CAShapeLayer *layer in self.divisions) {
        [layer removeFromSuperlayer];
    }
    [self.divisions removeAllObjects];
}
#pragma mark -  Helping methods
- (void) addNewDivision {
    CGFloat sepAngle = (2*M_PI)/kNumberOfDivisions;
    CGFloat mainCircleDiameter = MIN(CGRectGetHeight(self.bounds),
                                     CGRectGetWidth(self.bounds));
    CGFloat divisionLength = 5;
    CGFloat radialSpace = 5;
    CGFloat innerRadius = mainCircleDiameter/2 - divisionLength - radialSpace;
    
    CGPoint selfCenter = CGPointMake(CGRectGetWidth(self.bounds)/2,
                                     CGRectGetHeight(self.bounds)/2);
    
    CGFloat currentAngle = (sepAngle * _currentDivision) - M_PI_2;
    
    UIBezierPath *divisionPath = [UIBezierPath bezierPath];
    
    CGPoint startP = CGPointMake(selfCenter.x + innerRadius * cosf(currentAngle),
                                 selfCenter.y + innerRadius * sinf(currentAngle));
    CGPoint endP = CGPointMake(selfCenter.x + (innerRadius + divisionLength) * cosf(currentAngle),
                               selfCenter.y + (innerRadius + divisionLength) * sinf(currentAngle));
    
    [divisionPath moveToPoint: startP];
    [divisionPath addLineToPoint: endP];

    CAShapeLayer *division = [CAShapeLayer layer];
    division.path = [divisionPath CGPath];
    division.lineWidth = 1;
    division.strokeColor = [UIColor redColor].CGColor;
    
    [self.layer addSublayer:division];
    
    if (!self.divisions) {
        self.divisions = [[NSMutableArray alloc]init];
    }
    [self.divisions addObject:division];
}
- (UIBezierPath *)mainCirclePathForCircleDiameter:(CGFloat)diameter {
    return [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0,
                                                       0,
                                                       diameter,
                                                       diameter)
                               cornerRadius:diameter/2];
}
#pragma -
#pragma animations
- (void)animateMainCircle {
    POPBasicAnimation *draw = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    draw.duration = _totalSeconds;
    draw.fromValue = @(0.0);
    draw.toValue = @(1.0);
    draw.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.mainCircle pop_addAnimation:draw forKey:@"draw"];
}

- (void) animateNumberAppear {
    self.numberLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)_remainingSeconds];
    
    POPBasicAnimation *fade = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    fade.duration = 0.1;
    fade.fromValue = @(0.0);
    fade.toValue = @(1.0);
    [self.numberLabel pop_addAnimation:fade forKey:@"fadeIn"];
    
    POPSpringAnimation *appear = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    appear.springSpeed = 16;
    appear.springBounciness = 15;
    appear.fromValue = [NSValue valueWithCGSize:CGSizeMake(0.1, 0.1)];
    appear.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
    [self.numberLabel.layer pop_addAnimation:appear forKey:@"appear"];
}
- (void) animateNumberDissapear {
    POPBasicAnimation *fade = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    fade.duration = 0.15;
    fade.toValue = @(0.0);
    [self.numberLabel pop_addAnimation:fade forKey:@"fadeOut"];
    
    POPBasicAnimation *dissappear = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    dissappear.duration = 0.15;
    dissappear.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [dissappear setValue:@"dissappear" forKey:@"animName"];
    dissappear.toValue = [NSValue valueWithCGSize:CGSizeMake(0.1, 0.1)];
    dissappear.delegate = self;
    [self.numberLabel.layer pop_addAnimation:dissappear forKey:@"dissappear"];
}
- (void) addPopRotationToLayer:(CAShapeLayer *)layer {
    POPBasicAnimation *rotate = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    rotate.fromValue = @(-0.05);
    rotate.delegate = self;
    [rotate setValue:@"rotate" forKey:@"animName"];
    rotate.duration = 1;
    rotate.toValue = @(2 * M_PI - 0.05);
    rotate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [layer pop_addAnimation:rotate forKey:@"Rotate"];
}
- (void) countdownHasFinished {
    POPBasicAnimation *fade = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    fade.duration = 0.15;
    fade.toValue = @(0.0);
    fade.delegate = self;
    [fade setValue:@"fadeOut" forKey:@"animName"];
    [self.mainCircle pop_addAnimation:fade forKey:@"fadeOut"];
}

#pragma -
#pragma POP delegate methods
- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished {
    if ([[anim valueForKey:@"animName"] isEqualToString:@"dissappear"]) {
        if (_remainingSeconds != 0) {
            [self animateNumberAppear];
        }
    } else if ([[anim valueForKey:@"animName"] isEqualToString:@"fadeOut"]){
        [self.delegate countDownFinished];
    }
}


#pragma mark -  setters
- (void)setTotalSeconds:(NSInteger)totalSeconds {
    _totalSeconds = totalSeconds;
    _remainingSeconds = totalSeconds;
}
@end
