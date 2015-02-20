//
//  ViewController.m
//  Layers
//
//  Created by Victor Baro on 09/06/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "GenericLayersVC.h"
#import "ClockView.h"
#import "SignalView.h"
#import "CATransformLayerExample.h"

@interface GenericLayersVC ()

@end

@implementation GenericLayersVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    switch (self.exampleNumber) {
        case 0:
            [self drawLayers];
            break;
        case 1:
            [self clockExample];
            break;
        case 3:
            [self specialLayersExample];
            break;
        case 4:
            [self simpleTransform];
            break;
        case 5:
            [self CATransformLayer];
            break;
        case 6:
            [self emmitterLayerExample];
            break;
        default:
            break;
    }

    
}

#pragma mark -
#pragma mark Example1

- (void) drawLayers {
    CALayer* lay1 = [CALayer new];
    lay1.frame = CGRectMake(113, 111, 132, 194);
    lay1.backgroundColor =
    [[UIColor colorWithRed:1 green:.4 blue:1 alpha:1] CGColor];
    [self.view.layer addSublayer:lay1];
    
    CALayer* lay2 = [CALayer new];
    lay2.backgroundColor =
    [[UIColor colorWithRed:.5 green:1 blue:0 alpha:1] CGColor];
    lay2.frame = CGRectMake(41, 56, 132, 194);
    [lay1 addSublayer:lay2];
    
    /*
    UIImageView* iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon-60"]];
    CGRect r = iv.frame;
    r.origin = CGPointMake(180,180);
    iv.frame = r;
    [self.view addSubview:iv];
    */
    
    CALayer* lay3 = [CALayer new];
    lay3.backgroundColor =
    [[UIColor colorWithRed:1 green:0 blue:0 alpha:1] CGColor];
    lay3.frame = CGRectMake(43, 197, 160, 230);
    [self.view.layer addSublayer:lay3];
    
    CALayer* lay4 = [CALayer new];
    UIImage* im = [UIImage imageNamed:@"Icon-60"];
    CGRect r;
    r.origin = CGPointMake(100,200);
    r.size = im.size;
    lay4.frame = r;
    lay4.contents = (id)im.CGImage;
    //lay4.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5].CGColor;

    [self.view.layer addSublayer:lay4];
    
    /*
    //lay4.contentsGravity = kCAGravityResizeAspect;
    lay4.contentsCenter = CGRectMake(0, 0.3, 1, 0.4);
    lay4.bounds = CGRectInset(lay4.bounds, -2, -20);
    */
}

#pragma mark -
#pragma mark Clock example

- (void) clockExample {
    ClockView *clock = [[ClockView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:clock];
}

#pragma mark -
#pragma mark Special Layers

- (void) specialLayersExample {
    [self.view.layer addSublayer:[self gradientLayer]];
    [self.view.layer addSublayer:[self textLayer]];
    [self.view.layer addSublayer:[self shapeLayer]];
}

- (CATextLayer *) textLayer {
    CATextLayer *tLayer = [CATextLayer layer];
    tLayer.bounds = CGRectMake(0.0f, 0.0f, 220.0f, 100.0f);
    tLayer.string = @"I am a CATextLayer";
    tLayer.foregroundColor = [UIColor flatBelizeHoleColor].CGColor;
    tLayer.backgroundColor = [UIColor flatCloudsColor].CGColor;
    tLayer.alignmentMode = kCAAlignmentCenter;
    tLayer.font = (__bridge CFTypeRef)([UIFont boldSystemFontOfSize:14].fontName);
    tLayer.position = CGPointMake(self.view.center.x, self.view.center.y - 100);
    tLayer.wrapped = YES;
    
    return tLayer;
}

- (CAShapeLayer *) shapeLayer {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.bounds = CGRectMake(0, 0, 200, 200);
    shapeLayer.path = [self heartPath].CGPath;
    shapeLayer.fillColor = [UIColor flatAlizarinColor].CGColor;
    shapeLayer.strokeColor = [UIColor flatPomegranateColor].CGColor;
    shapeLayer.position = CGPointMake(self.view.center.x, self.view.center.y + 150);

    return shapeLayer;
}

- (UIBezierPath *) heartPath {
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(101.5, 69.5)];
    [bezierPath addCurveToPoint: CGPointMake(147.5, 25.5) controlPoint1: CGPointMake(101.5, 69.5) controlPoint2: CGPointMake(109.3, 25.11)];
    [bezierPath addCurveToPoint: CGPointMake(171.5, 101.5) controlPoint1: CGPointMake(185.7, 25.89) controlPoint2: CGPointMake(191.46, 70.58)];
    [bezierPath addCurveToPoint: CGPointMake(101.5, 175.5) controlPoint1: CGPointMake(151.54, 132.42) controlPoint2: CGPointMake(101.5, 175.5)];
    [bezierPath addCurveToPoint: CGPointMake(25.5, 101.5) controlPoint1: CGPointMake(101.5, 175.5) controlPoint2: CGPointMake(39.36, 129.72)];
    [bezierPath addCurveToPoint: CGPointMake(52.5, 25.5) controlPoint1: CGPointMake(11.64, 73.28) controlPoint2: CGPointMake(14, 26.35)];
    [bezierPath addCurveToPoint: CGPointMake(101.5, 69.5) controlPoint1: CGPointMake(91, 24.65) controlPoint2: CGPointMake(101.5, 69.5)];
    [bezierPath closePath];
    return bezierPath;
}

