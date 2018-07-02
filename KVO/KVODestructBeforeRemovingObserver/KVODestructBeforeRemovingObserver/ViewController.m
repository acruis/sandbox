//
//  ViewController.m
//  KVODestructBeforeRemovingObserver
//
//  Created by Nguyen Quoc Dat on 11/6/18.
//  Copyright © 2018 Nguyen Quoc Dat. All rights reserved.
//

#import "ViewController.h"

@interface KVOObserver: NSObject

@end

@implementation KVOObserver

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context
{
    NSLog(@"keyPath: %@\nobject: %@\nchange: %@", keyPath, object, change);
}

@end

@interface ViewController ()

@property (nonatomic, strong) KVOObserver *observer;
@property (nonatomic, strong) UIView *target;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.target = [[UIView alloc] initWithFrame:CGRectZero];
    self.observer = [KVOObserver new];
    
    [self.target addObserver:self.observer
                  forKeyPath:@"frame"
                     options:NSKeyValueObservingOptionNew
                     context:&_observer];
    
    [self.target removeObserver:self.observer forKeyPath:@"frame"]; // Comment this line out for EXC_BAD_ACCESS.
    self.observer = nil;
    self.target.frame = CGRectMake(100, 100, 100, 100);
}

@end
