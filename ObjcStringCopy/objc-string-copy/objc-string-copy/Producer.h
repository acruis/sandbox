//
//  Producer.h
//  objc-string-copy
//
//  Created by Nguyen Quoc Dat on 27/8/18.
//  Copyright © 2018 Nguyen Quoc Dat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Holder.h"

@interface Producer : NSObject

- (void)changeNonCopyString;
- (Holder *)produceHolder;

@end
