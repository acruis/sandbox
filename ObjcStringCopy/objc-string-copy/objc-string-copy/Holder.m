//
//  Holder.m
//  objc-string-copy
//
//  Created by Nguyen Quoc Dat on 27/8/18.
//  Copyright © 2018 Nguyen Quoc Dat. All rights reserved.
//

#import "Holder.h"

@implementation Holder

- (instancetype)initWithNonCopyString:(NSString *)nonCopyString
{
    self = [super init];
    if (self) {
        _givenString = nonCopyString;
    }
    return self;
}

@end
