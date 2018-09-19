//
//  ViewController.m
//  objc-string-copy
//
//  Created by Nguyen Quoc Dat on 27/8/18.
//  Copyright © 2018 Nguyen Quoc Dat. All rights reserved.
//

#import "ViewController.h"
#import "Producer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Producer *producer = [Producer new];
    [producer changeNonCopyString];
    Holder *holder = [producer produceHolder];
    NSLog(@"%@", holder.givenString);
}


@end
