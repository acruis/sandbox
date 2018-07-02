//
//  ViewController.m
//  WeakStrongDance
//
//  Created by Nguyen Quoc Dat on 19/4/18.
//  Copyright © 2018 Nguyen Quoc Dat. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *someButton;
@property (nonatomic, strong) UIView *someDeadView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     
    [self.view addSubview:self.someButton];
    self.someDeadView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didTapSomeButton:(id)sender
{
    __weak UIView *weakDeadView = self.someDeadView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong UIView *strongDeadView = weakDeadView;
        
//        dispatch_queue_t queue = dispatch_queue_create("queue", nil);
//        dispatch_async(queue, ^{
//            self.someDeadView = nil;
//        });
//
//        [NSThread sleepForTimeInterval:0.5];
        
        self.someDeadView = nil;
        
        NSLog(@"%@", strongDeadView);
        strongDeadView.frame = CGRectMake(100.0f, 100.0f, 100.0f, 100.0f);
        NSLog(@"%.1f", strongDeadView.frame.origin.x);
    });
//    self.someDeadView = nil;
}

- (UIButton *)someButton
{
    if (!_someButton) {
        _someButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_someButton setFrame:CGRectMake(100.0f, 100.0f, 100.0f, 100.0f)];
        [_someButton setTitle:@"Some button" forState:UIControlStateNormal];
        [_someButton addTarget:self
                        action:@selector(didTapSomeButton:)
              forControlEvents:UIControlEventTouchUpInside];
    }
    return _someButton;
}

@end
