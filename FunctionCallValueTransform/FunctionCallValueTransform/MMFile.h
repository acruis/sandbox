//
//  MMFile.h
//  FunctionCallValueTransform
//
//  Created by Nguyen Quoc Dat on 11/9/21.
//

#import <Foundation/Foundation.h>
#import "OriginalMMFile.h"

NS_ASSUME_NONNULL_BEGIN

@interface MMFile (UseNumbers)

+ (void)expectTwoNumbersSmallNumberOne:(int32_t)numberOne
                             numberTwo:(uint64_t)numberTwo;

@end

NS_ASSUME_NONNULL_END
