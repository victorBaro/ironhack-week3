//
//  VBFCountDown.h
//  Reaction
//
//  Created by Victor Baro on 11/05/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CountDownDelegate <NSObject>
- (void) countDownFinished;
@end



@interface VBFCountDown : UIControl
@property (nonatomic, weak) id <CountDownDelegate> delegate;
@property (nonatomic, assign) NSInteger totalSeconds;
- (instancetype)initWithFrame:(CGRect)frame
                countDownTime:(NSInteger)seconds;

- (void)startCountdown;
- (void)stopCountdown;
@end