- (CAGradientLayer *) gradientLayer {
    CAGradientLayer *gLayer = [CAGradientLayer layer];
    gLayer.colors = @[(id)[UIColor flatSunFlowerColor].CGColor,
                      (id)[UIColor flatOrangeColor].CGColor];
    gLayer.locations = @[@0.0,
                         @1.0];
    gLayer.bounds = self.view.bounds;
    gLayer.startPoint = CGPointMake(0, 0);
    gLayer.endPoint = CGPointMake(0, 1);
    
    gLayer.position = CGPointMake(self.view.center.x, self.view.center.y);
    
    return gLayer;
}


#pragma mark -
#pragma mark Simple transform

- (void) simpleTransform {
    SignalView *signal = [[SignalView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    signal.center = CGPointMake(self.view.center.x, self.view.center.y + 150);
    [self.view addSubview:signal];
    
    signal.layer.anchorPoint = CGPointMake(0.5, 1);
    /*
    signal.layer.transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    */
    
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0 / -500;
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, M_PI_4, 0.0f, 1.0f, 0.0f);

    signal.layer.transform = rotationAndPerspectiveTransform;
    
}




#pragma mark -
#pragma mark CATransformLayer Example

- (void) CATransformLayer {
    CATransformLayerExample *trans = [[CATransformLayerExample alloc]initWithFrame:self.view.bounds];
    trans.center = self.view.center;
    [self.view addSubview:trans];
}

#pragma mark -  Emitter layer

- (void)emmitterLayerExample {
    CAEmitterLayer *emitterLayer = [self createEmitterLayer];
    emitterLayer.position = self.view.center;
    emitterLayer.emitterCells = @[[self createEmitterCell]];
    [self.view.layer addSublayer:emitterLayer];
}

- (CAEmitterLayer *)createEmitterLayer {
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    emitterLayer.frame = CGRectMake(0, 0, 300, 300);
    emitterLayer.renderMode = kCAEmitterLayerAdditive;
    emitterLayer.drawsAsynchronously = true;
    emitterLayer.emitterPosition = CGPointMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    return emitterLayer;
}

- (CAEmitterCell *)createEmitterCell {
    CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
    emitterCell.contents = [UIImage imageNamed:@"star"].CIImage;
    
    emitterCell.velocity = 50.0;
    emitterCell.velocityRange = 500.0;
    
    emitterCell.color = [UIColor blackColor].CGColor;
    emitterCell.redRange = 1.0;
    emitterCell.greenRange = 1.0;
    emitterCell.blueRange = 1.0;
    emitterCell.alphaRange = 0.0;
    emitterCell.redSpeed = 0.0;
    emitterCell.greenSpeed = 0.0;
    emitterCell.blueSpeed = 0.0;
    emitterCell.alphaSpeed = -0.5;
    

    emitterCell.spin = M_PI * 0.8;
    emitterCell.spinRange = 0.0;
    emitterCell.emissionRange = 2*M_PI;
    
    emitterCell.lifetime = 1.0;
    emitterCell.birthRate = 250.0;
    emitterCell.xAcceleration = -800.0;
    emitterCell.yAcceleration = 1000.0;
    return emitterCell;
}
@end
