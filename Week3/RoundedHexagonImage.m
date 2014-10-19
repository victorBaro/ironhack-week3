//
//  RoundedHexagonImage.m
//  Week3
//
//  Created by Victor Baro on 19/10/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "RoundedHexagonImage.h"
#import "POP.h"


@interface RoundedHexagonImage ()
@property (nonatomic, strong) UIImageView *hexagonImageView;
@property (nonatomic) BOOL flipped;
@end

@implementation RoundedHexagonImage

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonSetup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonSetup];
    }
    return self;
}

- (void)layoutSubviews {
    if (!self.hexagonImageView) {
        self.hexagonImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        self.hexagonImageView.image = [UIImage imageNamed:@"Logo_noLetters"];
        [self addSubview:self.hexagonImageView];
        [self sendSubviewToBack:self.hexagonImageView];
        CGFloat delay = (CGFloat)self.tag/10;
        [self animateHexagonEntranceWithDelay:delay];
        self.myTitle.hidden = YES;
        self.flipped = NO;
    }
}

- (void) commonSetup{
    self.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hexagonTouched:)];
    [self addGestureRecognizer:tap];
}

- (void) animateHexagonEntranceWithDelay:(CGFloat)delay {
    CGSize currentSize = self.hexagonImageView.bounds.size;
    self.hexagonImageView.bounds = CGRectZero;
    POPSpringAnimation *sizeAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewSize];
    sizeAnim.beginTime = CACurrentMediaTime() + delay;
    sizeAnim.toValue = [NSValue valueWithCGSize:currentSize];
    sizeAnim.springBounciness = 5;
    sizeAnim.springSpeed = 5;
    [self.hexagonImageView pop_addAnimation:sizeAnim forKey:@"scaleView"];
}

- (void) animateRotationToTitleWithDelay:(CGFloat)delay{
    [self performSelector:@selector(flipAnimation) withObject:nil afterDelay:delay];
}

- (void) flipAnimation {
    [UIView transitionWithView:self
                      duration:0.6
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        if (!self.flipped) {
                            self.myTitle.hidden = NO;
                            self.flipped = YES;
                        } else {
                            self.myTitle.hidden = YES;
                            self.flipped = NO;
                        }
                        
                    } completion:nil];
}

- (void) hexagonTouched:(UITapGestureRecognizer *)gr {
    [self.delegate hexagonPressed:self.tag];
}

- (UIImage *) hexagonWithFrame:(CGRect)frame {
    
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0);
    
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 0.22 green: 0.506 blue: 0.722 alpha: 1];
    
    //// Polygon Drawing
    UIBezierPath* polygonPath = UIBezierPath.bezierPath;
    [polygonPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.04527 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21686 * CGRectGetHeight(frame))];
    [polygonPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.41146 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.02582 * CGRectGetHeight(frame))];
    [polygonPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50086 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.41146 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.02582 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.45559 * CGRectGetWidth(frame), CGRectGetMinY(frame) + -0.00029 * CGRectGetHeight(frame))];
    [polygonPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.59254 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.02700 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.54613 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00030 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.59254 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.02700 * CGRectGetHeight(frame))];
    [polygonPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.92455 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.20022 * CGRectGetHeight(frame))];
    [polygonPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.97845 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.25000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.92455 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.20022 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.95959 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21668 * CGRectGetHeight(frame))];
    [polygonPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.33351 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.99732 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28332 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.33351 * CGRectGetHeight(frame))];
    [polygonPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.67295 * CGRectGetHeight(frame))];
    [polygonPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.97845 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.67295 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.99627 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.71884 * CGRectGetHeight(frame))];
    [polygonPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.92875 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.79759 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.96064 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78116 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.92875 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.79759 * CGRectGetHeight(frame))];
    [polygonPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.58711 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97583 * CGRectGetHeight(frame))];
    [polygonPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50086 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.99999 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.58711 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97583 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.54482 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00043 * CGRectGetHeight(frame))];
    [polygonPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.41127 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97409 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.45690 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.99956 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.41127 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97409 * CGRectGetHeight(frame))];
    [polygonPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.05666 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78908 * CGRectGetHeight(frame))];
    [polygonPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.01250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.05666 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78908 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.02623 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77243 * CGRectGetHeight(frame))];
    [polygonPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00172 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.69933 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + -0.00124 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.72756 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.00172 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.69933 * CGRectGetHeight(frame))];
    [polygonPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00172 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28426 * CGRectGetHeight(frame))];
    [polygonPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.01250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.25000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.00172 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28426 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.00161 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26685 * CGRectGetHeight(frame))];
    [polygonPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.04527 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21686 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.02339 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23315 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.04527 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21686 * CGRectGetHeight(frame))];
    [polygonPath closePath];
    [color setFill];
    [polygonPath fill];
    
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return im;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
