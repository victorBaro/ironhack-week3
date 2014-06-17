//
//  CoreGraphicsExamplesVC.m
//  Drawing
//
//  Created by Victor Baro on 07/06/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "CoreGraphicsExamplesVC.h"

@interface CoreGraphicsExamplesVC () {
    BOOL _useComplexMask;
}
@property (nonatomic, strong) UIImageView *clipImgView;
@end

@implementation CoreGraphicsExamplesVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    switch (self.exampleNumber) {
        case 12:
            [self drawSimpleArrow];
            break;
        case 13:
            _useComplexMask = NO;
            [self useClipMask];
            break;
        case 14:
            [self gradientExample];
            break;
        case 15:
            [self patternExample];
            break;
        case 16:
            [self transformExample];
            break;
        case 17:
            [self shadowExample];
            break;
            
        default:
            break;
    }
}



#pragma mark -
#pragma mark Example draw arrow

- (void) drawSimpleArrow {
    //USING CORE GRAPHICS
    // create graphics context
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 150), NO, 0);
    CGContextRef con = UIGraphicsGetCurrentContext();
    // draw a black (by default) vertical line, the shaft of the arrow
    CGContextMoveToPoint(con, 100, 100);
    CGContextAddLineToPoint(con, 100, 19);
    CGContextSetLineWidth(con, 20);
    CGContextStrokePath(con);
    // draw a red triangle, the point of the arrow
    CGContextSetFillColorWithColor(con, [[UIColor redColor] CGColor]);
    CGContextMoveToPoint(con, 80, 25);
    CGContextAddLineToPoint(con, 100, 0);
    CGContextAddLineToPoint(con, 120, 25);
    CGContextFillPath(con);
    // snip a triangle out of the shaft by drawing in Clear blend mode
    CGContextMoveToPoint(con, 90, 101);
    CGContextAddLineToPoint(con, 100, 90);
    CGContextAddLineToPoint(con, 110, 101);
    CGContextSetBlendMode(con, kCGBlendModeClear);
    CGContextFillPath(con);
    
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imView = [[UIImageView alloc]initWithImage:im];
    imView.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
    [self.view addSubview:imView];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 100)];
    lab.text = @"Core Graphics";
    lab.center = CGPointMake(lab.center.x, imView.center.y);
    [self.view addSubview:lab];
    
    
    //SAME THING USING UIKIT AND BEZIER PATHS
    
    // create graphics context
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 150), NO, 0);
    // shaft of the arrow
    UIBezierPath* p = [UIBezierPath bezierPath];
    [p moveToPoint:CGPointMake(100,100)];
    [p addLineToPoint:CGPointMake(100, 19)];
    [p setLineWidth:20];
    [p stroke];
    // point of the arrow
    [[UIColor redColor] set];
    [p removeAllPoints];
    [p moveToPoint:CGPointMake(80,25)];
    [p addLineToPoint:CGPointMake(100, 0)];
    [p addLineToPoint:CGPointMake(120, 25)];
    [p fill];
    // snip out triangle in the tail
    [p removeAllPoints];
    [p moveToPoint:CGPointMake(90,101)];
    [p addLineToPoint:CGPointMake(100, 90)];
    [p addLineToPoint:CGPointMake(110, 101)];
    [p fillWithBlendMode:kCGBlendModeClear alpha:1.0];
    
    UIImage* im2 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imView2 = [[UIImageView alloc]initWithImage:im2];
    imView2.center = CGPointMake(self.view.center.x, self.view.center.y + 100);
    [self.view addSubview:imView2];
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 100)];
    lab2.text = @"UIKit";
    lab2.center = CGPointMake(lab2.center.x, imView2.center.y);
    [self.view addSubview:lab2];
}


#pragma mark -
#pragma mark Example clipmasks

