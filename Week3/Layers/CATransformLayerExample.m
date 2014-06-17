//
//  CATransformLayerExample.m
//  Layers
//
//  Created by Victor Baro on 11/06/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "CATransformLayerExample.h"
#import "ClockLayer.h"
#import "Arrow.h"

@interface CATransformLayerExample () {
    CGPoint _prevTouch;
    BOOL _moveArrow;
}
@property (nonatomic, strong) Arrow *arrow;
@end

@implementation CATransformLayerExample

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSublayers];
        [self applyTransforms];
        [self addButtons];
        _moveArrow = YES;
    }
    return self;
}

+ (Class) layerClass {
    //This method is telling CATansformLayerExample class that his 'Underlying layer' is not a CALayer but a CATransformLayer
    return [CATransformLayer class];
}

- (void) addSublayers {
    [self.layer addSublayer:[self backgroundLayer]];
    [self.layer addSublayer:[self clockLayer]];
    [self.layer addSublayer:[self arrowLayer]];
}

- (CAGradientLayer *) backgroundLayer {
    CAGradientLayer *gL = [CAGradientLayer layer];
    gL.colors = @[(id)[UIColor flatPeterRiverColor].CGColor,
                  (id)[UIColor flatMidnightBlueColor].CGColor];
    gL.locations = @[@0.0,@1.0];
    gL.bounds = CGRectMake(0, 0, 200, 200);
    gL.position = self.center;
    gL.zPosition = 0;
    return gL;
}

- (CAShapeLayer *) clockLayer {
    ClockLayer *clock = [ClockLayer layer];
    clock.position = self.center;
    clock.zPosition = 10;
    return clock;
}

- (CALayer *) arrowLayer {
    self.arrow = [[Arrow alloc]initWithFrame:CGRectMake(0, 0, 40, 100)];
    self.arrow.layer.anchorPoint = CGPointMake(0.5, 1);
    self.arrow.layer.position = self.center;
    [self addSubview:self.arrow];
    self.arrow.layer.zPosition = 20;
    self.arrow.layer.shadowOpacity = 1.0;
    self.arrow.layer.shadowRadius = 8;
    self.arrow.layer.shadowOffset = CGSizeMake(0, 10);
    return self.arrow.layer;
}

- (void) applyTransforms {
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0 / -500;
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, M_PI_4, 0.0f, 1.0f, 0.0f);
    
    self.layer.transform = rotationAndPerspectiveTransform;
}

- (void) addButtons {
    UIButton *b1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [b1 setTitle:@"Move arrow" forState:UIControlStateNormal];
    b1.frame = CGRectMake(30, self.bounds.size.height -150,
                          100,
                          40);
    [b1 addTarget:self
           action:@selector(moveArrowPressed:)
 forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:b1];
    
    
    UIButton *b2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [b2 setTitle:@"3D Rotate" forState:UIControlStateNormal];
    b2.frame = CGRectMake(150, self.bounds.size.height - 150,
                          100,
                          40);
    [b2 addTarget:self
           action:@selector(changePerspPressed:)
 forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:b2];
    
}

#pragma mark -
#pragma mark Button actions

- (void) moveArrowPressed:(UIButton *)sender {
    _moveArrow = YES;
}

- (void) changePerspPressed:(UIButton *)sender {
    _moveArrow = NO;
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
    
    if (_moveArrow) {
        self.arrow.layer.transform = CATransform3DRotate(self.arrow.layer.transform,
                                                         M_PI_4 * amount * 0.05,
                                                         0, 0, 1);
    } else {
        if (self.layer.transform.m11 + M_PI_4 * amount * 0.005 > 0.5) {
            CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
            rotationAndPerspectiveTransform.m34 = 1.0 / -500;
            rotationAndPerspectiveTransform = CATransform3DRotate(self.layer.transform, M_PI_4 * amount * 0.005, 0.0f, 1.0f, 0.0f);
            
            self.layer.transform = rotationAndPerspectiveTransform;
        }

    }
    _prevTouch = currentTouch;
}



@end
