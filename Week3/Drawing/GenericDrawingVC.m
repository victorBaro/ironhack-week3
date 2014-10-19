//
//  GenericDrawingVC.m
//  Drawing
//
//  Created by Victor Baro on 31/05/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "GenericDrawingVC.h"
#import "BezierFace.h"
#import "bFace.h"

@interface GenericDrawingVC () {
    BOOL _centerWithSuperview;
}

@end

@implementation GenericDrawingVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _centerWithSuperview = NO;
    switch (self.exampleNumber) {
        case 0:
            [self tiledImage];
            break;
        case 1:
            [self tiledCenter];
            break;
        case 2:
            [self stretchedCenter];
            break;
        case 3:
            [self slicedAsset];
            break;
        case 4:
            [self animateUIImageView];
            break;
        case 5:
            [self halfImage];
            break;
        case 7:
            [self contextSettings];
            break;
        case 11:
            [self bezierFace];
            break;
        default:
            break;
    }
    
}


- (void)viewDidLayoutSubviews {
    if (_centerWithSuperview) {
        for (UIView *tiled in self.view.subviews) {
            tiled.center = self.view.center;
        }
    }
}

- (void) tiledImage {
    _centerWithSuperview = YES;
    UIImage *image = [UIImage imageNamed:@"Icon-60"];
    UIImage *imageTiled = [image resizableImageWithCapInsets:UIEdgeInsetsZero
                                                resizingMode:UIImageResizingModeTile];
    UIImageView *iView = [[UIImageView alloc]initWithImage:imageTiled];
    [self.view addSubview:iView];
    //iView.frame = self.view.frame;
    CGRect fr = iView.frame;
    fr.size.width *= 3;
    fr.size.height *= 3;
    iView.frame = fr;
    iView.center = self.view.center;
}

- (void) tiledCenter {
    _centerWithSuperview = YES;
    UIImage *image = [UIImage imageNamed:@"Icon-60"];
    UIImage *imageTiled = [image resizableImageWithCapInsets:
                           UIEdgeInsetsMake(18,
                                            0,
                                            18,
                                            0)
                                resizingMode:UIImageResizingModeTile];
    UIImageView *iView = [[UIImageView alloc]initWithImage:imageTiled];
    [self.view addSubview:iView];
    //iView.frame = self.view.frame;
    CGRect fr = iView.frame;
    //fr.size.width *= 1;
    fr.size.height *= 3;
    iView.frame = fr;
    iView.center = self.view.center;
}

- (void) stretchedCenter {
    _centerWithSuperview = YES;
    UIImage *image = [UIImage imageNamed:@"Icon-60"];
    UIImage *imageTiled = [image resizableImageWithCapInsets:
                           UIEdgeInsetsMake(image.size.height/2,
                                            0,
                                            image.size.height/2,
                                            0)
                                                resizingMode:UIImageResizingModeStretch];
    UIImageView *iView = [[UIImageView alloc]initWithImage:imageTiled];
    [self.view addSubview:iView];
    //iView.frame = self.view.frame;
    CGRect fr = iView.frame;
    //fr.size.width *= 1;
    fr.size.height *= 3;
    iView.frame = fr;
    iView.center = self.view.center;
}

- (void) slicedAsset {
    UIImage *image = [UIImage imageNamed:@"button"];
    UIImageView *iView = [[UIImageView alloc]initWithImage:image];
    [self.view addSubview:iView];
    iView.frame = CGRectMake(50, 150, 200, 60);
    
    UIImageView *shadowBox = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shadowbox"]];
    [self.view addSubview:shadowBox];
    shadowBox.frame = CGRectMake(50, 300, 200, 45);
    
    UILabel *textBox = [[UILabel alloc]initWithFrame:shadowBox.bounds];
    textBox.text = @"I am a shadowBox";
    textBox.textAlignment = NSTextAlignmentCenter;
    [shadowBox addSubview:textBox];
}

- (void) animateUIImageView {
    _centerWithSuperview = YES;
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
    NSMutableArray *images = [[NSMutableArray alloc]init];
    for (int i=1; i<7; i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"Ryu_%i",i]];
        [images addObject:img];
    }
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.animationImages = images;
    imgView.animationDuration = 0.4;
    imgView.animationRepeatCount = HUGE_VAL;
    [imgView startAnimating];
    
    [self.view addSubview:imgView];
}

- (void) halfImage {
    _centerWithSuperview = YES;
    UIImage *image = [UIImage imageNamed:@"Icon-60"];
    CGSize size = image.size;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width/2,
                                                      size.height)
                                           , NO, 0);
    [image drawAtPoint:CGPointMake(-size.width/2,0 )];
    UIImage *drawingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *iVew = [[UIImageView alloc]initWithImage:drawingImage];
    [self.view addSubview:iVew];
    
}

- (void) contextSettings {
    //Let's create 2 same circles with diffetent Context settings
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(140,140), NO, 0);
    CGContextRef con1 = UIGraphicsGetCurrentContext();
    
    //Draw path
    CGContextAddEllipseInRect(con1, CGRectMake(0,0,100,100));
    
    //Define context settings - Shadow & fill color
    CGContextSetShadow(con1, CGSizeMake(10, 10), 15.0);
    CGContextSetFillColorWithColor(con1, [UIColor blueColor].CGColor);
    CGContextFillPath(con1);
    
    //Get context into an UIImage
    UIImage* im1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // im is the blue circle image, do something with it here ...
    UIImageView *iView1 = [[UIImageView alloc]initWithImage:im1];
    [self.view addSubview:iView1];
    iView1.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
    
    
    
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100,100), NO, 0);
    CGContextRef con2 = UIGraphicsGetCurrentContext();
    
    //Draw path
    CGContextAddEllipseInRect(con2, CGRectMake(5,5,90,90));

    //Define context settings
    CGContextSetLineWidth(con2, 4);
    CGContextSetStrokeColorWithColor(con2, [UIColor greenColor].CGColor);
    CGContextStrokePath(con2);
    
    //Get context into an UIImage
    UIImage* im2 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *iView2 = [[UIImageView alloc]initWithImage:im2];
    [self.view addSubview:iView2];
    iView2.center = CGPointMake(self.view.center.x, self.view.center.y + 100);

}

- (void) bezierFace {
    BezierFace *bFace = [[BezierFace alloc]initWithFrame:self.view.frame];
    [self.view addSubview:bFace];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0,
                                                           CGRectGetHeight(self.view.frame) - 100,
                                                           self.view.frame.size.width,
                                                            80)];
    lab.text = @"Drag your finger to change my mood";
    lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab];
}


@end
