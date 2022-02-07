//
//  MMFile.m
//  FunctionCallValueTransform
//
//  Created by Nguyen Quoc Dat on 11/9/21.
//

#import "MMFile.h"
#import "MFile.h"

@implementation MMFile (UseNumbers)

+ (void)expectTwoNumbersSmallNumberOne:(int32_t)numberOne
                             numberTwo:(uint64_t)numberTwo
{
    NSLog(@"[MMFile] numberOne: %d numberTwo: %lld", numberOne, numberTwo);

    [MFile expectTwoNumbersNumberOne:numberOne numberTwo:numberTwo someObject:@(123)];
}

@end
