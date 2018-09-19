//
//  Holder.h
//  objc-string-copy
//
//  Created by Nguyen Quoc Dat on 27/8/18.
//  Copyright © 2018 Nguyen Quoc Dat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Holder : NSObject

@property (nonatomic) NSString *givenString;

- (instancetype)initWithNonCopyString:(NSString *)nonCopyString;

@end
