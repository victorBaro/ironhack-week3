//
//  SignalView.m
//  Layers
//
//  Created by Victor Baro on 11/06/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "SignalView.h"

@implementation SignalView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        [self addSublayers];
    }
    return self;
}

- (void) addSublayers {
    [self.layer addSublayer:[self stick]];
    [self.layer addSublayer:[self mainSignal]];
    [self.layer addSublayer:[self signalText]];
}

- (CAShapeLayer *) mainSignal {
    CAShapeLayer *signal = [CAShapeLayer layer];
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(43.5, 143.5)];
    [bezierPath addLineToPoint: CGPointMake(81.5, 92.5)];
    [bezierPath addLineToPoint: CGPointMake(265.5, 92.5)];
    [bezierPath addLineToPoint: CGPointMake(251.5, 143.5)];
    [bezierPath addLineToPoint: CGPointMake(265.5, 188.5)];
    [bezierPath addLineToPoint: CGPointMake(81.5, 188.5)];
    [bezierPath addLineToPoint: CGPointMake(43.5, 143.5)];
    [bezierPath closePath];
    signal.path = bezierPath.CGPath;
    signal.fillColor = [UIColor flatEmeraldColor].CGColor;
    signal.strokeColor = [UIColor flatNephritisColor].CGColor;
    return signal;
}

- (CAGradientLayer *) stick {
    CAGradientLayer *gLayer = [CAGradientLayer layer];
    gLayer.colors = @[(id)[UIColor flatSilverColor].CGColor,
                      (id)[UIColor flatCloudsColor].CGColor,
                      (id)[UIColor flatSilverColor].CGColor];
    gLayer.locations = @[@0.0,
                        @0.5,
                        @1.0];
    gLayer.startPoint = CGPointMake(0, 0);
    gLayer.endPoint = CGPointMake(1, 0);
    
    gLayer.frame = CGRectMake(148, 189, 14, 121);
    
    return gLayer;
                      
}

- (CATextLayer *) signalText {
    CATextLayer *tLayer = [CATextLayer layer];
    tLayer.frame = CGRectMake(87, 119, 155, 55);
    tLayer.string = @"Direction";
    tLayer.foregroundColor = [UIColor whiteColor].CGColor;
    return tLayer;
}

@end
