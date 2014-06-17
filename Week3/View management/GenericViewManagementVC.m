//
//  ViewController.m
//  ViewManagement
//
//  Created by Victor Baro on 24/05/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#define degreesToRadians(x) (M_PI * x / 180.0)


#import "GenericViewManagementVC.h"
#import "MyButton.h"
#import "MultipleTouchView.h"
#import "DragView.h"

@interface GenericViewManagementVC ()

@end

@implementation GenericViewManagementVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    switch (self.exampleNumber) {
        case 0:
            [self initialExample];
            break;
        case 1:
            [self CGRectUnionExample];
            break;
        case 2:
            [self CGRectDivideExample];
            break;
        case 3:
            [self rotateExample];
            break;
        case 4:
            [self shearExample];
            break;
        case 5:
            [self myButtonExample];
            break;
        case 6:
            [self multipleTouchExample];
            break;
        case 7:
            [self draggViewExample];
            break;
        default:
            
            break;
    }
}



- (void) initialExample {
    CGRect blueViewFrame = CGRectMake(100.0, 100.0, 100.0, 200.0);
    UIView *blueView = [[UIView alloc]initWithFrame:blueViewFrame];
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    
    
    //CGRect greenSubviewFrame = CGRectMake(0, 0, 50.0, 50.0);
    CGRect greenSubviewFrame = CGRectInset(blueView.bounds, 10, 10);
    UIView *greenView = [[UIView alloc] initWithFrame:greenSubviewFrame];
    greenView.backgroundColor = [UIColor greenColor];
    [blueView addSubview:greenView];
    
    CGPoint center = [blueView convertPoint:blueView.center fromView:blueView.superview];
    NSLog(@"Center.x: %f, center.y: %f",center.x, center.y);
    NSLog(@"Center: %@",NSStringFromCGPoint(center));
}

- (void) CGRectUnionExample {
    // CGRectUnion
    CGRect frame1 = CGRectMake(80.0, 100.0, 150.0, 240.0);
    CGRect frame2 = CGRectMake(140.0, 240.0, 120.0, 120.0);
    CGRect frame3 = CGRectUnion(frame1, frame2);
    
    UIView *view1 = [[UIView alloc] initWithFrame:frame1];
    [view1 setBackgroundColor:[UIColor redColor]];
    
    UIView *view2 = [[UIView alloc] initWithFrame:frame2];
    [view2 setBackgroundColor:[UIColor orangeColor]];
    
    UIView *view3 = [[UIView alloc] initWithFrame:frame3];
    [view3 setBackgroundColor:[UIColor grayColor]];
    
    [self.view addSubview:view3];
    [self.view addSubview:view2];
    [self.view addSubview:view1];
}

- (void) CGRectDivideExample {
    // CGRectDivide
    CGRect frame = CGRectMake(10.0, 150.0, 300.0, 300.0);
    CGRect part1;
    CGRect part2;
    CGRectDivide(frame, &part1, &part2, 100.0, CGRectMaxYEdge);
    
    UIView *view1 = [[UIView alloc] initWithFrame:frame];
    [view1 setBackgroundColor:[UIColor grayColor]];
    
    UIView *view2 = [[UIView alloc] initWithFrame:part1];
    [view2 setBackgroundColor:[UIColor orangeColor]];
    
    UIView *view3 = [[UIView alloc] initWithFrame:part2];
    [view3 setBackgroundColor:[UIColor redColor]];
    
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    [self.view addSubview:view3];
    
}

- (void) rotateExample {
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(50,
                                                            120,
                                                            150,
                                                            180)];
    view1.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view1];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectInset(view1.bounds,
                                                             10,
                                                             10)];
    view2.backgroundColor = [UIColor orangeColor];
    [view1 addSubview:view2];
    
    view2.transform = CGAffineTransformMakeRotation(degreesToRadians(45));
    view2.transform = CGAffineTransformTranslate(view2.transform, 100, 0);
    
}

- (void) shearExample {
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(100,
                                                            120,
                                                            150,
                                                            180)];
    view1.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view1];
    
    view1.transform = CGAffineTransformMake(1, 0, -0.2, 1, 0, 0);
}


- (void) myButtonExample {
    
    MyButton *button = [[MyButton alloc] initWithFrame:CGRectMake(100, 150, 100, 50)
                                                 title:@"Button1"
                                                 color:[UIColor flatAmethystColor]];
    [self.view addSubview:button];
    
    MyButton *button2 = [[MyButton alloc] initWithFrame:CGRectMake(20, 300, 290, 40)
                                                 title:@"Button2"
                                                 color:[UIColor colorWithRed:0.0 green:0.4 blue:0.7 alpha:1.0]];
    [self.view addSubview:button2];
    

}

- (void) multipleTouchExample {
    MultipleTouchView *mView = [[MultipleTouchView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:mView];
}

- (void) draggViewExample {
    DragView *dView = [[DragView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:dView];
}

@end
