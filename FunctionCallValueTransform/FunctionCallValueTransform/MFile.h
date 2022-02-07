//
//  MFile.h
//  FunctionCallValueTransform
//
//  Created by Nguyen Quoc Dat on 11/9/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MFile : NSObject

+ (void)expectTwoNumbersNumberOne:(uint64_t)numberOne
                        numberTwo:(uint64_t)numberTwo
                       someObject:(NSObject *)someObject;

@end

NS_ASSUME_NONNULL_END
