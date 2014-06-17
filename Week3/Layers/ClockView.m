//
//  ClockView.m
//  Layers
//
//  Created by Victor Baro on 10/06/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "ClockView.h"
#import "Arrow.h"

@interface ClockView () {
        CGPoint _prevTouch;
}

@property (nonatomic, strong) Arrow *arrowView;

@end

@implementation ClockView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        [self addArrow];
        [self addBottomLabel];
    }
    return self;
}


- (void) addArrow {
    self.arrowView = [[Arrow alloc]initWithFrame:CGRectMake(0, 0, 40, 100)];
    //self.arrowView.center = self.center;
    self.arrowView.layer.anchorPoint = CGPointMake(0.5, 1);
    self.arrowView.layer.position = self.center;
    [self addSubview:self.arrowView];
}

- (void) addBottomLabel {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0,
                                                              self.frame.size.height - 150,
                                                              self.frame.size.width,
                                                              150)];
    label.text = @"Drag your finger sideways to rotate the arrow";
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    
}

#pragma mark -
#pragma mark touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    _prevTouch = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentTouch = [touch locationInView:self];
    CGFloat amount = currentTouch.x - _prevTouch.x;
    
    self.arrowView.layer.transform = CATransform3DRotate(self.arrowView.layer.transform,
                                                         M_PI_4 * amount * 0.05,
                                                         0, 0, 1);
    
    //[self setNeedsDisplay];
    _prevTouch = currentTouch;
    
}

#pragma mark -
#pragma mark drawing

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGFloat size = 200;
    UIBezierPath *bPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.center.x - size/2,
                                                                            self.center.y - size/2,
                                                                            size, size)];
    [[UIColor flatOrangeColor]setStroke];
    bPath.lineWidth = 3;
    [bPath stroke];
    [[UIColor flatSunFlowerColor]setFill];
    [bPath fill];
    
    CGFloat rOut = 99;
    CGFloat rInt = 90;
    NSUInteger dashLines = 60;
    
    for (int i=0; i<dashLines; i++) {
        UIBezierPath *line = [UIBezierPath bezierPath];
        CGFloat angle = 2 * M_PI * i / dashLines;
        CGPoint intPoint = CGPointMake(rInt * cosf(angle), rInt * sinf(angle));
        CGPoint extPoint = CGPointMake(rOut * cosf(angle), rOut * sinf(angle));
        [line moveToPoint:CGPointMake(self.center.x + intPoint.x, self.center.y + intPoint.y)];
        [line addLineToPoint:CGPointMake(self.center.x + extPoint.x, self.center.y + extPoint.y)];

        line.lineWidth = 1.0;
        
        [line stroke];
    }
}


@end
