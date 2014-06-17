//
//  bFace.m
//  Week3
//
//  Created by Victor Baro on 17/06/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "bFace.h"

@interface bFace () {
    CGPoint _midMouth;
    CGPoint _prevTouch;
}

@end

@implementation bFace

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        _midMouth = CGPointMake(self.center.x, self.center.y + 100);
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
    //Change moving points
    _midMouth = CGPointMake(_midMouth.x, _midMouth.y + amount);
    
    //Don't call 'DrawRect:' to redraw, call setNeedsDisplay
    [self setNeedsDisplay];
    _prevTouch = currentTouch;

}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGRect fullRect = self.frame;
    
    UIBezierPath *outFace = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(fullRect, 40, 160)];

    
    UIBezierPath *leftEye = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.center.x - 100,self.center.y - 40, 25, 25)];
    [outFace appendPath:leftEye];
    
    UIBezierPath *rightEye = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x + 30, self.center.y - 40) radius:12 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    [outFace appendPath:rightEye];
    
    [[UIColor redColor]setStroke];
    outFace.lineWidth = 3.0;
    [outFace stroke];
    
    UIBezierPath *mouth = [UIBezierPath bezierPath];
    [mouth moveToPoint:CGPointMake(self.center.x - 100, self.center.y + 30)];
    [mouth addQuadCurveToPoint:CGPointMake(self.center.x + 100, self.center.y + 30) controlPoint:_midMouth];
    [[UIColor blueColor]setStroke];
    mouth.lineWidth = 5;
    [mouth stroke];
    [mouth fill];
}


@end
