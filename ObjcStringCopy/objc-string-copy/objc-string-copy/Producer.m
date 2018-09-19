//
//  Producer.m
//  objc-string-copy
//
//  Created by Nguyen Quoc Dat on 27/8/18.
//  Copyright © 2018 Nguyen Quoc Dat. All rights reserved.
//

#import "Producer.h"

@interface Producer()

@property (nonatomic, copy) NSString *nonCopyString;

@end

@implementation Producer

- (instancetype)init
{
    self = [super init];
    if (self) {
        _nonCopyString = @"Lmao";
    }
    return self;
}

- (void)changeNonCopyString
{
    NSMutableString *mutableString = [@"ABC" mutableCopy];

    self.nonCopyString = mutableString;

    [mutableString setString:@"DEF"];
}

- (Holder *)produceHolder
{
    return [[Holder alloc] initWithNonCopyString:self.nonCopyString];
}

@end
