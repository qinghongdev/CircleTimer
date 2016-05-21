# CycleTimer

使用CAShapeLayer绘制，CADisplayLink和NSTimer作为定时工具的可视化计时器。

如何使用：
+ (CycleTimer *)cycleTimerWithFrame:(CGRect)frame totalTime:(NSTimeInterval)time;
类方法创建一个定时器，并自动设置计时时间为默认的10s。

- (void)setStrokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor lineWidth:(CGFloat)lineWidth cycleTime:(NSTimeInterval)cycleTime;
设置计时器的指示线颜色、指示线宽度、填充颜色和计时时间等属性。

计时器控制功能API：
- (void)pauseCycle; //暂停计时
- (void)continueCycle; //继续计时
- (void)reCycle; //重新开始计时


