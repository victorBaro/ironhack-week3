//
//  CAScrollLayerExampleVC.m
//  Layers
//
//  Created by Victor Baro on 11/06/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "CAScrollLayerExampleVC.h"

@interface CAScrollLayerExampleVC ()
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (nonatomic, strong) CAScrollLayer *scrollLayer;
@end

@implementation CAScrollLayerExampleVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubLayers];
}



- (void) initSubLayers {
    self.scrollLayer = [CAScrollLayer layer];
    self.scrollLayer.bounds = CGRectMake(0,
                                         0,
                                         self.view.bounds.size.width * 2,
                                         self.view.bounds.size.height);
    
    self.scrollLayer.backgroundColor = [UIColor flatAmethystColor].CGColor;
    self.scrollLayer.position = CGPointMake(self.view.frame.size.width, self.view.frame.size.height/2);
    
    [self.view.layer insertSublayer:self.scrollLayer below:self.button.layer];
    self.button.tag = 0;
    
    CALayer* lay1 = [CALayer new];
    UIImage* im = [UIImage imageNamed:@"works"];
    CGRect r;
    r.origin = CGPointMake(0,0);
    r.size = im.size;
    lay1.frame = CGRectInset(r, 100, 100);
    lay1.contents = (id)im.CGImage;
    
    lay1.position = CGPointMake(self.view.center.x, self.view.center.y);
    
    [self.scrollLayer addSublayer:lay1];
    
    
    
    CALayer* lay2 = [CALayer new];
    UIImage* im2 = [UIImage imageNamed:@"Best-script"];
    r.origin = CGPointMake(0,0);
    r.size = im2.size;
    lay2.frame = CGRectInset(r, 100, 100);
    lay2.contents = (id)im2.CGImage;
    
    lay2.position = CGPointMake(self.view.center.x + self.view.bounds.size.width, self.view.center.y);
    
    [self.scrollLayer addSublayer:lay2];
    
    
}
- (IBAction)buttonPressed:(UIButton *)sender {
    
    if (self.button.tag == 0) {
        [self.scrollLayer scrollPoint:CGPointMake(self.view.bounds.size.width, 0)];
        self.button.tag = 1;
    } else {
        [self.scrollLayer scrollPoint:CGPointMake(0, 0)];
        self.button.tag = 0;
    }
}

@end
