//
//  DragView.m
//  ViewManagement
//
//  Created by Victor Baro on 31/05/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "DragView.h"

@interface DragView () {
}
@property (nonatomic, strong) UIView *dragView;
@end

@implementation DragView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([touches count] == 1) {
        UITouch *touch = [touches anyObject];
        CGPoint touchPoint = [touch locationInView:self];
        
        for (UIView *view in [self subviews]) {
            if (CGRectContainsPoint(view.frame, touchPoint)) {
                self.dragView = view;
                return;
            }
        }
        
        // Draw a red circle where the touch occurred
        UIView *touchView = [[UIView alloc] init];
        [touchView setBackgroundColor:[UIColor redColor]];
        CGFloat size = 60;
        touchView.frame = CGRectMake(touchPoint.x - size/2, touchPoint.y - size/2, size, size);
        [self addSubview:touchView];
        self.dragView = touchView;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    self.dragView.center = [touch locationInView:self];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    self.dragView.center = [touch locationInView:self];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
