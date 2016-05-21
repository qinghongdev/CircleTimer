//
//  CycleTimer.m
//  CircleTimer
//
//  Created by QingHong on 16/5/18.
//  Copyright © 2016年 QingHong. All rights reserved.
//

#import "CycleTimer.h"

@interface CycleTimer () {
    CADisplayLink *playLink;
    NSTimer *timer;
    CATextLayer *textLayer;
    NSUInteger countTime;
}

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, assign) NSTimeInterval allTime;

- (void)drawViews;

@end

@implementation CycleTimer

- (void)awakeFromNib {
    [super awakeFromNib];
    [self drawViews];
}

#pragma mark - Class Method
+ (CycleTimer *)cycleTimerWithFrame:(CGRect)frame totalTime:(NSTimeInterval)time {
    CycleTimer *cycleView = [[CycleTimer alloc] initWithFrame:frame];
    cycleView.allTime = time;
    [cycleView drawViews];
    return cycleView;
}

#pragma mark - Public Methods
- (void)setStrokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor lineWidth:(CGFloat)lineWidth cycleTime:(NSTimeInterval)cycleTime {
    if (strokeColor) {
        self.shapeLayer.strokeColor = strokeColor.CGColor;
    }
    if (fillColor) {
        self.shapeLayer.fillColor = fillColor.CGColor;
    }
    if (lineWidth > 0) {
        self.shapeLayer.lineWidth = lineWidth;
    }
    if (cycleTime > 0) {
        self.allTime = cycleTime;
    } else {
        self.allTime = 10;
        countTime = (NSUInteger)self.allTime;
    }
    textLayer.string = [NSString stringWithFormat:@"%lu",countTime];
}

- (BOOL)isCycleTimerPaused {
    if (playLink.isPaused) {
        return YES;
    } else {
        return NO;
    }
}

- (void)pauseCycle {
    [playLink setPaused:YES];
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
}

- (void)setTimer {
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateShowTime) userInfo:nil repeats:YES];
}

- (void)continueCycle {
    [self setTimer];
    [playLink setPaused:NO];
}

- (void)reCycle {
    countTime = (NSUInteger)self.allTime;
    self.shapeLayer.strokeStart = 0.0;
    self.shapeLayer.strokeEnd = 0.0;
    textLayer.string = [NSString stringWithFormat:@"%lu",countTime];
    [self setTimer];
    if (playLink) {
        [playLink invalidate];
        playLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateCircle)];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [playLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        });
    }
}

#pragma mark - Private Methods
- (void)setAllTime:(NSTimeInterval)allTime {
    if (allTime > 0) {
        _allTime = allTime;
        countTime = (NSUInteger)_allTime;
    }
}

- (void)drawViews {
    if (!self.allTime) {
        self.allTime = 10; //set default cycle time:10 seconds
        countTime = (NSUInteger)self.allTime;
    }
    
    self.shapeLayer = [CAShapeLayer layer];
//    self.shapeLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height); //set frame,actually set the width and height
    
    // set default values
    self.shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.shapeLayer.lineWidth = 2.0;

    self.shapeLayer.lineCap = kCALineCapRound;
    self.shapeLayer.fillMode = kCAFillModeBoth;
    self.shapeLayer.strokeStart = 0.0;
    self.shapeLayer.strokeEnd = 0.0;

    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, self.bounds.size.width - 20, self.bounds.size.height - 20)];
    self.shapeLayer.path = circlePath.CGPath; //association
    [self.layer addSublayer:self.shapeLayer]; //add to self's layer
    
    //time display
    textLayer = [CATextLayer layer];
    UIFont *txtFon = [UIFont systemFontOfSize:30.0f];
    textLayer.font = CGFontCreateWithFontName((__bridge CFStringRef)txtFon.fontName);
    textLayer.fontSize = txtFon.pointSize;
    textLayer.foregroundColor = [UIColor orangeColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    textLayer.frame = CGRectMake((self.bounds.size.width - 90) * 0.5, (self.frame.size.height - 30) * 0.5, 90, 30);
    [self.layer addSublayer:textLayer];
    
    if (!playLink) {
        playLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateCircle)];
        [playLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    
   timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateShowTime) userInfo:nil repeats:YES];
}

- (void)updateCircle {
    if (self.shapeLayer.strokeEnd < 1) {
        //the refresh frequency of CADisplaylink is 60Hz.
        self.shapeLayer.strokeEnd += 1 / 60.0 / self.allTime;
    } else if (self.shapeLayer.strokeEnd > 1) {
        [playLink setPaused:YES]; //pause cycle
    }
}

- (void)updateShowTime {
    if (countTime > 0) {
        countTime -= 1;
    } else {
        countTime = 0;
    }
    textLayer.string = [NSString stringWithFormat:@"%lu",countTime];
}

- (void)dealloc {
    [playLink invalidate];
    playLink = nil;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
