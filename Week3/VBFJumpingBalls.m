//
//  VBFRotatingBalls.m
//  VBFFlatLoaders
//
//  Created by Victor Baro on 16/09/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "VBFJumpingBalls.h"
#import "pop.h"

@interface VBFJumpingBalls ()
@property (nonatomic, strong) NSArray *balls;
@end

@implementation VBFJumpingBalls

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self commonSetup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonSetup];
    }
    return self;
}

- (void) commonSetup {
    self.backgroundColor = [UIColor clearColor];
    self.nBalls = 6;
    _diameter = 15;
    _ballColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    _balls = [self createBalls];
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapped:)];
    [self addGestureRecognizer:gr];
}

- (void) viewTapped:(UITapGestureRecognizer *)tap {
    int i = 0;
    for (UIView *ball in _balls) {
        [self addAdnimationToBall:ball withDelay:0.3*i type:1 amount:6];
        i++;
    }
}

- (NSArray *) createBalls {
    NSMutableArray *tempArray = [[NSMutableArray alloc]initWithCapacity:self.nBalls];
    for (int i=0; i<self.nBalls; i++) {
        UIView *ball = [[UIView alloc]initWithFrame:CGRectMake(self.center.x + 20*(i-3),
                                                               self.center.y,
                                                               _diameter,
                                                               _diameter)];
        ball.backgroundColor = _ballColor;
        ball.layer.cornerRadius = _diameter/2;
        ball.layer.borderColor = [UIColor whiteColor].CGColor;
        ball.layer.borderWidth = 1.0f;
        [self addSubview:ball];
        [tempArray addObject:ball];
    }
    return tempArray;
}

#pragma mark -
#pragma mark setters
- (void)setDiameter:(CGFloat)diameter {
    _diameter = diameter;
    self.balls = [self createBalls];
}

- (void)setBallColor:(UIColor *)ballColor {
    _ballColor = ballColor;
    if (self.balls) {
        for (UIView *ball in self.balls) {
            ball.backgroundColor = ballColor;
        }
    } else {
        self.balls = [self createBalls];
    }

}

- (void)setNBalls:(NSInteger)nBalls {
    _nBalls = nBalls;
    self.balls = [self createBalls];
}


#pragma mark -
#pragma mark animations

- (void) addAdnimationToBall:(UIView *)ball withDelay:(CGFloat)delay type:(NSInteger)type amount:(CGFloat)amount{
    switch (type) {
        case 0: {
            CAKeyframeAnimation *trans = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
            CGFloat currentY = ball.layer.position.y;
            trans.values = @[@(currentY), @(currentY - 15), @(currentY)];
            trans.keyTimes = @[@0.0, @0.5, @1.0];
            trans.duration = 0.3;
            trans.beginTime = CACurrentMediaTime() + delay;
            
            trans.calculationMode = kCAAnimationCubic;
            trans.tensionValues = @[@(-amount),@0.0,@(amount)];
            
            [ball.layer addAnimation:trans forKey:@"rotation"];
            
        }
            break;
        case 1: {
            CAKeyframeAnimation *trans = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
            CGFloat currentX = ball.layer.position.y;
            trans.values = @[@(currentX), @(currentX - 15), @(currentX)];
            trans.keyTimes = @[@0.0, @0.5, @1.0];
            trans.duration = 0.45;
            trans.beginTime = CACurrentMediaTime() + delay;
            
            trans.calculationMode = kCAAnimationCubic;
            trans.tensionValues = @[@(amount/1.5),@0.0,@(-amount)];
            
            [ball.layer addAnimation:trans forKey:@"rotation"];
        }
            break;
        default:
            break;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
