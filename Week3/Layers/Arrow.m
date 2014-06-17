//
//  Arrow.m
//  Layers
//
//  Created by Victor Baro on 10/06/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "Arrow.h"

@implementation Arrow

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.0];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath* p = [UIBezierPath bezierPath];
    [p moveToPoint:CGPointMake(20,100)];
    [p addLineToPoint:CGPointMake(20, 19)];
    [p setLineWidth:20];
    [p stroke];
    // point of the arrow
    [[UIColor flatAlizarinColor] set];
    [p removeAllPoints];
    [p moveToPoint:CGPointMake(0,25)];
    [p addLineToPoint:CGPointMake(20, 0)];
    [p addLineToPoint:CGPointMake(40, 25)];
    [p fill];
    // snip out triangle in the tail
    [p removeAllPoints];
    [p moveToPoint:CGPointMake(10,101)];
    [p addLineToPoint:CGPointMake(20, 90)];
    [p addLineToPoint:CGPointMake(30, 101)];
    [p fillWithBlendMode:kCGBlendModeClear alpha:1.0];
}


@end
