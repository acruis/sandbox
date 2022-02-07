//
//  MFile.m
//  FunctionCallValueTransform
//
//  Created by Nguyen Quoc Dat on 11/9/21.
//

#import "MFile.h"

@implementation MFile

+ (void)expectTwoNumbersNumberOne:(uint64_t)numberOne
                        numberTwo:(uint64_t)numberTwo
                       someObject:(NSObject *)someObject
{
    NSLog(@"[MFile] numberOne: %llu numberTwo: %llu", numberOne, numberTwo);
}

@end
