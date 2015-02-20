//
//  AnimationCurveView.m
//  Week3
//
//  Created by Victor Baro on 22/10/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "AnimationCurveView.h"

@interface AnimationCurveView ()
@property (nonatomic) CGPoint initialPoint;
@property (nonatomic) CGPoint endPoint;
@property (nonatomic) CGPoint controlPoint1;
@property (nonatomic) CGPoint controlPoint2;
@property (nonatomic, readwrite) CGPoint resultPoint1;
@property (nonatomic, readwrite) CGPoint resultPoint2;
@end

@implementation AnimationCurveView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void) commonInit {
    self.backgroundColor = [UIColor clearColor];
    CGFloat xMid = CGRectGetWidth(self.bounds)/2;
    CGFloat yMid = CGRectGetWidth(self.bounds)/2;
//    CGFloat side = self.bounds.size.width * 0.8;
//    CGRect backgroundFrame = CGRectMake(xMid - side/2,
//                                        yMid - side/2,
//                                        side,
//                                        side);

    _controlPoint1 = CGPointMake(xMid,
                                 yMid + 30);
    
    _controlPoint2 = CGPointMake(xMid,
                                 yMid - 30);
}


- (void)setControlPoint1:(CGPoint)controlPoint1 {
    _controlPoint1 = controlPoint1;
    
    _resultPoint1 = CGPointMake((controlPoint1.x - self.initialPoint.x)/(self.endPoint.x - self.initialPoint.x),
                                (self.initialPoint.y - controlPoint1.y)/(self.initialPoint.y - self.endPoint.y));
    
}

