//
//  ViewController.m
//  BadAccessSet
//
//  Created by Nguyen Quoc Dat on 22/2/21.
//

#import "ViewController.h"

@interface MyObject : NSObject

@end

@implementation MyObject

@end

@interface MyError : NSError

@end

@implementation MyError

- (void)dealloc
{
    NSLog(@"[nguyenqd] %s:%d %s MyError", __FILE__, __LINE__, __FUNCTION__);
}

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

//    NSError *myError = nil;
//    [self doSetErrorInEnumerateBlock:&myError];

//    NSLog(@"[nguyenqd] %s:%d %s myError %@", __FILE__, __LINE__, __FUNCTION__, myError);

//    NSString *myString = nil;
//    [self doSetStringInEnumerateBlock:&myString];

    MyObject *myObject = nil;
    [self doSetObjectInEnumerateBlock:&myObject];

    self.view.backgroundColor = [UIColor blackColor];
}

- (void)doSetErrorInEnumerateBlock:(NSError * __autoreleasing *)myError
{
//    [@[@(0)] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"myError: %@", *myError);
//        *myError = [MyError errorWithDomain:@"some.domain" code:100 userInfo:nil];
//    }];
//
//    NSLog(@"[nguyenqd] %s:%d %s Nothing", __FILE__, __LINE__, __FUNCTION__);

    [self runABlock:^(id obj, NSUInteger idx, BOOL *stop) {
        *myError = [NSError errorWithDomain:@"some.domain" code:100 userInfo:nil];
    }];
}

- (void)doSetStringInEnumerateBlock:(NSString * __autoreleasing *)myString
{
    [@[@(0)] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        *myString = @"hi";
    }];
}

- (void)doSetObjectInEnumerateBlock:(MyObject * __strong *)myObject
{
    [@[@(0)] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        *myObject = [[MyObject alloc] init];
    }];
}

- (void)runABlock:(void (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))block
{
    BOOL anotherWriteback = NO;
    block(@"Some string", 0, &anotherWriteback);
}

@end
