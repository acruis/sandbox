//
//  ViewController.m
//  IsKindOfClass
//
//  Created by Nguyen Quoc Dat on 31/5/21.
//

#import "ViewController.h"

@interface ViewController ()

@end

@interface MyObject : NSObject

@end

@implementation MyObject

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    MyObject *obj = [[MyObject alloc] init];
    NSLog(@"[nguyenqd] %s:%d %s MyObject %@", __FILE__, __LINE__, __FUNCTION__, @([obj isKindOfClass:[MyObject class]]));
    NSLog(@"[nguyenqd] %s:%d %s NSObject %@", __FILE__, __LINE__, __FUNCTION__, @([obj isKindOfClass:[NSObject class]]));

    Class objClass = [obj class];

    NSLog(@"[nguyenqd] %s:%d %s class MyObject %@", __FILE__, __LINE__, __FUNCTION__, @([objClass isKindOfClass:[MyObject class]]));
    NSLog(@"[nguyenqd] %s:%d %s class NSObject %@", __FILE__, __LINE__, __FUNCTION__, @([objClass isKindOfClass:[NSObject class]]));

    Class strClass = NSClassFromString(@"MyObject");
    NSLog(@"[nguyenqd] %s:%d %s class MyObject %@", __FILE__, __LINE__, __FUNCTION__, @([strClass isKindOfClass:[MyObject class]]));
    NSLog(@"[nguyenqd] %s:%d %s class NSObject %@", __FILE__, __LINE__, __FUNCTION__, @([strClass isKindOfClass:[NSObject class]]));

    Class superClass = [strClass superclass];
    NSLog(@"[nguyenqd] %s:%d %s superclass %@", __FILE__, __LINE__, __FUNCTION__, @([obj isKindOfClass:superClass]));

    NSLog(@"[nguyenqd] %s:%d %s class equal %@", __FILE__, __LINE__, __FUNCTION__, @(objClass == strClass));
}


@end