- (void) setControlPoint2:(CGPoint)controlPoint2 {
    _controlPoint2 = controlPoint2;
    _resultPoint2 = CGPointMake((controlPoint2.x - self.initialPoint.x)/(self.endPoint.x - self.initialPoint.x),
                                (self.initialPoint.y - controlPoint2.y) /(self.initialPoint.y - self.endPoint.y));
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGFloat xMid = CGRectGetWidth(self.bounds)/2;
    CGFloat yMid = CGRectGetWidth(self.bounds)/2;

    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 0.933 green: 0.933 blue: 0.933 alpha: 1];
    
    CGFloat side = self.bounds.size.width * 0.6;
    CGRect backgroundFrame = CGRectMake(xMid - side/2,
                                        yMid - side/2,
                                        side,
                                        side);
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: backgroundFrame];
//    CGRectMake(CGRectGetMinX(rect) + floor(CGRectGetWidth(rect) * 0.03500) + 0.5, CGRectGetMinY(rect) + floor(CGRectGetHeight(rect) * 0.04500) + 0.5, floor(CGRectGetWidth(rect) * 0.95500) - floor(CGRectGetWidth(rect) * 0.03500), floor(CGRectGetHeight(rect) * 0.94500) - floor(CGRectGetHeight(rect) * 0.04500))
    [color setFill];
    [rectanglePath fill];
    [UIColor.blackColor setStroke];
    rectanglePath.lineWidth = 1;
    [rectanglePath stroke];
    
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = UIBezierPath.bezierPath;
    
    _initialPoint = CGPointMake(backgroundFrame.origin.x, backgroundFrame.origin.y + side);
    _endPoint = CGPointMake(backgroundFrame.origin.x + side, backgroundFrame.origin.y);
    
    [bezierPath moveToPoint:self.initialPoint];
    [bezierPath addCurveToPoint: self.endPoint
                  controlPoint1: self.controlPoint1
                  controlPoint2: self.controlPoint2];
    
    
    bezierPath.lineCapStyle = kCGLineCapRound;
    
    [UIColor.blackColor setStroke];
    bezierPath.lineWidth = 3;
    [bezierPath stroke];
    
    
    // Balls
    //// Subframes
    CGFloat radius = 15;
    CGRect ballFrame1 = CGRectMake(self.controlPoint1.x - radius,
                                   self.controlPoint1.y - radius,
                                   radius*2, radius*2);
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(ballFrame1) + floor(CGRectGetWidth(ballFrame1) * 0.05556) + 0.5,
                                                                                CGRectGetMinY(ballFrame1) + floor(CGRectGetHeight(ballFrame1) * 0.05556) + 0.5,
                                                                                floor(CGRectGetWidth(ballFrame1) * 0.94444) - floor(CGRectGetWidth(ballFrame1) * 0.05556),
                                                                                floor(CGRectGetHeight(ballFrame1) * 0.94444) - floor(CGRectGetHeight(ballFrame1) * 0.05556))];
    [UIColor.whiteColor setFill];
    [ovalPath fill];
    [[UIColor blackColor] setStroke];
    ovalPath.lineWidth = 1;
    [ovalPath stroke];
    
    
    //// Oval 2 Drawing
    UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(ballFrame1) + floor(CGRectGetWidth(ballFrame1) * 0.27778) + 0.5,
                                                                                 CGRectGetMinY(ballFrame1) + floor(CGRectGetHeight(ballFrame1) * 0.27778) + 0.5,
                                                                                 floor(CGRectGetWidth(ballFrame1) * 0.72222) - floor(CGRectGetWidth(ballFrame1) * 0.27778),
                                                                                 floor(CGRectGetHeight(ballFrame1) * 0.72222) - floor(CGRectGetHeight(ballFrame1) * 0.27778))];
    [[UIColor blackColor] setFill];
    [oval2Path fill];
    
    
    
    
    /////////////////
    //SENCOND BALL///
    ////////////////
    
    
    
    CGRect ballFrame2 = CGRectMake(self.controlPoint2.x - radius,
                                   self.controlPoint2.y - radius,
                                   radius*2, radius*2);
    //// Oval Drawing
    UIBezierPath* ovalPath2 = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(ballFrame2) + floor(CGRectGetWidth(ballFrame2) * 0.05556) + 0.5,
                                                                                CGRectGetMinY(ballFrame2) + floor(CGRectGetHeight(ballFrame2) * 0.05556) + 0.5,
                                                                                floor(CGRectGetWidth(ballFrame2) * 0.94444) - floor(CGRectGetWidth(ballFrame2) * 0.05556),
                                                                                floor(CGRectGetHeight(ballFrame2) * 0.94444) - floor(CGRectGetHeight(ballFrame2) * 0.05556))];
    [UIColor.whiteColor setFill];
    [ovalPath2 fill];
    [[UIColor blackColor] setStroke];
    ovalPath2.lineWidth = 1;
    [ovalPath2 stroke];
    
    
    //// Oval 2 Drawing
    UIBezierPath* oval2Path2 = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(ballFrame2) + floor(CGRectGetWidth(ballFrame2) * 0.27778) + 0.5,
                                                                                 CGRectGetMinY(ballFrame2) + floor(CGRectGetHeight(ballFrame2) * 0.27778) + 0.5,
                                                                                 floor(CGRectGetWidth(ballFrame2) * 0.72222) - floor(CGRectGetWidth(ballFrame2) * 0.27778),
                                                                                 floor(CGRectGetHeight(ballFrame2) * 0.72222) - floor(CGRectGetHeight(ballFrame2) * 0.27778))];
    [[UIColor blackColor] setFill];
    [oval2Path2 fill];
    
    
    
    UIBezierPath *line1 = [UIBezierPath bezierPath];
    [line1 moveToPoint:self.initialPoint];
    [line1 addLineToPoint:self.controlPoint1];
    line1.lineWidth = 1.0;
    [[UIColor blackColor] setStroke];
    [line1 stroke];
    
    
    UIBezierPath *line2 = [UIBezierPath bezierPath];
    [line2 moveToPoint:self.endPoint];
    [line2 addLineToPoint:self.controlPoint2];
    line2.lineWidth = 1.0;
    [[UIColor blackColor] setStroke];
    [line2 stroke];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    CGRect ballFrame1 = CGRectMake(self.controlPoint1.x - 20,
                                   self.controlPoint1.y - 20,
                                   40, 40);
    CGRect ballFrame2 = CGRectMake(self.controlPoint2.x - 20,
                                   self.controlPoint2.y - 20,
                                   40, 40);
    
    if (CGRectContainsPoint(ballFrame1, touchPoint)) {
        self.controlPoint1 = touchPoint;
        [self setNeedsDisplay];
    }else if (CGRectContainsPoint(ballFrame2, touchPoint)){
        self.controlPoint2 = touchPoint;
        [self setNeedsDisplay];
    }
}


@end