- (void) useClipMask {
    [self addBottomButons];
    
    UIImage *image = [UIImage imageNamed:@"dog"];
    CGSize size = CGSizeMake(image.size.width/2, image.size.height/2);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height), NO, 0);
    CGContextRef con = UIGraphicsGetCurrentContext();
    
    //Draw clip mask
    if (!_useComplexMask) {
        //CLIP MASK 1
        CGContextMoveToPoint(con, 0, size.height/2);
        CGContextAddLineToPoint(con, size.width/2, 0);
        CGContextAddLineToPoint(con, size.width, size.height/2);
        CGContextAddLineToPoint(con, size.width/2, size.height);
        CGContextClosePath(con);
    } else {
        //CLIP MASK 2
        CGRect boundingBox = CGContextGetClipBoundingBox(con);
        CGContextAddEllipseInRect(con, boundingBox);
        CGContextAddEllipseInRect(con, CGRectInset(boundingBox, 5, 5));
        CGContextAddEllipseInRect(con, CGRectInset(boundingBox, 10, 10));
        CGContextAddEllipseInRect(con, CGRectInset(boundingBox, 15, 15));
        CGContextAddEllipseInRect(con, CGRectInset(boundingBox, 20, 20));
    }
    
    CGContextEOClip(con);
    //Draw the image
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    //Get the image from current context as UIImage
    UIImage *im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (!self.clipImgView) {
        //If self.clipImgView is not yet initialised we do it and assign context created image
        self.clipImgView = [[UIImageView alloc]initWithImage:im];
        [self.view addSubview:self.clipImgView];
        self.clipImgView.center = self.view.center;
    } else {
        //If clipImgView already initialised, just assign new image
        self.clipImgView.image = im;
    }
    
}

- (void) addBottomButons {
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button1 setTitle:@"Mask 1" forState:UIControlStateNormal];
    [button1 addTarget:self
                action:@selector(mask1ButtonPressed:)
      forControlEvents:UIControlEventTouchUpInside];
    CGFloat width = 80;
    button1.frame = CGRectMake(self.view.center.x - width - 30,
                               self.view.frame.size.height - 60,
                               width,
                               40);
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button2 setTitle:@"Mask 2" forState:UIControlStateNormal];
    [button2 addTarget:self
                action:@selector(mask2ButtonPressed:)
      forControlEvents:UIControlEventTouchUpInside];
    button2.frame = CGRectMake(self.view.center.x + 30,
                               self.view.frame.size.height - 60,
                               width,
                               40);
    
    [self.view addSubview:button1];
    [self.view addSubview:button2];
}


- (void) mask1ButtonPressed: (UIButton *)sender {
    _useComplexMask = NO;
    [self useClipMask];
}

- (void) mask2ButtonPressed: (UIButton *)sender {
    _useComplexMask = YES;
    [self useClipMask];
}

#pragma mark -
#pragma mark Example gradient

- (void) gradientExample {
    // create graphics context
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 150), NO, 0);
    CGContextRef con = UIGraphicsGetCurrentContext();
    
    CGContextAddRect(con, CGRectMake(50,0,100,100));
    CGContextAddRect(con, CGRectMake(0, 100, 200, 50));
    
    //WRAP CLIPPING CODE WITH CGCONTEXTSAVECGSTAT AND CGCONTEXTRESTORECGSTATE
    CGContextSaveGState(con);
    CGContextClip(con);
    // draw the gradient
    CGFloat locs[3] = { 0.0, 0.5, 1.0 };
    CGFloat colors[12] = {
        0.3,0.3,0.3,0.5, // starting color, transparent gray
        0.0,0.0,0.0,1.0, // intermediate color, black
        0.3,0.3,0.3,0.5 // ending color, transparent gray
    };
    CGColorSpaceRef sp = CGColorSpaceCreateDeviceRGB();
    CGGradientRef grad = CGGradientCreateWithColorComponents (sp, colors, locs, 3);
    CGContextDrawLinearGradient (con, grad, CGPointMake(0,0), CGPointMake(200,0), 0);
    CGColorSpaceRelease(sp);
    CGGradientRelease(grad);
    CGContextRestoreGState(con); // done clipping
    
    
    // draw a red strip
    CGContextSetFillColorWithColor(con, [[UIColor redColor] CGColor]);
    CGContextAddRect(con, CGRectMake(50, 70, 100, 30));
    CGContextFillPath(con);
    
    // snip a triangle out of the top by drawing in Clear blend mode
    CGContextMoveToPoint(con, 50, 0);
    CGContextAddLineToPoint(con, 100, 30);
    CGContextAddLineToPoint(con, 150, 0);
    CGContextSetBlendMode(con, kCGBlendModeClear);
    CGContextFillPath(con);
    
    
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imView = [[UIImageView alloc]initWithImage:im];
    imView.center = CGPointMake(self.view.center.x, self.view.center.y);
    [self.view addSubview:imView];
    
}


#pragma mark -
#pragma mark Example pattern

