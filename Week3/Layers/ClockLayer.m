//
//  ClockLayer.m
//  Layers
//
//  Created by Victor Baro on 11/06/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "ClockLayer.h"

@implementation ClockLayer

+ (id)layer {
    CAShapeLayer *mainLayer = [CAShapeLayer layer];
    mainLayer.bounds = CGRectMake(0, 0, 200, 200);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 200, 200)];
    mainLayer.path = path.CGPath;
    mainLayer.fillColor = [UIColor flatCloudsColor].CGColor;
    mainLayer.strokeColor = [UIColor flatConcreteColor].CGColor;
    
    CGFloat rOut = 99;
    CGFloat rInt = 90;
    NSUInteger dashLines = 60;
    CGPoint center = CGPointMake(mainLayer.bounds.size.width/2, mainLayer.bounds.size.height/2);
    
    for (int i=0; i<dashLines; i++) {
        UIBezierPath *line = [UIBezierPath bezierPath];
        CGFloat angle = 2 * M_PI * i / dashLines;
        CGPoint intPoint = CGPointMake(rInt * cosf(angle), rInt * sinf(angle));
        CGPoint extPoint = CGPointMake(rOut * cosf(angle), rOut * sinf(angle));
        [line moveToPoint:CGPointMake(center.x + intPoint.x, center.y + intPoint.y)];
        [line addLineToPoint:CGPointMake(center.x + extPoint.x, center.y + extPoint.y)];
        
        CAShapeLayer *lineShape = [CAShapeLayer layer];
        lineShape.path = line.CGPath;
        lineShape.strokeColor = [UIColor flatConcreteColor].CGColor;
        [mainLayer addSublayer:lineShape];
    }
    
    return mainLayer;
}




@end
