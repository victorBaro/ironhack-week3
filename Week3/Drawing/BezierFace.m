//
//  BezierFace.m
//  Drawing
//
//  Created by Victor Baro on 07/06/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "BezierFace.h"

@interface BezierFace () {
    CGPoint _midMouth;
    CGPoint _prevTouch;
    CGPoint _leftEyeBrowMov;
    CGPoint _rightEyeBrowMov;
}

@end

@implementation BezierFace

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
        //Set initial values for 'moving' points
        _midMouth = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 100);
        _leftEyeBrowMov = CGPointMake(CGRectGetMidX(self.frame) - 30, CGRectGetMidY(self.frame) - 70);
        _rightEyeBrowMov = CGPointMake(CGRectGetMidX(self.frame) + 30, CGRectGetMidY(self.frame) - 70);
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    _prevTouch = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentTouch = [touch locationInView:self];
    CGFloat amount = currentTouch.y - _prevTouch.y;
    if ((_midMouth.y + amount <= 400)&&(_midMouth.y + amount >= 250)) {
        //Change moving points
        _midMouth = CGPointMake(_midMouth.x, _midMouth.y + amount);
        _leftEyeBrowMov = CGPointMake(_leftEyeBrowMov.x, _leftEyeBrowMov.y - (amount * 0.2));
        _rightEyeBrowMov = CGPointMake(_rightEyeBrowMov.x, _leftEyeBrowMov.y);
        
        //Don't call 'DrawRect:' to redraw, call setNeedsDisplay
        [self setNeedsDisplay];
    }
    _prevTouch = currentTouch;
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGRect fullRect = self.frame;

    
    // Establish a new path
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    /*
    CGFloat dashes[] = {6, 2};
    [bezierPath setLineDash:dashes count:2 phase:0];
    */
    
    // Create the face outline and append it to the path
    CGRect inset = CGRectInset(fullRect, 40, 160);
    UIBezierPath *faceOutline = [UIBezierPath bezierPathWithOvalInRect:inset];
    [bezierPath appendPath:faceOutline];
    
    //Create the mouth using 3 points (will use the middle point to move it)
    //We already have the midPoint, let's create the other 2
    CGPoint mouthLeft = CGPointMake(CGRectGetMidX(self.frame) - 60, CGRectGetMidY(self.frame) + 30);
    CGPoint mouthRight = CGPointMake(CGRectGetMidX(self.frame) + 60, CGRectGetMidY(self.frame) + 30);
    
    [bezierPath moveToPoint:mouthLeft];
    [bezierPath addQuadCurveToPoint:mouthRight controlPoint:_midMouth];

    
    //Create eyes
    CGPoint leftEye = CGPointMake(CGRectGetMidX(self.frame) - 50, CGRectGetMidY(self.frame) - 30);
    CGPoint rightEye = CGPointMake(CGRectGetMidX(self.frame) + 50, CGRectGetMidY(self.frame) - 30);

    CGFloat radius = 15;
    [bezierPath moveToPoint:CGPointMake(leftEye.x + radius, leftEye.y)];
    [bezierPath addArcWithCenter:leftEye
                          radius:radius
                      startAngle:0
                        endAngle:2*M_PI
                       clockwise:YES];
    [bezierPath moveToPoint:CGPointMake(rightEye.x + radius, rightEye.y)];
    [bezierPath addArcWithCenter:rightEye
                          radius:radius
                      startAngle:0
                        endAngle:2*M_PI
                       clockwise:YES];
    
    //Create Eyebrows
    CGPoint leftEyebrowFixed = CGPointMake(CGRectGetMidX(self.frame) - 70, CGRectGetMidY(self.frame) - 50);
    [bezierPath moveToPoint:_leftEyeBrowMov];
    [bezierPath addLineToPoint:leftEyebrowFixed];
    
    CGPoint rightEyebrowFixed = CGPointMake(CGRectGetMidX(self.frame) + 70, CGRectGetMidY(self.frame) - 50);
    [bezierPath moveToPoint:_rightEyeBrowMov];
    [bezierPath addLineToPoint:rightEyebrowFixed];
    
    
    // Draw the complete path
    [[UIColor blueColor] setStroke];
    bezierPath.lineWidth = 2;
    [bezierPath stroke];
}

@end