- (void) patternExample {
    // create graphics context
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 150), NO, 0);
    CGContextRef con = UIGraphicsGetCurrentContext();
    
    CGContextAddRect(con, CGRectMake(50,0,100,100));
    CGContextAddRect(con, CGRectMake(0, 100, 200, 50));
    
    //WRAP CLIPPING CODE WITH CGCONTEXTSAVECGSTAT AND CGCONTEXTRESTORECGSTATE
    CGContextSaveGState(con);
    CGContextClip(con);
    // draw the gradient
    CGFloat locs[3] = { 0.0, 0.5, 1.0 };
    CGFloat colors[12] = {
        0.3,0.3,0.3,0.8, // starting color, transparent gray
        0.0,0.0,0.0,1.0, // intermediate color, black
        0.3,0.3,0.3,0.8 // ending color, transparent gray
    };
    CGColorSpaceRef sp = CGColorSpaceCreateDeviceRGB();
    CGGradientRef grad = CGGradientCreateWithColorComponents (sp, colors, locs, 3);
    CGContextDrawLinearGradient (con, grad, CGPointMake(0,0), CGPointMake(200,0), 0);
    CGColorSpaceRelease(sp);
    CGGradientRelease(grad);
    CGContextRestoreGState(con); // done clipping
    
    
    
    //REMOVE NEXT LINE
    //CGContextSetFillColorWithColor(con, [[UIColor redColor] CGColor]);
    CGColorSpaceRef sp2 = CGColorSpaceCreatePattern(nil);
    CGContextSetFillColorSpace (con, sp2);
    CGColorSpaceRelease (sp2);
    CGPatternCallbacks callback = {
        0, drawStripes, nil
    };
    CGAffineTransform tr = CGAffineTransformIdentity;
    CGPatternRef patt = CGPatternCreate(nil,
                                        CGRectMake(0,0,4,4),
                                        tr,
                                        4, 4,
                                        kCGPatternTilingConstantSpacingMinimalDistortion,
                                        true,
                                        &callback);
    CGFloat alph = 1.0;
    CGContextSetFillPattern(con, patt, &alph);
    CGPatternRelease(patt);
    
    CGContextAddRect(con, CGRectMake(50, 70, 100, 30));
    CGContextFillPath(con);
    
    // snip a triangle out of the top by drawing in Clear blend mode
    CGContextMoveToPoint(con, 50, 0);
    CGContextAddLineToPoint(con, 100, 30);
    CGContextAddLineToPoint(con, 150, 0);
    CGContextSetBlendMode(con, kCGBlendModeClear);
    CGContextFillPath(con);
    
    
    
    
    
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imView = [[UIImageView alloc]initWithImage:im];
    imView.center = CGPointMake(self.view.center.x, self.view.center.y);
    [self.view addSubview:imView];
    
}

void drawStripes (void *info, CGContextRef con) {
    // assume 4 x 4 cell
    CGContextSetFillColorWithColor(con, [[UIColor redColor] CGColor]);
    CGContextFillRect(con, CGRectMake(0,0,4,4));
    CGContextSetFillColorWithColor(con, [[UIColor blueColor] CGColor]);
    CGContextFillRect(con, CGRectMake(0,0,4,2));
}

#pragma mark -
#pragma mark Context transform

- (void) transformExample {
    for (int i=0; i < 30; i++) {
        UIImage *im = [self drawShapeInstance:i];
        UIImageView *imView = [[UIImageView alloc]initWithImage:im];
        imView.center = CGPointMake(self.view.center.x, self.view.center.y);
        [self.view addSubview:imView];
    }
}

- (UIImage *) drawShapeInstance:(int)instance {
    // create graphics context
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 200), NO, 0);
    CGContextRef con = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(con, 100, 100);
    //CGContextRotateCTM(con, 10 * 180/M_PI * instance);
    //CGContextTranslateCTM(con, 0, -100);
    CGContextRotateCTM(con, 12 * instance * M_PI/180);
    CGContextTranslateCTM(con, -100, -100);
    
    
    CGContextAddArc(con,
                    100,
                    0,
                    15,
                    0,
                    M_PI_2,
                    NO);
    CGContextSetStrokeColorWithColor(con, [UIColor colorWithRed:0.85 green:0.85 blue:0 alpha:1].CGColor);
    CGContextSetLineWidth(con, 4);
    CGContextStrokePath(con);
    
    
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return im;
}

#pragma mark -
#pragma mark Shadow example

- (void) shadowExample {
    // create graphics context
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(250, 250), NO, 0);
    CGContextRef con = UIGraphicsGetCurrentContext();
    CGContextAddRect(con, CGRectMake(50,0,100,100));
    CGContextAddRect(con, CGRectMake(0, 100, 200, 50));
    CGContextSetShadow(con, CGSizeMake(20, 20), 10);
    CGContextFillPath(con);
    
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imView = [[UIImageView alloc]initWithImage:im];
    imView.center = CGPointMake(self.view.center.x, self.view.center.y);
    [self.view addSubview:imView];
}

@end
