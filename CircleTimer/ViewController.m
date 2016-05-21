//
//  ViewController.m
//  CircleTimer
//
//  Created by QingHong on 16/5/18.
//  Copyright © 2016年 QingHong. All rights reserved.
//

#import "ViewController.h"
#import "CycleTimer.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet CycleTimer *cycleTimer;
@property (weak, nonatomic) IBOutlet UIButton *pauseBtn;
@property (weak, nonatomic) IBOutlet UIButton *continueBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.cycleTimer setStrokeColor:[UIColor redColor] fillColor:nil lineWidth:6.0 cycleTime:20];
    _continueBtn.enabled = NO;
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)pause:(UIButton *)sender {
    [self.cycleTimer pauseCycle];
    _pauseBtn.enabled = NO;
    _continueBtn.enabled = YES;
}

- (IBAction)continueCycle:(UIButton *)sender {
    [self.cycleTimer continueCycle];
    _continueBtn.enabled = NO;
    _pauseBtn.enabled = YES;
}


- (IBAction)recycle:(UIButton *)sender {
    _continueBtn.enabled = NO;
    _pauseBtn.enabled = YES;
    [self.cycleTimer reCycle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
