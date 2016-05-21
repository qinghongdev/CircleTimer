//
//  CycleTimer.h
//  CircleTimer
//
//  Created by QingHong on 16/5/18.
//  Copyright © 2016年 QingHong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CycleTimer : UIView

/* create a cycleTimer object with time that determines total cycle time.
 * unit of time is second */
+ (CycleTimer *)cycleTimerWithFrame:(CGRect)frame totalTime:(NSTimeInterval)time;

/**
 * @abstract set attributes of CycleTimer
 * @param strokeColor:drawing color of outline. Default is black
 * @param fillColor:filling color of rect. Default is nil,that is clear color
 * @param lineWidth:width of line to draw. Default is 2.0
 * @param cycleTime:total timing time,using second unit. Maximum is 99999.
 */
- (void)setStrokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor lineWidth:(CGFloat)lineWidth cycleTime:(NSTimeInterval)cycleTime;

- (BOOL)isCycleTimerPaused;

//control methods
- (void)pauseCycle;
- (void)continueCycle;

- (void)reCycle;

@end
