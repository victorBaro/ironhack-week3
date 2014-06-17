//
//  HexagonsDrawingView.m
//  Week3
//
//  Created by Victor Baro on 15/06/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "HexagonsDrawingView.h"
#import "HexagonButton.h"

@implementation HexagonsDrawingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        [self animateDrawing];
    }
    return self;
}



- (void) animateDrawing {
    UIColor *lineColor = [UIColor colorWithRed: 0.231 green: 0.478 blue: 0.859 alpha: 0.8];
    
    CAShapeLayer *line1 = [CAShapeLayer layer];
    line1.path = [self bezier1].CGPath;
    line1.strokeEnd = 0.0;
    line1.strokeColor = lineColor.CGColor;
    line1.fillColor = [UIColor clearColor].CGColor;
    
    [self.layer addSublayer:line1];
    
    CAShapeLayer *line2 = [CAShapeLayer layer];
    line2.path = [self bezier2].CGPath;
    line2.strokeEnd = 0.0;
    line2.strokeColor = lineColor.CGColor;
    line2.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:line2];
    
    
    CGFloat totalTime = 2.0;
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anim.duration = totalTime;
    anim.fromValue = [NSNumber numberWithFloat:0.0f];
    anim.toValue = [NSNumber numberWithFloat:1.0f];
    anim.delegate = self;
    [line1 addAnimation:anim forKey:@"strokeEndAnimation"];
    [line2 addAnimation:anim forKey:@"strokeEndAnimation"];
    
    CGFloat delay = 0.7;
    CABasicAnimation *anim2 = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    anim2.duration = totalTime - delay;
    anim.fromValue = [NSNumber numberWithFloat:0.0f];
    anim2.toValue = [NSNumber numberWithFloat:0.5f];
    anim2.beginTime = CACurrentMediaTime() + delay;
    anim2.fillMode = kCAFillModeForwards;
    anim2.removedOnCompletion = NO;
    [line1 addAnimation:anim2 forKey:@"strokeStartAnimation"];
    [line2 addAnimation:anim2 forKey:@"strokeStartAnimation"];
    
}




- (UIBezierPath *) bezier1 {
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(203.5, 215.5)];
    [bezierPath addLineToPoint: CGPointMake(160.5, 190.5)];
    [bezierPath addLineToPoint: CGPointMake(116.5, 215.5)];
    [bezierPath addLineToPoint: CGPointMake(116.5, 411.5)];
    [bezierPath addLineToPoint: CGPointMake(160.5, 436.5)];
    [bezierPath addLineToPoint: CGPointMake(203.5, 411.5)];
    [bezierPath addLineToPoint: CGPointMake(203.5, 361.5)];
    [bezierPath addLineToPoint: CGPointMake(160.5, 336.5)];
    [bezierPath addLineToPoint: CGPointMake(117.5, 360.5)];
    
    return bezierPath;
}


- (UIBezierPath *) bezier2 {
    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint: CGPointMake(117.5, 265.5)];
    [bezier2Path addLineToPoint: CGPointMake(160.5, 290.5)];
    [bezier2Path addLineToPoint: CGPointMake(203.5, 264.5)];
    [bezier2Path addLineToPoint: CGPointMake(203.5, 78.5)];
    [bezier2Path addLineToPoint: CGPointMake(159.5, 52.5)];
    [bezier2Path addLineToPoint: CGPointMake(116.5, 78.5)];
    [bezier2Path addLineToPoint: CGPointMake(116.5, 127.5)];
    [bezier2Path addLineToPoint: CGPointMake(159.5, 152.5)];
    [bezier2Path addLineToPoint: CGPointMake(202.5, 128.5)];

    return bezier2Path;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    //// Color Declarations

    
    
}
*/


@end
